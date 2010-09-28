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
package com.addicted2flash.layout.component 
{
	import com.addicted2flash.layout.core.Component;				

	/**
	 * Encapsulated factory for creating scrollbar components.
	 * 
	 * @author Tim Richter
	 */
	public interface IScrollBarFactory 
	{
		/**
		 * Creates and returns the "up" arrow.
		 * 
		 * @return the "up" arrow
		 */
		function createUpArrow(): Component;
		
		/**
		 * Creates and returns the "down" arrow
		 * 
		 * @return the "down" arrow
		 */
		function createDownArrow(): Component;
		
		/**
		 * Creates and returns the track.
		 * 
		 * @return the track
		 */
		function createTrack(): Component;
		
		/**
		 * Creates and returns the thumb.
		 * 
		 * @return the thumb
		 */
		function createThumb(): Component;
	}
}
