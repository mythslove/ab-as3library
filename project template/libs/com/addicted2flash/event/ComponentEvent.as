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
	 * Enumeration of component events.
	 * 
	 * @author Tim Richter
	 */
	public final class ComponentEvent 
	{
		/**
		 * When a components state has changed.
		 */
		public static const STATE: int = Identifier.INSTANCE.getId();
		
		/**
		 * If x and/or y of component has changed.
		 */
		public static const POSITION: int = Identifier.INSTANCE.getId();

		/**
		 * If width and/or height of component has changed.
		 */
		public static const SIZE: int = Identifier.INSTANCE.getId();

		/**
		 * If component was added.
		 */
		public static const ADDED: int = Identifier.INSTANCE.getId();

		/**
		 * If component was removed.
		 */
		public static const REMOVED: int = Identifier.INSTANCE.getId();
		
		/**
		 * All component events.
		 */
		public static const ALL: int = STATE | POSITION | SIZE | ADDED | REMOVED;

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
				case STATE:			return "state";
				case POSITION:		return "position";
				case SIZE:			return "size";
				case ADDED:			return "added";
				case REMOVED:		return "removed";
				case ALL:			return "all";
				default:			throw new IllegalOperationError( "unsupported event!" );
			}
		}
	}
}
