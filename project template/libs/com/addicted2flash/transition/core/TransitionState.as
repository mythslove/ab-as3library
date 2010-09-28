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
package com.addicted2flash.transition.core 
{
	import flash.errors.IllegalOperationError;	
	
	/**
	 * Enumeration of flux states.
	 * 
	 * @author Tim Richter
	 */
	public class TransitionState 
	{
		/**
		 * Running state.
		 */
		public static const RUNNING: int = 0x01;
		
		/**
		 * Pause state.
		 */
		public static const PAUSE: int = 0x02;
		
		/**
		 * Stop state.
		 */
		public static const STOP: int = 0x03;
		
		/**
		 * Complete state.
		 */
		public static const COMPLETE: int = 0x04;
		
		/**
		 * Dispose state.
		 */
		public static const DISPOSE: int = 0x05;

		/**
		 * Returns the string representation of the given flux state.
		 * 
		 * @param state specific state
		 * @return the string representation of the given flux state
		 * @throws IllegalOperationError if state is not supported
		 */
		public static function stateToString( state: int ): String
		{
			switch( state )
			{
				case RUNNING:	return "running";
				case STOP:		return "stop";
				case PAUSE:		return "pause";
				case COMPLETE:	return "complete";
				case DISPOSE:	return "dispose";
				default:		throw new IllegalOperationError( "unsupported state!" );
			}
		}
	}
}
