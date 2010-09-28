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
package com.addicted2flash.layout.util 
{
	import flash.errors.IllegalOperationError;		

	/**
	 * This class encapsulates the width and the height of an object.
	 * 
	 * @author Tim Richter
	 */
	public class Size 
	{
		private var _width: Number;
		private var _height: Number;

		/**
		 * Creates a new <code>Size</code>.
		 * 
		 * @param width width
		 * @param height height
		 * @throws IllegalOperationError if width or height smaller 0
		 */
		public function Size( width: Number = 0, height: Number = 0 )
		{
			this.width = width;
			this.height = height;
		}
		
		/**
		 * Returns the width.
		 * 
		 * @return the width;
		 */
		public function get width(): Number
		{
			return _width;
		}

		/**
		 * Sets the width.
		 * 
		 * @param width the width
		 * @throws IllegalOperationError if width smaller 0
		 */
		public function set width( width: Number ): void
		{
			if( width < 0 ) throw new IllegalOperationError( "width must be bigger or equal zero!" );
			
			_width = width;
		}
		
		/**
		 * Returns the height.
		 * 
		 * @return the height
		 */
		public function get height(): Number
		{
			return _height;
		}

		/**
		 * Sets the height.
		 * 
		 * @param height the height
		 * @throws IllegalOperationError if height smaller 0
		 */
		public function set height( height: Number ): void
		{
			if( height < 0 ) throw new IllegalOperationError( "height must be bigger or equal zero!" );
			
			_height = height;
		}

		/**
		 * Returns a clone of the <code>Size</code>.
		 * 
		 * @return a clone of the <code>Size</code>
		 */
		public function clone(): Size
		{
			return new Size( _width, _height );
		}

		/**
		 * Returns the string representation of the <code>Size</code>.
		 * 
		 * @return the string representation of the <code>Size</code>
		 */
		public function toString(): String 
		{
			return "[ Size width='" + _width + "' height='" + _height + "' ]";
		}
	}
}
