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
	import com.addicted2flash.util.IList;
	
	/**
	 * Interface for <code>Ilist</code> implementations that inform added observers about events.
	 * 
	 * @author Tim Richter
	 */
	public interface IListObservable extends IList 
	{
		/**
		 * Adds an <code>IListObserver</code> to the set of observers for this object, 
		 * provided that it is not the same as some observer already in the set.
		 * 
		 * @param o an <code>IListObserver</code> to be added.
		 */
		function addListObserver( o: IListObserver ): void;
		
		/**
		 * Deletes an <code>IListObserver</code> from the set of observers of this object. 
		 * 
		 * @param o the <code>IListObserver</code> to be deleted.
		 */
		function removeListObserver( o: IListObserver ): void;
		
		/**
		 * Returns the total count of registered <code>IListObserver</code>.
		 * 
		 * @return total count of registered <code>IListObserver</code>s
		 */
		function get listObserverCount(): int;
	}
}
