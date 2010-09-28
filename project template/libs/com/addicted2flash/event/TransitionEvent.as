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
	 * Enumeration class for transition event types.
	 * 
	 * @author Tim Richter
	 */
	public final class TransitionEvent 
	{
		/**
		 * Start event.
		 */
		public static const START: int = 0x0001;
		
		/**
		 * Pause event.
		 */
		public static const PAUSE: int = 0x0002;
		
		/**
		 * Stop event
		 */
		public static const STOP: int = 0x0004;
		
		/**
		 * Resume event.
		 */
		public static const RESUME: int = 0x0008;
		
		/**
		 * Complete event.
		 */
		public static const COMPLETE: int = 0x0010;
		
		/**
		 * Update event.
		 */
		public static const UPDATE: int = 0x0020;

		/**
		 * Returns the string representation of the given type.
		 * 
		 * @param type type of event
		 * @return the string representation of the given type
		 * @throws IllegalOperationError if type is not supported
		 */
		public static function typeToString( type: int ): String
		{
			switch( type )
			{
				case START: 	return "start";
				case PAUSE: 	return "pause";
				case STOP:	 	return "stop";
				case RESUME: 	return "resume";
				case COMPLETE: 	return "complete";
				case UPDATE: 	return "update";
				default:		throw new IllegalOperationError( "unsupported type!" );
			}
		}
	}
}
