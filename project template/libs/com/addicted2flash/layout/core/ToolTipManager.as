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
	import com.addicted2flash.layout.component.ToolTip;
	import com.addicted2flash.layout.core.Component;
	import com.addicted2flash.layout.core.IToolTip;
	import com.addicted2flash.layout.util.LayoutUtil;

	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	/**
	 * This class handles tooltip management of components.
	 * <p>Components can register and unregister for tooltip handling.</p>
	 * 
	 * @author Tim Richter
	 */
	public class ToolTipManager 
	{
		private static const PADDING: int = 10;
		private static const CURSOR_HEIGHT: int = 22;
		private static var _instance: ToolTipManager;

		public static function initialize( stage: Stage ): void
		{
			getInstance().stage = stage;
		}
		
		public static function getInstance(): ToolTipManager
		{
			if( !_instance ) _instance = new ToolTipManager();
			
			return _instance;
		}

		private var _toolTips: Dictionary;
		
		private var _showDelay: Number = 1000;
		private var _hideDelay: Number = 5000;
		private var _switchDelay: Number = 300;

		private var _showTimer: Timer;
		private var _hideTimer: Timer;
		private var _switchTimer: Timer;
		
		private var _enabled: Boolean;
		
		private var _current: IComponent;
		
		private var _toolTip: IToolTip;

		internal var stage: Stage;
		
		/**
		 * Creates a new <code>ToolTipManager</code>.
		 */
		public function ToolTipManager()
		{
			_toolTips = new Dictionary( true );
			
			_toolTip = new ToolTip();
			
			_enabled = true;
			
			_showTimer = new Timer( _showDelay, 1 );
			_hideTimer = new Timer( _hideDelay, 1 );
			_switchTimer = new Timer( _switchDelay, 1 );
			
			_showTimer.addEventListener( TimerEvent.TIMER_COMPLETE, processShowTimerEvent, false, 0, true );
			_hideTimer.addEventListener( TimerEvent.TIMER_COMPLETE, processHideTimerEvent, false, 0, true );
		}
		
		/**
		 * Returns <code>true</code> if tooltips should be shown.
		 * 
		 * @return flag whether tooltips should be shown or not
		 */
		public function get enabled(): Boolean
		{
			return _enabled;
		}
		
		/**
		 * Sets flag whether tooltips should be shown or not.
		 * 
		 * @param value flag whether tooltips should be shown or not
		 */
		public function set enabled( value: Boolean ): void
		{
			_enabled = value;
		}
		
		/**
		 * Returns the current tooltip.
		 * 
		 * @return the current tooltip
		 */
		public function get currentToolTip(): IToolTip
		{
			return _toolTip;
		}
		
		/**
		 * Sets the current tooltip.
		 * 
		 * @param toolTip the current tooltip
		 */
		public function set currentToolTip( toolTip: IToolTip ): void
		{
			_toolTip = toolTip;
			_toolTip.display.mouseEnabled = false;
		}

		/**
		 * Returns the show delay. This delay specifies the duration until
		 * a tooltip will be shown.
		 * 
		 * @return the show delay
		 */
		public function get showDelay(): Number
		{
			return _showDelay;
		}
		
		/**
		 * Sets the show delay. This delay specifies the duration until
		 * a tooltip will be shown.
		 * 
		 * @param value the show delay
		 */
		public function set showDelay( value: Number ): void
		{
			_showDelay = value;
			
			_showTimer.delay = value;
		}

		/**
		 * Returns the hide delay. This delay specifies the duration before
		 * a tooltip will be hidden.
		 * 
		 * @return the hide delay
		 */
		public function get hideDelay(): Number
		{
			return _hideDelay;
		}
		
		/**
		 * Sets the hide delay. This delay specifies the duration before
		 * a tooltip will be hidden.
		 * 
		 * @param value the hide delay
		 */
		public function set hideDelay( value: Number ): void
		{
			_hideDelay = value;
			
			_hideTimer.delay = value;
		}
		
		/**
		 * Returns the switch delay.
		 * 
		 * @return the switch delay
		 * @see #switchDelay
		 */
		public function get switchDelay(): Number
		{
			return _switchDelay;
		}
		
		/**
		 * Sets the switch delay.
		 * <p>When a user moves quickly from one component to another, the
		 * <code>ToolTipManager</code> shows the next tooltip immediately (not
		 * waiting for the duration of <code>showDelay</code>).
		 * 
		 * @param value the switch delay
		 */
		public function set switchDelay( value: Number ): void
		{
			_switchDelay = value;
			
			_switchTimer.delay = value;
		}
		
		/**
		 * Registes the given component for tooltip handling.
		 * 
		 * @param c component
		 */
		public function register( c: Component ): void
		{
			if( _toolTips[ c.display ] ) return;
			
			_toolTips[ c.display ] = c;
			
			c.display.addEventListener( MouseEvent.MOUSE_OVER, processMouseEvent, false, 0, true );
			c.display.addEventListener( MouseEvent.MOUSE_OUT, processMouseEvent, false, 0, true );
			c.display.addEventListener( MouseEvent.MOUSE_DOWN, processMouseEvent, false, 0, true );
		}
		
		/**
		 * Unregistes the given component from tooltip handling.
		 * 
		 * @param c component
		 */
		public function unregister( c: Component ): void
		{
			delete _toolTips[ c.display ];
			
			c.display.removeEventListener( MouseEvent.MOUSE_OVER, processMouseEvent );
			c.display.removeEventListener( MouseEvent.MOUSE_OUT, processMouseEvent );
			c.display.removeEventListener( MouseEvent.MOUSE_DOWN, processMouseEvent );
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString(): String
		{
			return "[ ToolTipManager ]";
		}
		
		private function processMouseEvent( event: MouseEvent ): void
		{
			if( !enabled ) return;
			
			switch( event.type )
			{
				case MouseEvent.MOUSE_OVER:
					_current = getComponent( DisplayObject( event.target ) );
					
					if( _switchTimer.running )
					{
						showToolTip();
					}
					else
					{
						_showTimer.start();
					}
					trace( "over" );
					break;
					
				case MouseEvent.MOUSE_DOWN:
				case MouseEvent.MOUSE_OUT:
					trace( "out" );
					if( _showTimer.running )
					{
						_showTimer.reset();
					}
					else
					{
						hideToolTip();
					}
					break;
			}
		}

		private function processShowTimerEvent( event: TimerEvent ): void
		{
			showToolTip();
		}

		private function processHideTimerEvent( event: TimerEvent ): void
		{
			hideToolTip();
		}
		
		private function showToolTip(): void
		{
			_toolTip.text = _current.toolTipText;
			
			var sw: Number = stage.stageWidth;
			var sh: Number = stage.stageHeight;
			var w: Number = LayoutUtil.getRequiredWidth( _toolTip, sw );
			var h: Number = LayoutUtil.getRequiredHeight( _toolTip, sh );
			var x: Number = stage.mouseX;
			var y: Number = stage.mouseY + CURSOR_HEIGHT;
			
			_toolTip.move( int( x + w > sw ? sw - w - PADDING: x ), int( y + h > sh ? y - CURSOR_HEIGHT - h - PADDING : y ) );
			_toolTip.resize( w, h );
			
			stage.addChild( _toolTip.display );
			
			_hideTimer.start();
		}
		
		private function hideToolTip(): void
		{
			if( stage.contains( _toolTip.display ) )
			{
				stage.removeChild( _toolTip.display );
				
				_switchTimer.reset();
				_switchTimer.start();
				_hideTimer.reset();
			}
		}
		
		private function getComponent( display: DisplayObject ): IComponent
		{
			var c: IComponent;
			
			while( display )
			{
				if( ( c = _toolTips[ display ] ) ) return c;
				
				display = display.parent;
			}
			
			return null;
		}
	}
}
