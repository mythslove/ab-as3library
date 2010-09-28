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
package com.addicted2flash.util 
{

	/**
	 * A collection designed for holding elements prior to processing.
	 * IQueue implementations generally do not allow insertion of null elements.
	 * 
	 * @author Tim Richter
	 */
	public interface IQueue extends ICollection
	{		
		/**
		 * Retrieves and removes the head of this queue, or returns null if this queue is empty. 
		 * 
		 * @return the head of this queue, or null if this queue is empty
		 */
		function poll(): *;
		
		/**
		 * Retrieves, but does not remove, the head of this queue, or returns null if this queue is empty.
		 * 
		 * @return the head of this queue, or null if this queue is empty
		 */
		function peek(): *;
	}
}
