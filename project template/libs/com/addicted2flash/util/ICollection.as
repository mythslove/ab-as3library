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
	import com.addicted2flash.util.iterator.IIterator;		

	/**
	 * Interface based on Java-Collection-Framework.
	 * 
	 * This interface also provides <code>getAt( i: int ): *</code> for retrieving elements.
	 * 
	 * @author Tim Richter
	 */
	public interface ICollection extends IDisposable
	{
		/**
		 * Appends the specified element to the end of this list (optional operation).
		 * 
		 * @param o *
		 */
		function add( o: * ): void;
		
		/**
		 * Adds all of the elements in the specified collection to this collection (optional operation).
		 * 
		 * @param c <code>Collection</code> containing elements to be added to this collection
		 */
		function addAll( c: ICollection ): void;
		
		/**
		 * Returns the element at the specified position in this collection.
		 * 
		 * @param i index
		 * @return *
		 */
		function getAt( i: int ): *;
		
		/**
		 * Removes all of the elements from this list (optional operation).
		 */
		function clear(): void;
		
		/**
		 * Returns true if this list contains the specified element.
		 * 
		 * @param o *
		 * @return true if this list contains the specified element.
		 */
		function contains( o: * ): Boolean;
		
		/**
		 * Returns true if this collection contains all of the elements in the specified collection. 
		 * 
		 * @param c <code>Collection</code> collection to be checked for containment in this collection 
		 * @return true if this collection contains all of the elements in the specified collection 
		 */
		function containsAll( c: ICollection ): Boolean;
		
		/**
		 * Returns true if this list contains no elements.
		 * 
		 * @return true if this list contains no elements.
		 */
		function isEmpty(): Boolean;
		
		/**
		 * Returns an iterator over the elements in this list.
		 * 
		 * @return IIterator
		 */
		function iterator(): IIterator;
		
		/**
		 * Removes the first occurrence in this list of the specified element (optional operation).
		 * 
		 * @param o *
		 * @return true if this collection changed as a result of the call 
		 */
		function remove( o: * ): Boolean;
		
		/**
		 * Removes a single instance of the specified element from this collection, if it is present (optional operation)
		 * 
		 * @param c <code>Collection</code> containing elements to be removed from this collection 
		 * @return true if this collection changed as a result of the call 
		 */
		function removeAll( c: ICollection ): Boolean;
		
		/**
		 * Returns the number of elements in this list.
		 * 
		 * @return number of elements in this list.
		 */
		function size(): int;
		
		/**
		 * Converts the collection into an array.
		 * 
		 * @return an array.
		 */
		function toArray(): Array;
		
		/**
		 * Returns a copy of the <code>ICollection</code>.
		 * 
		 * @return a copy of the <code>ICollection</code>
		 */
		function clone(): ICollection;
	}
}
