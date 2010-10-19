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
	 * Enumeration of different scroll policy types.
	 * 
	 * @author Tim Richter
	 */
	public final class ScrollPolicy 
	{
		/**
		 * Scroller will be visible only if container requires it.
		 */
		public static const AUTO: int = 0x001;

		/**
		 * Scroller will be active only if container requires it (but visible).
		 */
		public static const SCROLL: int = 0x002;
		
		/**
		 * Scroller will only cut overflow, but not show scroll components.
		 */
		public static const HIDE: int = 0x004;
		
		/**
		 * Returns the string representation of the given type.
		 * 
		 * @param type type of overflow
		 * @return the string representation of the given type
		 * @throws IllegalOperationError if type is not supported
		 */
		public static function typeToString( type: int ): String
		{
			switch( type )
			{
				case AUTO:		return "auto";
				case SCROLL:	return "scroll";
				case HIDE:		return "hide";
				default:		throw new IllegalOperationError( "unsupported type!" );
			}
		}
	}
}
