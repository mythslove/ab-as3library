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
	import com.addicted2flash.layout.core.Container;
	import com.addicted2flash.layout.core.IContainer;
	import com.addicted2flash.layout.core.LayoutManager;
	import com.addicted2flash.layout.core.ToolTipManager;
	import com.addicted2flash.layout.strategy.BoxLayout;
	import com.addicted2flash.layout.strategy.CanvasLayout;
	import com.addicted2flash.layout.strategy.ILayout;
	import com.addicted2flash.layout.util.Orientation;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;	

	/**
	 * The application class acts as the root of the display list (main class)
	 * in a layout system.
	 * 
	 * @author Tim Richter
	 */
	public class Application extends Sprite 
	{
		/**
		 * Constraint for horizontal layout.
		 */
		public static const HORIZONTAL: int = 0x01;
		
		/**
		 * Constraint for vertical layout.
		 */
		public static const VERTICAL: int = 0x02;
		
		/**
		 * Constraint for absolute layout.
		 */
		public static const ABSOLUTE: int = 0x03;
		
		/**
		 * Constraint for custom layout.
		 */
		public static const CUSTOM: int = 0x04;
		
		private var _container: Container;

		/**
		 * Creates a new <code>Application</code> that acts as the root
		 * of the display list in a layout system.
		 * 
		 * @param type type of layout
		 * @param autoResize true if application should always set its size according to stage resizing
		 * @throws IllegalOperationError if Application is not root of the display list (main class)
		 */
		public function Application( type: int, autoResize: Boolean = true, layout: ILayout = null )
		{
			if( !stage ) throw new IllegalOperationError( "Application class must be the root of the display list!" );
			
			switch( type )
			{
				case HORIZONTAL:
					layout = new BoxLayout( Orientation.HORIZONTAL );
					break;
				case VERTICAL:
					layout = new BoxLayout( Orientation.VERTICAL );
					break;
				case ABSOLUTE:
					layout = new CanvasLayout( );
					break;
				case CUSTOM:
					break;
				default:
					throw new IllegalOperationError( "type of layout not supported!" );
			}
			
			LayoutManager.initialize( stage );
			ToolTipManager.initialize( stage );
			
			addChild( ( _container = new Container( layout ) ).display );
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			if( autoResize )
			{
				stage.addEventListener( Event.RESIZE, onResize );
				onResize( null );
			}
		}

		/**
		 * Returns the layout container of the application.
		 * 
		 * @return the layout container of the application
		 */
		public function get container(): IContainer
		{
			return _container;
		}
		
		/**
		 * Returns the string representation of the <code>Application</code>.
		 * 
		 * @return the string representation of the <code>Application</code>
		 */
		override public function toString(): String
		{
			return "[ Application ]";
		}
		
		/**
		 * @private
		 */
		private function onResize( event: Event ): void
		{
			_container.resize( stage.stageWidth, stage.stageHeight );
		}
	}
}
