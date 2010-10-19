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
	import com.addicted2flash.util.IList;
	import com.addicted2flash.util.iterator.IListIterator;	

	/**
	 * Iterator for traversing <code>IList</code>s.
	 * 
	 * @author Tim Richter
	 */
	public class ListIterator implements IListIterator 
	{
		private var _list: IList;
		private var _pointer: Number;

		/**
		 * Create a new <code>ListIterator</code>.
		 * 
		 * @param list <code>IList</code>
		 */
		public function ListIterator( list: IList )
		{
			_list = list;
			_pointer = -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasPrevious(): Boolean
		{
			return _pointer > 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function previous(): *
		{
			return _list.getAt( --_pointer );
		}
		
		/**
		 * @inheritDoc
		 */
		public function addObject( o: * ): void
		{
			_list.addAt( _pointer, o );
		}
		
		/**
		 * @inheritDoc
		 */
		public function setObject( o: * ): void
		{
			_list.setAt( _pointer, o );
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasNext(): Boolean
		{
			return _pointer < _list.size()-1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next(): *
		{
			return _list.getAt( ++_pointer );
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(): void
		{
			_list.removeAt( _pointer );
		}
	}
}
