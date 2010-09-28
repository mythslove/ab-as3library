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
	import com.addicted2flash.util.comparator.IComparator;	
	import com.addicted2flash.util.ISet;
	
	/**
	 * A Set that further provides a total ordering on its elements. The elements are ordered by a Comparator 
	 * provided at sorted set creation time. The set's iterator will traverse the set in ascending element order.
	 * 
	 * @author Tim Richter
	 */
	public interface ISortedSet extends ISet 
	{
		/**
		 * Returns the comparator used to order the elements in this set.
		 * 
		 * @return the comparator used to order the elements in this set.
		 */
		function comparator(): IComparator;
		
		/**
		 * Returns the first (lowest) element currently in this set.
		 * 
		 * @return the first (lowest) element currently in this set (or null if set is empty)
		 */
		function first(): *;
		
		/**
		 * Returns a view of the portion of this set whose elements are strictly less than toElement. 
		 * The returned set is backed by this set, so changes in the returned set are reflected in this set, and vice-versa. 
		 * The returned set supports all optional set operations that this set supports.
		 * 
		 * @param toElement high endpoint (exclusive) of the returned set
		 * @return a view of the portion of this set whose elements are strictly less than toElement (return empty
		 * 			sorted set, if toElement doesn't exist)
		 */
		function headSortedSet( toElement: * ): ISortedSet;
		
		/**
		 * Returns the last (highest) element currently in this set. 
		 * 
		 * @return the last (highest) element currently in this set (or null if set is empty)
		 */
		function last(): *;
		
		/**
		 * Returns a view of the portion of this set whose elements range from fromElement, inclusive, 
		 * to toElement, exclusive. (If fromElement and toElement are equal, the returned set is empty.) 
		 * The returned set is backed by this set, so changes in the returned set are reflected in this set, and vice-versa. 
		 * The returned set supports all optional set operations that this set supports.
		 * 
		 * @param fromElement low endpoint (inclusive) of the returned set
		 * @param toElement high endpoint (exclusive) of the returned set
		 * @return a view of the portion of this set whose elements range from fromElement, inclusive, to toElement, exclusive
		 */
		function subSortedSet( fromElement: *, toElement: * ): ISortedSet;
		
		/**
		 * Returns a view of the portion of this set whose elements are greater than or equal to fromElement. 
		 * The returned set is backed by this set, so changes in the returned set are reflected in this set, and vice-versa. 
		 * The returned set supports all optional set operations that this set supports. 
		 * 
		 * @param fromElement low endpoint (inclusive) of the returned set 
		 * @return a view of the portion of this set whose elements are greater than or equal to fromElement
		 */
		function tailSortedSet( fromElement: * ): ISortedSet;
	}
}
