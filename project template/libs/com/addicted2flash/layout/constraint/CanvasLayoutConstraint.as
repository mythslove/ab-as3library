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
package com.addicted2flash.layout.constraint 
{
	/**
	 * Contraint for components added to a <code>Canvas</code>.
	 * 
	 * @author Tim Richter
	 */
	public final class CanvasLayoutConstraint 
	{
		/**
		 * Distance to the top.
		 */
		public var top: Number;
		
		/**
		 * Distance to the right. 
		 */
		public var right: Number;
		
		/**
		 * Distance to the bottom.
		 */
		public var bottom: Number;
		
		/**
		 * Distance to the left. 
		 */
		public var left: Number;
		
		/**
		 * Creates a new <code>CanvasLayoutConstraint</code>.
		 * 
		 * @param top distance to the top
		 * @param right distance to the right
		 * @param bottom distance to the bottom
		 * @param left distance to the left
		 */
		public function CanvasLayoutConstraint( top: Number = NaN, right: Number = NaN, bottom: Number = NaN, left: Number = NaN )
		{
			this.top = top;
			this.right = right;
			this.bottom = bottom;
			this.left = left;
		}
		
		/**
		 * Returns the string representation of the <code>CanvasLayoutConstraint</code>.
		 * 
		 * @return the string representation of the <code>CanvasLayoutConstraint</code>
		 */
		public function toString(): String
		{
			return "[ CanvasLayoutConstraint top='" + top + "' rigth='" + right + "' bottom='" + bottom + "' left='" + left + "' ]";
		}
	}
}
