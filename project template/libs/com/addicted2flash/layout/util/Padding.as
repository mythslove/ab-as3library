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
	/**
	 * This class represents the padding of an object.
	 * 
	 * @author Tim Richter
	 */
	public class Padding  
	{
		public var top: Number;
		public var right: Number;
		public var bottom: Number;
		public var left: Number;
		
		/**
		 * Creates a new <code>Padding</code>.
		 * 
		 * @param top space to the top
		 * @param right space to the right
		 * @param bottom space to the bottom
		 * @param left space to the left
		 */
		public function Padding( top: Number = 0, right: Number = 0, bottom: Number = 0, left: Number = 0 )
		{
			this.top = top;
			this.right = right;
			this.bottom = bottom;
			this.left = left;
		}
		
		/**
		 * Returns the sum of left and right padding.
		 * 
		 * @return the sum of left and right padding
		 */
		public function get horizontal(): int
		{
			return left + right;
		}
		
		/**
		 * Returns the sum of top and bottom padding.
		 * 
		 * @return the sum of top and bottom padding
		 */
		public function get vertical(): int
		{
			return top + bottom;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toString(): String 
		{
			return "[ Padding top='" + top + "' right='" + right + "' bottom='" + bottom + "' left='" + left + "' ]";
		}
	}
}
