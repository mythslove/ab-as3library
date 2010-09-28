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
package com.addicted2flash.data 
{
	/**
	 * Enumeration class for service states.
	 * 
	 * @author Tim Richter
	 */
	public final class ServiceState 
	{
		/**
		 * pause state.
		 */
		public static const READY: int = 0x001;
		
		/**
		 * pause state.
		 */
		public static const PAUSE: int = 0x002;
		
		/**
		 * stop state.
		 */
		public static const STOP: int = 0x004;
		
		/**
		 * running state.
		 */
		public static const RUNNING: int = 0x008;
		
		/**
		 * complete state.
		 */
		public static const COMPLETE: int = 0x010;
		
		/**
		 * error state.
		 */
		public static const ERROR: int = 0x020;
		
		/**
		 * Returns the string representation of given service state.
		 * 
		 * @param state specific type of state
		 * @return the string representation of given service state
		 */
		public static function stateToString( state: int ): String
		{
			switch( state )
			{
				case READY:		return "ready";
				case PAUSE:		return "pause";
				case STOP:		return "stop";
				case RUNNING:	return "running";
				case COMPLETE:	return "complete";
				case ERROR:		return "error";
				default:		return "no state specified";
			}
		}
	}
}
