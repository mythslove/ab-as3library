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
	import com.addicted2flash.util.iterator.CollectionIterator;
	import com.addicted2flash.util.iterator.IIterator;
	
	import flash.errors.IllegalOperationError;		

	/**
	 * This class provides a skeletal implementation of the ICollection interface for sequential data-structures
	 * (linked list) to minimize the effort required to implement this interface.
	 * 
	 * @author Tim Richter
	 */
	public class AbstractLinkedCollection implements ICollection
	{
		protected var _first: LinkedNode;
		protected var _last: LinkedNode;
		protected var _length: int;
		
		/**
		 * Create a new <code>AbstractLinkedCollection</code>.
		 */
		public function AbstractLinkedCollection() 
		{	
			_length = 0;
		}
		
		/**
		 * return first <code>LinkedNode</code>.
		 * <p></b>NOTE: this method should be only used for traversal of the list. It is not recommended to change data 
		 * with direct access to the nodes.</b></p>
		 * 
		 * @return first <code>LinkedNode</code>
		 */
		public function get firstNode(): LinkedNode
		{
			return _first;
		}
		
		/**
		 * return last <code>LinkedNode</code>.
		 * <p></b>NOTE: this method should be only used for traversal of the list. It is not recommended to change data 
		 * with direct access to the nodes.</b></p>
		 * 
		 * @return last <code>LinkedNode</code>
		 */
		public function get lastNode(): LinkedNode
		{
			return _last;
		}

		/**
		 * @inheritDoc
		 */
		public function add( o: * ): void
		{
			if( _length == 0 )
			{
				_first = _last = new LinkedNode( o );
			}
			else
			{
				_last = new LinkedNode( o, _last );
			}
			
			++_length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAll( c: ICollection ): void
		{
			var i: int = 0;
			var len: int = c.size();
			
			for( ; i < len; ++i )
			{
				add( c.getAt( i ) );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt( i: int ): *
		{
			return ( i >= _length || i < 0 ) ? null : getNodeAt( i ).value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear(): void
		{
			_length = 0;
			
			if( _first != null ) _first.purge();
			
			_first = null;
			_last = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			clear();
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains( o: * ): Boolean
		{
			var n: LinkedNode = _first;
			
			while( n != null )
			{
				if( n.value == o )
				{
					return true;
				}
				
				n = n.next;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsAll( c: ICollection ): Boolean
		{
			var i: int = 0;
			var n: int = c.size();
			
			for( ; i < n; ++i )
			{
				if( !contains( c.getAt( i ) ) )
				{
					return false;
				}
			}
			
			return true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isEmpty(): Boolean
		{
			return _length == 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function iterator(): IIterator
		{
			return new CollectionIterator( this );
		}
		
		/**
		 * @inheritDoc
		 */
		public function remove( o: * ): Boolean
		{
			var n: LinkedNode = _first;
			
			while( n != null )
			{
				if( n.value == o )
				{
					removeNode( n );
					
					return true;
				}
				
				n = n.next;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAll( c: ICollection ): Boolean
		{
			var i: int = 0;
			var n: int = c.size();
			var changed: Boolean = false;
			
			for( ; i < n; ++i )
			{
				changed = remove( c.getAt( i ) );
			}
			
			return changed;
		}
		
		/**
		 * @inheritDoc
		 */
		public function size(): int
		{
			return _length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toArray(): Array
		{
			var tmp: Array = [];
			var n: LinkedNode = _first;
			var i: int = 0;
			
			while( n != null )
			{
				tmp[ i++ ] = n.value;
				
				n = n.next;
			}
			
			return tmp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone(): ICollection
		{
			throw new IllegalOperationError( "abstract instance cannot be cloned!" );
		}
		
		
		/**
		 * return <code>LinkedNode</code> at given index.
		 * 
		 * @param i index
		 * @return indexed <code>LinkedNode</code> ( null if i >= size() )
		 */
		internal function getNodeAt( i: int ): LinkedNode
		{
			if( i >= _length || i < 0 ) return null;
			
			var j: int;
			var n: LinkedNode;
			
			if( (_length >> 1 ) > i )
			{
				j = 0;
				n = _first;
				
				while( n != null && j < i )
				{
					n = n.next;
					++j;
				}
			}
			else
			{
				// -- reverse order traversing
				j = _length - 1;
				n = _last;
				
				while( n != null && j > i )
				{
					n = n.prev;
					--j;
				}
			}
			
			return n;
		}
		
		/**
		 * remove <code>LinkedNode</code>.
		 * 
		 * @param n <code>LinkedNode</code>
		 */
		internal function removeNode( n: LinkedNode ): void
		{
			var x: LinkedNode;
			
			if( n == _first )
			{
				if( n == _last )
				{
					_last.dispose();
					_last = null;
					
					_first.dispose();
					_first = null;
				}
				else
				{
					x = _first.next;
					
					_first.clearAndCombine();
					
					_first = x;
				}
			}
			else if( n == _last )
			{
				x = _last.prev;
				
				_last.clearAndCombine();
				
				_last = x;
			}
			else
			{
				n.clearAndCombine();
			}
			
			--_length;
		}
	}
}
