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
	import com.addicted2flash.util.iterator.IListIterator;	
	import com.addicted2flash.util.ICollection;	

	/**
	 * The user of this interface has precise control over where in the list each element is inserted. 
	 * The user can access elements by their integer index (position in the list), and search 
	 * for elements in the list.
	 * 
	 * @author Tim Richter
	 */
	public interface IList extends ICollection
	{
		/**
		 * Returns the <code>IListIterator</code> of the <code>IList</code>.
		 * 
		 * @return the <code>IListIterator</code> of the <code>IList</code>
		 */
		function get listIterator(): IListIterator;

		/**
		 * Inserts the specified element at the specified position in this list (optional operation).
		 * 
		 * @param i index
		 * @param o *
		 */
		function addAt( i: int, o: * ): void;
		
		/**
		 * Adds all of the elements in the specified collection to this collection at a specified 
		 * position in this list.
		 * 
		 * @param i index
		 * @param c <code>ICollection</code>
		 */
		function addAllAt( i: int, c: ICollection ): void;
		
		/**
		 * Returns the index in this list of the first occurrence of the specified element, or -1 if this list 
		 * does not contain this element.
		 * 
		 * @param o *
		 * @return index
		 */
		function indexOf( o: * ): int;
		
		/**
		 * Returns the index in this list of the last occurrence of the specified element, or -1 if this list 
		 * does not contain this element.
		 * 
		 * @param o *
		 * @return index
		 */
		function lastIndexOf( o : * ): int;
		
		/**
		 * Removes the element at the specified position in this list (optional operation).
		 * 
		 * @param i index
		 * @return the removed object
		 */
		function removeAt( i: int ): *;
		
		/**
		 * Removes an area in the current list.
		 * 
		 * @param fromIndex low endpoint (including) of the list
		 * @param toIndex high endpoint (excluding) of the list
		 * @return the removed area
		 */
		function removeArea( fromIndex: int, toIndex: int ): IList;
		
		/**
		 * Replaces the element at the specified position in this list with the specified element (optional operation).
		 * 
		 * @param i index
		 * @param o *
		 * @return the replaced object
		 */
		function setAt( i: int, o: * ): *;
		
		/**
		 * Swaps elements. This means that the first element will be tracked 
		 * at the index of the second element and vice versa.
		 * 
		 * @param o1 element
		 * @param o2 element
		 * @return true if elements could be swapped
		 */
		function swap( o1: *, o2: * ): Boolean;
		
		/**
		 * Swaps elements at given indexes. This means that the first element will be tracked 
		 * at the index of the second element and vice versa.
		 * 
		 * @param i1 index of element
		 * @param i2 index of element
		 * @return true if elements could be swapped
		 */
		function swapAt( i1: int, i2: int ): Boolean;
		
		/**
		 * Returns a view of the portion of this list between the specified fromIndex, inclusive, and toIndex, exclusive. 
		 * (If toIndex >= fromIndex, the returned list is empty.) 
		 * 
		 * @param fromIndex low endpoint (including) of the subList
		 * @param toIndex high endpoint (excluding) of the subList
		 * @return a view of the specified range within this list
		 */
		function subList( fromIndex: int, toIndex: int ): IList;
	}
}
