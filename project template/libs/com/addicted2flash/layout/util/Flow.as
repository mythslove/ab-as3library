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
	 * Enumeration of different flow types.
	 * 
	 * @author Tim Richter
	 */
	public final class Flow 
	{
		/**
		 * Left to right flow.
		 */
		public static const LEFT_TO_RIGHT: int = 0x01;
		
		/**
		 * Right to left flow.
		 */
		public static const RIGHT_TO_LEFT: int = 0x02;
		
		/**
		 * Top to bottom flow.
		 */
		public static const TOP_TO_BOTTOM: int = 0x04;
		
		/**
		 * Bottom to top flow.
		 */
		public static const BOTTOM_TO_TOP: int = 0x08;
		
		/**
		 * Returns the string representation of the given flow.
		 * 
		 * @param type type of flow
		 * @return the string representation of the given flow
		 * @throws IllegalOperationError if flow is not supported
		 */
		public static function toString( type: int ): String
		{
			switch( type )
			{
				case LEFT_TO_RIGHT:	return "left to right";
				case RIGHT_TO_LEFT:	return "right to left";
				case TOP_TO_BOTTOM:	return "top to bottom";
				case BOTTOM_TO_TOP:	return "bottom to top";
				default:			throw new IllegalOperationError( "unsupported flow!" );
			}
		}
	}
}
