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
package com.addicted2flash.event 
{
	import flash.errors.IllegalOperationError;

	/**
	 * Enumeration of scrollbar events.
	 * 
	 * @author Tim Richter
	 */
	public final class ScrollBarEvent 
	{
		/**
		 * When the scrollbar has changed its position.
		 */
		public static const POSITION: int = Identifier.INSTANCE.getId();
		
		/**
		 * When the scrollbars unit has incremented or decremented.
		 */
		public static const UNIT: int = Identifier.INSTANCE.getId( );
		
		/**
		 * When the scrollbars block has incremented or decremented.
		 */
		public static const BLOCK: int = Identifier.INSTANCE.getId();

		/**
		 * Returns the string representation of the given event.
		 * 
		 * @param event event
		 * @return the string representation of the given event
		 * @throws IllegalOperationError if event is not supported
		 */
		public static function eventToString( event: int ): String
		{
			switch( event )
			{
				case POSITION:	return "position";
				case UNIT:		return "unit";
				case BLOCK:		return "block";
				default:		throw new IllegalOperationError( "unsupported event!" );
			}
		}
	}
}
