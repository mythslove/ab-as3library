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
	import com.addicted2flash.layout.core.Component;
	import com.addicted2flash.layout.core.IToolTip;
	
	import flash.filters.DropShadowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;	

	/**
	 * Default implementation of <code>IToolTip</code>.
	 * 
	 * @author Tim Richter
	 */
	public class ToolTip extends Component implements IToolTip
	{
		private var _tField: TextField;

		/**
		 * Creates a new <code>ToolTip</code>.
		 */
		public function ToolTip()
		{
			_tField = new TextField( );
			_tField.autoSize = TextFieldAutoSize.LEFT;
			_tField.defaultTextFormat = new TextFormat( "Verdana", 11, 0x000000 );
			_tField.sharpness = 100;
			_tField.selectable = false;
			_tField.background = true;
			_tField.backgroundColor = 0xffffff;
			_tField.border = true;
			_tField.borderColor = 0x000000;
			
			display.addChild( _tField );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get text(): String
		{
			return _tField.text;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set text( text: String ): void
		{
			_tField.text = text;
			
			display.filters = [ new DropShadowFilter( 2, 45, 0, 0.3 ) ];
			
			measure();
		}

		/**
		 * @inheritDoc
		 */
		override public function measure(): void
		{
			measuredDesiredWidth = _tField.textWidth;
			measuredDesiredHeight = _tField.textHeight;
		}
	}
}
