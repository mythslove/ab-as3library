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
	import com.addicted2flash.util.AbstractLinkedSet;
	import com.addicted2flash.util.LinkedNode;	

	/**
	 * Implementation of an sequential data-structure based set.
	 * A collection that contains no duplicate elements and at most one null element.
	 * 
	 * @author Tim Richter
	 */
	public class LinkedSet extends AbstractLinkedSet implements ISet
	{
		/**
		 * Create a new <code>LinkedSet</code>
		 */
		public function LinkedSet()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			var clone: LinkedSet = new LinkedSet();
			clone._first = new LinkedNode( _first.value, _first.prev, _first.next );
			clone._length = _length;
			
			return clone;
		}
		
		/**
		 * String representation of <code>LinkedSet</code>.
		 * 
		 * @return String representation of <code>LinkedSet</code>
		 */
		public function toString(): String
		{
			return "[ LinkedSet size=" + size() + " first=" + _first + " last=" + _last + " ]";
		}
	}
}
