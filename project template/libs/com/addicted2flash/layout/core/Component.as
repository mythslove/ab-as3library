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
package com.addicted2flash.layout.core
{
	import com.addicted2flash.event.ComponentEvent;
	import com.addicted2flash.layout.core.ComponentObserverWrapper;
	import com.addicted2flash.layout.core.IComponent;
	import com.addicted2flash.layout.core.IComponentObserver;
	import com.addicted2flash.layout.core.IContainer;
	import com.addicted2flash.layout.state.ComponentState;
	import com.addicted2flash.layout.util.Alignment;
	import com.addicted2flash.layout.util.Padding;

	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * The Component class is an abstract basic in the layout framework.
	 * 
	 * @author Tim Richter
	 */
	public class Component implements IComponent
	{
		private var _layoutManager: LayoutManager;
		
		private var _observers: Dictionary;
		private var _parent: IContainer;
		private var _display: Sprite;
		
		private var _padding: Padding;
		private var _constraint: Object;
		
		private var _x: Number = 0;
		private var _y: Number = 0;
		
		private var _width: Number;
		private var _height: Number;
		
		private var _desWidth: Number;
		private var _desHeight: Number;
		
		private var _desPercWidth: Number;
		private var _desPercHeight: Number;
		
		private var _minWidth: Number;
		private var _minHeight: Number;
		
		private var _maxWidth: Number = int.MAX_VALUE;
		private var _maxHeight: Number = int.MAX_VALUE;
		
		private var _mesDesWidth: Number = 0;
		private var _mesDesHeight: Number = 0;
		
		private var _mesMinWidth: Number = 0;
		private var _mesMinHeight: Number = 0;
		
		private var _horizontalAlignment: int;
		private var _verticalAlignment: int;
		
		private var _toolTipText: String;
		
		private var _state: int;
		private var _depth: int;
		
		//-- LAYOUTMANAGER
		internal var invalidatePhase: Boolean;
		internal var parentClient: Component;
		internal var next: Component;
		internal var prev: Component;

		/**
		 * Creates a new <code>Component</code>.
		 * 
		 * @param display corresponding sprite
		 */
		public function Component( display: Sprite = null )
		{
			_display = display || new Sprite( );
			_padding = new Padding( );
			
			_layoutManager = LayoutManager.getInstance();
			_horizontalAlignment = Alignment.LEFT;
			_verticalAlignment = Alignment.TOP;
			_state = ComponentState.ENABLED;
			
			_display.addEventListener( Event.ADDED_TO_STAGE, processStageEvent );
			_display.addEventListener( Event.REMOVED_FROM_STAGE, processStageEvent );
		}

		/**
		 * @inheritDoc
		 */
		public function get display(): Sprite
		{
			return _display;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get parent(): IContainer
		{
			return _parent;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set parent( parent: IContainer ): void
		{
			_parent = parent;
			parentClient = _parent as Component; 
			notifyComponentObservers( parent ? ComponentEvent.ADDED : ComponentEvent.REMOVED );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get toolTipText(): String
		{
			return _toolTipText;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set toolTipText( text: String ): void
		{
			_toolTipText = text;
		}

		/**
		 * @inheritDoc
		 */
		public function get state(): int
		{
			return _state;
		}

		/**
		 * @inheritDoc
		 */
		public function set state( state: int ): void
		{
			if( _state == state ) return;
			
			_state = state;
			
			notifyComponentObservers( ComponentEvent.STATE );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get depth(): int
		{
			return _depth;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get horizontalAlignment(): int
		{
			return _horizontalAlignment;
		}

		/**
		 * @inheritDoc
		 */
		public function set horizontalAlignment( alignment: int ): void
		{
			if( _horizontalAlignment == alignment ) return;
			
			if( alignment != Alignment.LEFT && alignment != Alignment.RIGHT && alignment != Alignment.CENTER )
			{
				throw new IllegalOperationError( "unsupported alignment!" );
			}
			
			_horizontalAlignment = alignment;
			
			invalidate();
		}

		/**
		 * @inheritDoc
		 */
		public function get verticalAlignment(): int
		{
			return _verticalAlignment;
		}

		/**
		 * @inheritDoc
		 */
		public function set verticalAlignment( alignment: int ): void
		{
			if( _verticalAlignment == alignment ) return;
			
			if( alignment != Alignment.TOP && alignment != Alignment.BOTTOM && alignment != Alignment.CENTER )
			{
				throw new IllegalOperationError( "unsupported alignment!" );
			}
			
			_verticalAlignment = alignment;
			
			invalidate();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get padding(): Padding
		{
			return _padding;
		}

		/**
		 * @inheritDoc
		 */
		public function set padding( padding: Padding ): void
		{
			_padding = padding;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get constraint(): Object
		{
			return _constraint;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set constraint( constraint: Object ): void
		{
			_constraint = constraint;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get x(): Number
		{
			return _x;
		}

		/**
		 * @inheritDoc
		 */
		public function set x( value: Number ): void
		{
			move( value, y );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get y(): Number
		{
			return _y;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set y( value: Number ): void
		{
			move( x, value );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get width(): Number
		{
			return !isNaN( _width ) ? _width : desiredWidth;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set width( value: Number ): void
		{
			resize( value, height );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get height(): Number
		{
			return !isNaN( _height ) ? _height : desiredHeight;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set height( value: Number ): void
		{
			resize( width, value );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get hasDesiredPercentWidth(): Boolean
		{
			return !isNaN( _desPercWidth );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get hasDesiredPercentHeight(): Boolean
		{
			return !isNaN( _desPercHeight );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get desiredPercentWidth(): Number
		{
			return _desPercWidth;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set desiredPercentWidth( value: Number ): void
		{
			value = value < 0 ? 0 : value > 1 ? 1 : value;
			
			if( _desPercWidth == value ) return;
			
			_desPercWidth = value;
			_desWidth = NaN;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get desiredPercentHeight(): Number
		{
			return _desPercHeight;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set desiredPercentHeight( value: Number ): void
		{
			value = value < 0 ? 0 : value > 1 ? 1 : value;
			
			if( _desPercHeight == value ) return;
			
			_desPercHeight = value;
			_desHeight = NaN;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get desiredWidth(): Number
		{
			return !isNaN( _desWidth ) ? _desWidth : _mesDesWidth < _mesMinWidth ? _mesMinWidth : _mesDesWidth;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set desiredWidth( value: Number ): void
		{
			if( _desWidth == value ) return;
			
			_desWidth = value;
			_desPercWidth = NaN;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get desiredHeight(): Number
		{
			return !isNaN( _desHeight ) ? _desHeight : _mesDesHeight < _mesMinHeight ? _mesMinHeight : _mesDesHeight;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set desiredHeight( value: Number ): void
		{
			if( _desHeight == value ) return;
			
			_desHeight = value;
			_desPercHeight = NaN;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get minimumWidth(): Number
		{
			return !isNaN( _minWidth ) ? _minWidth : _mesMinWidth;
		}

		/**
		 * @inheritDoc
		 */
		public function set minimumWidth( value: Number ): void
		{
			if( _minWidth == value ) return;
			
			_minWidth = value;
			
			invalidateTree();
		}

		/**
		 * @inheritDoc
		 */
		public function get minimumHeight(): Number
		{
			return !isNaN( _minHeight ) ? _minHeight : _mesMinHeight;
		}

		/**
		 * @inheritDoc
		 */
		public function set minimumHeight( value: Number ): void
		{
			if( _minHeight == value ) return;
			
			_minHeight = value;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get maximumWidth(): Number
		{
			return _maxWidth;
		}

		/**
		 * @inheritDoc
		 */
		public function set maximumWidth( value: Number ): void
		{
			if( _maxWidth == value ) return;
			
			_maxWidth = value;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get maximumHeight(): Number
		{
			return _maxHeight;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set maximumHeight( value: Number ): void
		{
			if( _maxHeight == value ) return;
			
			_maxHeight = value;
			
			invalidateTree();
		}
		
		/**
		 * @inheritDoc
		 */
		public function get measuredMinimumWidth(): Number
		{
			return _mesMinWidth;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set measuredMinimumWidth( value: Number ): void
		{
			_mesMinWidth = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get measuredMinimumHeight(): Number
		{
			return _mesMinHeight;
		}

		/**
		 * @inheritDoc
		 */
		public function set measuredMinimumHeight( value: Number ): void
		{
			_mesMinHeight = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get measuredDesiredWidth(): Number
		{
			return _mesDesWidth;
		}

		/**
		 * @inheritDoc
		 */
		public function set measuredDesiredWidth( value: Number ): void
		{
			_mesDesWidth = value;
		}

		/**
		 * @inheritDoc
		 */
		public function get measuredDesiredHeight(): Number
		{
			return _mesDesHeight;
		}

		/**
		 * @inheritDoc
		 */
		public function set measuredDesiredHeight( value: Number ): void
		{
			_mesDesHeight = value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function move( x: Number, y: Number ): void
		{
			if( _x != x || _y != y )
			{
				_x = x; _y = y;
				
				_display.x = x; _display.y = y;
				
				notifyComponentObservers( ComponentEvent.POSITION );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function resize( width: Number, height: Number ): void
		{
			if( _width != width || _height != height )
			{
				_width = width; _height = height;
				
				notifyComponentObservers( ComponentEvent.SIZE );
				
				invalidate();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function invalidate(): void
		{
			if( invalidatePhase || !depth ) return;
			
			_layoutManager.invalidate( this );
		}
		
		/**
		 * @inheritDoc
		 */
		public function invalidateTree(): void
		{
			if( invalidatePhase || !depth ) return;
			
			_layoutManager.invalidateTree( this );
		}
		
		/**
		 * @inheritDoc
		 */
		public function addComponentObserver( o: IComponentObserver, events: int ): void
		{
			if( !events ) return;
			
			if( !_observers )
			{
				_observers = new Dictionary( true );
			}
			else if( _observers[ o ] != null )
			{
				_observers[ o ].events = events;
				
				return;
			}
			
			_observers[ o ] = new ComponentObserverWrapper( o, events );
		}

		/**
		 * @inheritDoc
		 */
		public function removeComponentObserver( o: IComponentObserver ): void
		{
			if( !_observers ) return;
			
			delete _observers[ o ];
			
			for each( var w: ComponentObserverWrapper in _observers ) { w; return; };
			
			_observers = null;
		}

		/**
		 * @inheritDoc
		 */
		public function addToRegisteredEvents( o: IComponentObserver, events: int ): void
		{
			if( !_observers ) return;
			
			var w: ComponentObserverWrapper = _observers[ o ];
			
			if( w ) w.events |= events;
		}

		/**
		 * @inheritDoc
		 */
		public function removeFromRegisteredEvents( o: IComponentObserver, events: int ): void
		{
			if( !_observers ) return;
			
			var w: ComponentObserverWrapper = _observers[ o ];
			
			if( w ) w.events &= ~events;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getRegisteredEvents( o: IComponentObserver ): int
		{
			if( !_observers ) return 0;
			
			var w: ComponentObserverWrapper = _observers[ o ];
			
			return w ? w.events : 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function notifyComponentObservers( event: int ): void
		{
			if( !event || !_observers ) return;
			
			var i: int;
			
			for each( var w: ComponentObserverWrapper in _observers )
			{
				if( ( i = w.events & event ) ) w.observer.processEvent( i, this );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function measure(): void
		{
			_mesDesWidth = _mesDesHeight = 0;
			_mesMinWidth = _mesMinHeight = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function arrange(): void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			if( _parent ) _parent.remove( this );
			
			_observers = null;
			_padding = null;
			_constraint = null;
			_display = null;
			_observers = null;
			_layoutManager = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString(): String
		{
			return "[ Component ]";
		}
		
		/**
		 * @private
		 */
		internal function get useMeasuredSizes(): Boolean
		{
			return( isNaN( _desWidth ) && isNaN( _desPercWidth ) ) || 
				  ( isNaN( _desHeight ) && isNaN( _desPercHeight ) ) ||
				  ( isNaN( _minWidth ) && isNaN( _minHeight ) );
		}
		
		private function processStageEvent( event: Event ): void
		{
			if( event.type == Event.ADDED_TO_STAGE )
			{
				_depth = _parent ? _parent.depth + 1 : 1;
			}
			else
			{
				_depth = 0;
			}
			
			invalidate( );
		}
	}
}
