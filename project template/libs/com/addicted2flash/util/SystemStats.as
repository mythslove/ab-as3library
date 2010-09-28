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
package com.addicted2flash.util 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;	

	/**
	 * Sprite container that displays the virtual machine, total memory and the frames per second in a box.
	 * <code>NOTE: It is possible to change the displaying textfield.</code>
	 * 
	 * @author Tim Richter
	 */
	public class SystemStats extends Sprite implements IObserver
	{
		private var _tField: TextField;
		private var _header: String;

		/**
		 * Creates a new <code>SystemStats</code> object.
		 */
		public function SystemStats( header: String = null )
		{
			_header = header;
			
			this.textField = createTextField( );
			
			new PerformanceObservable().addObserver( this );
		}
		
		/**
		 * Returns the <code>TextField</code> used to display the application information.
		 * 
		 * @return the <code>TextField</code> used to display the application information
		 */
		public function get textField(): TextField
		{
			return _tField;
		}
		
		/**
		 * Set the <code>TextField</code> used to display the application information.
		 * 
		 * @param textField the <code>TextField</code> used to display the application information
		 */
		public function set textField( textField: TextField ): void
		{
			if( _tField && contains( _tField ) ) removeChild( _tField );
			
			addChild( _tField = textField );
		}
		
		/**
		 * @private
		 */
		public function processUpdate( o: IObservable ): void
		{
			var p: PerformanceObservable = PerformanceObservable( o );
			
			textField.text = ( _header ? _header + "\n" : "" ) + "mem (mb): " + p.megaBytes.toFixed( 4 ) + 
							 "\nfps: " + p.fps;
		}
		
		/**
		 * @private
		 */
		private function createTextField(): TextField
		{
			var t: TextField = new TextField();
			t.autoSize = TextFieldAutoSize.LEFT;
			t.background = true;
			t.selectable = false;
			t.textColor = 0xFFFFFF;
			t.backgroundColor = 0x000000;
			
			return t;
		}

		/**
		 * Returns the string representation of the <code>SystemStats</code>.
		 * 
		 * @return the string representation of the <code>SystemStats</code>
		 */
		override public function toString(): String
		{
			return "[ SystemStats ]";
		}
	}
}
