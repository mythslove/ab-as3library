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
	 * Enumeration of data service events.
	 * 
	 * @author Tim Richter
	 */
	public final class DataServiceEvent 
	{
		/**
		 * complete type.
		 */
		public static const COMPLETE: int = 0x001;
		
		/**
		 * input output error type.
		 */
		public static const IO_ERROR: int = 0x002;
		
		/**
		 * security error type.
		 */
		public static const SECURITY_ERROR: int = 0x004;
		
		/**
		 * progress type.
		 */
		public static const PROGRESS: int = 0x008;
		
		/**
		 * http status type.
		 */
		public static const HTTP_STATUS: int = 0x010;
		
		/**
		 * update type (includes all loader service event types).
		 */
		public static const ALL: int = COMPLETE | IO_ERROR | SECURITY_ERROR | PROGRESS | HTTP_STATUS;

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
				case COMPLETE: 			return "complete";
				case IO_ERROR:			return "io error";
				case SECURITY_ERROR:	return "security error";
				case PROGRESS: 			return "progress";
				case HTTP_STATUS:		return "http status";
				case ALL:				return "all";
				default:				throw new IllegalOperationError( "unsupported event!" );
			}
		}
	}
}
