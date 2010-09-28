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
	 * Enumeration of different alignment types.
	 * 
	 * @author Tim Richter
	 */
	public final class Alignment 
	{
		/**
		 * Top alignment.
		 */
		public static const TOP: int = 0x01;
		
		/**
		 * Right alignment.
		 */
		public static const RIGHT: int = 0x02;
		
		/**
		 * Bottom alignment.
		 */
		public static const BOTTOM: int = 0x04;
		
		/**
		 * Left alignment.
		 */
		public static const LEFT: int = 0x08;
		
		/**
		 * Center alignment.
		 */
		public static const CENTER: int = 0x10;
		
		/**
		 * Top-left alignment
		 */
		public static const TOP_LEFT: int = TOP | LEFT;
		
		/**
		 * Top-right alignment
		 */
		public static const TOP_RIGHT: int = TOP | RIGHT;
		
		/**
		 * Bottom-left alignment
		 */
		public static const BOTTOM_LEFT: int = BOTTOM | LEFT;
		
		/**
		 * Bottom-right alignment
		 */
		public static const BOTTOM_RIGHT: int = BOTTOM | RIGHT;
		
		/**
		 * Returns the string representation of the given alignment.
		 * 
		 * @param type type of alignment
		 * @return the string representation of the given alignment
		 * @throws IllegalOperationError if alignment is not supported
		 */
		public static function toString( type: int ): String
		{
			switch( type )
			{
				case TOP:			return "top";
				case RIGHT:			return "right";
				case BOTTOM:		return "bottom";
				case LEFT:			return "left";
				case CENTER:		return "center";
				case TOP_RIGHT: 	return "top-right";
				case TOP_LEFT:		return "top-left";
				case BOTTOM_RIGHT:	return "bottom-right";
				case BOTTOM_LEFT:	return "bottom-left";
				default:			throw new IllegalOperationError( "unsupported alignment!" );
			}
		}
	}
}
