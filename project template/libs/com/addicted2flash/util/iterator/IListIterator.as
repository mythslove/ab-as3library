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
package com.addicted2flash.util.iterator 
{
	import com.addicted2flash.util.iterator.IIterator;

	/**
	 * Interface for traversing <code>IList</code> data-structures.
	 * 
	 * @author Tim Richter
	 */
	public interface IListIterator extends IIterator 
	{
		/**
		 * Retrieves boolean flag whether the <code>IListIterator</code> has
		 * a previous object in its list
		 * 
		 * @return Boolean  flag whether the <code>IListIterator</code> has
		 * 					a previous object in its list
		 */
		function hasPrevious(): Boolean;
		
		/**
		 * Retrieves previous object in data-structure
		 * 
		 * @return * previous object in data-structure
		 */
		function previous(): *;
		
		/**
		 * Inserts the specified element into the list. 
		 * The element is inserted immediately before the next element that would 
		 * be returned by next, if any, and after the next element that would be 
		 * returned by previous, if any. (If the list contains no elements, the 
		 * new element becomes the sole element on the list.) 
		 * 
		 * @param o *
		 */
		function addObject( o: * ): void;
		
		/**
		 * Replaces the last element returned by next or previous with the specified 
		 * element. This call can be made only if neither 
		 * ListIterator.remove nor ListIterator.add have been called after the 
		 * last call to next or previous. 
		 * 
		 * @param o *
		 */
		function setObject( o: * ): void;
	}
}
