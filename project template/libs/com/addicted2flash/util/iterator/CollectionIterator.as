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
	import com.addicted2flash.util.ICollection;	
	import com.addicted2flash.util.iterator.IIterator;
	
	/**
	 * Iterator for traversing <code>ICollection</code>s.
	 * 
	 * @author Tim Richter
	 */
	public class CollectionIterator implements IIterator 
	{
		protected var _collection: ICollection;
		protected var _field: Array;
		protected var _count: int;
		protected var _n: int;

		/**
		 * Create a new <code>CollectionIterator</code>.
		 * 
		 * @param c <code>ICollection</code>
		 */
		public function CollectionIterator( c: ICollection )
		{
			_collection = c;
			_field = c.toArray();
			_n = _field.length;
			
			_count = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function hasNext(): Boolean
		{
			return _count != _n;
		}
		
		/**
		 * @inheritDoc
		 */
		public function next(): *
		{
			return _field[ _count++ ];
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove(): void
		{
			_collection.remove( _field[ _count ] );
		}
	}
}
