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
	import com.addicted2flash.util.AbstractLinkedList;		

	/**
	 * Sequential based list. Implements all optional list operations, and permits all elements, including null.
	 * 
	 * @author Tim Richter
	 */
	public class LinkedList extends AbstractLinkedList 
	{
		/**
		 * Create a new <code>LinkedList</code>.
		 */
		public function LinkedList()
		{
			super();
		}
		
		/**
		 * @inheriDoc
		 */
		override public function clone(): ICollection
		{
			var clone: IList = new LinkedList();
			var node: LinkedNode = _first;
			
			while( node != null )
			{
				clone.add( node.value );
				
				node = node.next;
			}
			
			return clone;
		}
		
		/**
		 * @inheriDoc
		 */
		override public function subList( fromIndex: int, toIndex: int ): IList
		{
			var list: LinkedList = new LinkedList();
			
			if( fromIndex >= size() || toIndex < fromIndex || fromIndex == toIndex )
			{
				return list;
			}
			
			var node: LinkedNode = getNodeAt( fromIndex );
			var i: int = 0;
			var diff: int = toIndex - fromIndex;
			
			while( node != null && i < diff )
			{
				list.add( node.value );
				
				node = node.next;
				++i;
			}
			
			return list;
		}

		/**
		 * String representation of <code>LinkedList</code>.
		 * 
		 * @return String representation of <code>LinkedList</code>
		 */
		public function toString(): String
		{
			return "[ LinkedList size=" + size() + " ]";
		}
	}
}
