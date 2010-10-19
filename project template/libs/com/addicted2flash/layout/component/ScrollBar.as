/**
 * Copyright (c) 2008 Tim Richter, www.addicted2flash.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.addicted2flash.layout.component 
{
	import com.addicted2flash.layout.core.IComponent;

	import flash.errors.IllegalOperationError;	
	
	import com.addicted2flash.event.ScrollBarEvent;
	import com.addicted2flash.layout.core.Component;
	import com.addicted2flash.layout.core.Container;
	import com.addicted2flash.layout.util.Orientation;
	import com.addicted2flash.layout.util.Padding;
	import com.addicted2flash.layout.util.LayoutUtil;
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;		

	/**
	 * The <code>ScrollBar</code> contains two arrows, a track and a thumb.
	 * The thumb can be moved by clicking on the track or by dragging the thumb.
	 * 
	 * @author Tim Richter
	 */
	public class ScrollBar extends Container
	{
		private static const DEFAULT_UNIT_INCREMENT: Number = 0.1;
		private static const EPSILON: Number = 0.0001;
		
		private var _up: Component;
		private var _track: Component;
		private var _thumb: Component;
		private var _down: Component;
		
		private var _orientation: int;
		private var _horizontal: Boolean;
		private var _variant: int;
		
		private var _size: Number = 1;
		private var _position: Number = 0;
		private var _unitIncr: Number;
		private var _blockIncr: Number;
		private var _offset: Number;
		
		private var _unit: int;
		private var _block: int;
		
		private var _timer: Timer;
		private var _dir: Number;

		/**
		 * Creates a new <code>ScrollBar</code>.
		 * 
		 * @param factory scrollbar factory
		 * @param orientation orientation
		 * @see Orientation
		 */
		public function ScrollBar( factory: IScrollBarFactory, orientation: int )
		{
			super.addAt( 0, _up = factory.createUpArrow() );
			super.addAt( 1, _down = factory.createDownArrow() );
			super.addAt( 2, _track = factory.createTrack() );
			super.addAt( 3, _thumb = factory.createThumb() );
			
			this.orientation = orientation;
			this.variant = ScrollBarVariant.SINGLE;
			
			display.addEventListener( Event.ADDED_TO_STAGE, processAddedToStageEvent );
			
			_timer = new Timer( 50 );
			_timer.addEventListener( TimerEvent.TIMER, processTimerEvent, false, 0, true );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAt( i: int, c: IComponent, constraint: Object = null ): IComponent
		{
			throw new IllegalOperationError( "components cannot be added to scrollbar!" );
		}

		/**
		 * Returns the orientation of the scrollbar.
		 * 
		 * @return the orientation of the scrollbar
		 * @see Orientation
		 */
		public function get orientation(): int
		{
			return _orientation;
		}

		/**
		 * Sets the orientation of the scrollbar.
		 * 
		 * @param orientation the orientation of the scrollbar
		 * @see Orientation
		 */
		public function set orientation( orientation: int ): void
		{
			_orientation = orientation;
			
			_horizontal = orientation == Orientation.HORIZONTAL;
			
			invalidate();
		}
		
		/**
		 * Returns the scrollbar variant.
		 * 
		 * @return the scrollbar variant
		 * @see ScrollBarVariant
		 */
		public function get variant(): int
		{
			return _variant;
		}
		
		/**
		 * Sets the scrollbar variant.
		 * 
		 * @param variant the scrollbar variant
		 * @see ScrollBarVariant
		 */
		public function set variant( variant: int ): void
		{
			if( _variant == variant ) return;
			
			if( variant != ScrollBarVariant.SINGLE && 
				variant != ScrollBarVariant.DOUBLE_BOTTOM && 
				variant != ScrollBarVariant.DOUBLE_TOP )
			{
				throw new IllegalOperationError( "unsupported scrollbar variant!" );
			}
			
			_variant = variant;
			
			invalidate();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get unitIncrement(): Number
		{
			return _unitIncr ? _unitIncr : _size * DEFAULT_UNIT_INCREMENT;
		}

		/**
		 * @inheritDoc
		 */
		public function set unitIncrement( value: Number ): void
		{
			_unitIncr = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get blockIncrement(): Number
		{
			return _blockIncr ? _blockIncr : _horizontal ? ( _thumb.width >> 1 ): ( _thumb.height >> 1 );
		}

		/**
		 * @inheritDoc
		 */
		public function set blockIncrement( value: Number ): void
		{
			_blockIncr = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get currentUnit(): int
		{
			return _unit;
		}

		/**
		 * @inheritDoc
		 */
		public function get currentBlock(): int
		{
			return _block;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get scrollSize(): Number
		{
			return _size;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set scrollSize( value: Number ): void
		{
			value = value < 0 ? 0 : value > 1 ? 1 : value;
			
			if( _size == value ) return;
			
			_size = value;
			
			if( _size < 1 )
			{
				display.addEventListener( MouseEvent.MOUSE_DOWN, processMouseEvent, false, 0, true );
			}
			else
			{
				display.removeEventListener( MouseEvent.MOUSE_DOWN, processMouseEvent );
			}
			
			arrangeThumb( );
		}

		/**
		 * @inheritDoc
		 */
		public function get scrollPosition(): Number
		{
			return _position;
		}

		/**
		 * @inheritDoc
		 */
		public function set scrollPosition( value: Number ): void
		{
			value = value < 0 ? 0 : value > 1 ? 1 : value;
			
			if( _position == value ) return;
			
			_position = value;
			
			moveThumb();
			
			notifyComponentObservers( ScrollBarEvent.POSITION );
			
			var n: int;
			
			n = int( _position / unitIncrement + EPSILON );
			
			if( _unit != n )
			{
				_unit = n;
				
				notifyComponentObservers( ScrollBarEvent.UNIT );
			}
			
			n = int( _position / blockIncrement + EPSILON );
			
			if( _block != n )
			{
				_block = n;
				
				notifyComponentObservers( ScrollBarEvent.BLOCK );
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function measure(): void
		{
			super.measure();
			
			var p: Padding = padding;
			
			if( _horizontal )
			{
				measuredMinimumWidth = _up.desiredWidth + _down.desiredWidth + p.horizontal;
				measuredMinimumHeight = Math.max( _up.desiredHeight, _down.desiredHeight ) + p.vertical;
			}
			else
			{
				measuredMinimumWidth = Math.max( _up.desiredWidth, _down.desiredWidth ) + p.horizontal;
				measuredMinimumHeight = _up.desiredHeight + _down.desiredHeight + p.vertical;
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function arrange(): void
		{
			var p: Padding = padding;
			var w: Number = width - p.horizontal;
			var h: Number = height - p.vertical;
			
			var xx: Number;
			
			if( _horizontal )
			{
				xx = LayoutUtil.getTileWidth( this, w, 0, 2 );
				
				_up.resize( LayoutUtil.getRequiredWidth( _up, xx ), h );
				_down.resize( LayoutUtil.getRequiredWidth( _down, xx ), h );
				_track.resize( w - _up.width - _down.width, h );
				
				switch( _variant )
				{
					case ScrollBarVariant.SINGLE:
						_up.move( p.left, p.top );
						_track.move( _up.x + _up.width, p.top );
						_down.move( _track.x + _track.width, p.top );
						break;
						
					case ScrollBarVariant.DOUBLE_TOP:
						_up.move( p.left, p.top );
						_down.move( _up.x + _up.width, p.top );
						_track.move( _down.x + _down.width, p.top );
						break;
						
					case ScrollBarVariant.DOUBLE_BOTTOM:
						_track.move( p.left, p.top );
						_up.move( _track.x + _track.width, p.top );
						_down.move( _up.x + _up.width, p.top );
						break;
				}
			}
			else
			{
				xx = LayoutUtil.getTileHeight( this, h, 0, 2 );
				
				_up.resize( w, LayoutUtil.getRequiredHeight( _up, xx ) );
				_down.resize( w, LayoutUtil.getRequiredHeight( _down, xx ) );
				_track.resize( w, h - _up.height - _down.height );
				
				switch( _variant )
				{
					case ScrollBarVariant.SINGLE:
						_up.move( p.left, p.top );
						_track.move( p.left,  _up.y + _up.height );
						_down.move( p.left, _track.y + _track.height );
						break;
						
					case ScrollBarVariant.DOUBLE_TOP:
						_up.move( p.left, p.top );
						_down.move( p.left,  _up.y + _up.height );
						_track.move( p.left, _down.y + _down.height );
						break;
						
					case ScrollBarVariant.DOUBLE_BOTTOM:
						_track.move( p.left, p.top );
						_up.move( p.left, _track.y + _track.height );
						_down.move( p.left,  _up.y + _up.height );
						break;
				}
			}
			
			arrangeThumb();
			
			moveThumb();
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			super.dispose( );
			
			if( _timer )
			{
				_timer.stop();
				_timer.removeEventListener( TimerEvent.TIMER, processTimerEvent );
			}
			
			_timer = null;
			_down = null;
			_up = null;
			_down = null;
			_track = null;
			_thumb = null;
		}

		private function arrangeThumb(): void
		{
			var xx: Number;
			
			if( _horizontal )
			{
				xx = _size * _track.width;
				
				if( xx < _thumb.minimumWidth ) xx = _thumb.minimumWidth;
				
				if( xx < _track.width )
				{
					_thumb.display.visible = true;
					_thumb.resize( xx, _track.height );
				}
				else
				{
					_thumb.display.visible = false;
				}
			}
			else
			{
				xx = _size * _track.height;
				
				if( xx < _thumb.minimumHeight ) xx = _thumb.minimumHeight;
				
				if( xx < _track.height )
				{
					_thumb.display.visible = true;
					_thumb.resize( _track.width, xx );
				}
				else
				{
					_thumb.display.visible = false;
				}
			}
		}
		
		private function processAddedToStageEvent( event: Event ): void
		{
			display.removeEventListener( Event.ADDED_TO_STAGE, processAddedToStageEvent );
			
			display.stage.addEventListener( FocusEvent.MOUSE_FOCUS_CHANGE, processMouseFocusEvent, false, 0, true );
		}

		private function processMouseFocusEvent( event: FocusEvent ): void
		{
			var o: InteractiveObject = event.relatedObject;
			
			if( _size < 1 && o && ( o == parent.display || ( o.parent && ( o.parent == display || o.parent == parent.display ) ) ) )
			{
				display.stage.addEventListener( KeyboardEvent.KEY_DOWN, processKeyboardEvent, false, 0, true );
				display.stage.addEventListener( MouseEvent.MOUSE_WHEEL, processMouseEvent, false, 0, true );
			}
			else
			{
				display.stage.removeEventListener( KeyboardEvent.KEY_DOWN, processKeyboardEvent );
				display.stage.removeEventListener( MouseEvent.MOUSE_WHEEL, processMouseEvent );
			}
		}

		private function processKeyboardEvent( event: KeyboardEvent ): void
		{
			if( orientation == Orientation.HORIZONTAL )
			{
				switch( event.keyCode )
				{
					case Keyboard.LEFT:  
						scrollPosition -= unitIncrement; 
						break;
					case Keyboard.RIGHT: 
						scrollPosition += unitIncrement; 
						break;
				}
			}
			else
			{
				switch( event.keyCode )
				{
					case Keyboard.UP:   
						scrollPosition -= unitIncrement; 
						break;
					case Keyboard.DOWN: 
						scrollPosition += unitIncrement; 
						break;
				}
			}
		}
		
		private function processTimerEvent( event: TimerEvent ): void
		{
			scrollPosition += unitIncrement * _dir; 
		}

		private function processMouseEvent( event: MouseEvent ): void
		{
			switch( event.type )
			{
				case MouseEvent.MOUSE_MOVE:
					updatePosition();
					break;
					
				case MouseEvent.MOUSE_DOWN:
					if( event.target == _up.display || event.target == _down.display )
					{
						_timer.start();
						_dir = event.target == _up.display ? -1 : 1;
						display.addEventListener( MouseEvent.MOUSE_OUT, processMouseEvent, false, 0, true );
						display.stage.addEventListener( MouseEvent.MOUSE_UP, processMouseEvent, false, 0, true );
					}
					else
					{
						storeOffset( DisplayObject( event.target ) );  
						updatePosition( );
						display.stage.addEventListener( MouseEvent.MOUSE_UP, processMouseEvent, false, 0, true );
						display.stage.addEventListener( MouseEvent.MOUSE_MOVE, processMouseEvent, false, 0, true );
					}
					break;
				
				case MouseEvent.MOUSE_OUT:
					_timer.stop();
					_timer.reset();
					display.removeEventListener( MouseEvent.MOUSE_OUT, processMouseEvent );
					break;
					
				case MouseEvent.MOUSE_UP:
					if( event.target == _up.display || event.target == _down.display )
					{
						_timer.stop();
						_timer.reset();
					}
					else
					{
						display.stage.removeEventListener( MouseEvent.MOUSE_UP, processMouseEvent );
						display.stage.removeEventListener( MouseEvent.MOUSE_MOVE, processMouseEvent );
					}
					break;
				
				case MouseEvent.MOUSE_WHEEL:
					scrollPosition = event.delta < 0 ? scrollPosition + unitIncrement : scrollPosition - unitIncrement;
					break;
			}
		}
		
		private function updatePosition(): void
		{
			if( _horizontal )
			{
				scrollPosition = ( display.mouseX + _offset - _track.x ) / ( _track.width - _thumb.width );
			}
			else
			{
				scrollPosition = ( display.mouseY + _offset - _track.y ) / ( _track.height - _thumb.height );
			}
		}

		private function moveThumb(): void
		{
			var p: Padding = padding;
			
			if( _horizontal )
			{
				_thumb.move( _track.x + _position * ( _track.width - _thumb.width ), p.top );
			}
			else
			{
				_thumb.move( p.left, _track.y + _position * ( _track.height - _thumb.height ) );
			}
		}
		
		private function storeOffset( c: DisplayObject ): void
		{
			if( _horizontal )
			{
				_offset = c == _thumb.display ? _thumb.x - display.mouseX : -blockIncrement;
			}
			else
			{
				_offset = c == _thumb.display ? _thumb.y - display.mouseY : -blockIncrement;
			}
		}
	}
}
