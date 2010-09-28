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
	import com.addicted2flash.util.AbstractLinkedCollection;
	import com.addicted2flash.util.IList;
	import com.addicted2flash.util.iterator.IListIterator;
	import com.addicted2flash.util.iterator.ListIterator;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * This class provides a skeletal implementation of the IList interface for sequential data-structures
	 * to minimize the effort required to implement this interface.
	 * 
	 * @author Tim Richter
	 */
	public class AbstractLinkedList extends AbstractLinkedCollection implements IList 
	{
		/**
		 * Create a new <code>AbstractLinkedList </code>.
		 */
		public function AbstractLinkedList()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAt( i: int, o: * ): void
		{
			if( i == -1 )
			{
				add( o );
			}
			else if( i < _length )
			{
				var n: LinkedNode = getNodeAt( i );
				
				if( n == _first )
				{
					_first = new LinkedNode( o, null, _first );
				}
				else if( n == _last )
				{
					_last = new LinkedNode( o, null, _last );
				}
				else
				{
					n.postAdd( new LinkedNode( o, n, n.next ) );
				}
				
				++_length;
			}
			else
			{
				var j: int = 0;
				var len: int = i - _length;
				
				// -- add null elements
				for( ; j < len; ++j )
				{
					add( null );
				}
				
				add( o );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAllAt( i: int, c: ICollection ): void
		{
			var j: int = 0;
			var len: int = size();
			var n: LinkedNode;
			
			if( i >= len )
			{
				len = i - len;
				
				for( ; j < len; ++j ) add( null );
				
				addAll( c );
			}
			else
			{
				if( i == 0 )
				{
					n = _first = new LinkedNode( c.getAt( j++ ), null, _first );
				}
				else
				{
					n = getNodeAt( i-1 );
				}
				
				len = c.size();
				
				for( ; j < len; ++j )
				{
					n = new LinkedNode( c.getAt( j ), n );
					
					++_length;
				}
			}
		}

		/**
		 * @inheritDoc
		 */
		public function indexOf( o: * ): int
		{
			var n: LinkedNode = _first;
			var i: int = 0;
			
			while( n != null )
			{
				if( n.value == o )
				{
					return i;
				}
				
				++i;
				n = n.next;
			}
			
			return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function lastIndexOf( o: * ): int
		{
			var n: LinkedNode = _last;
			var i: int = _length - 1;
			
			while( n != null )
			{
				if( n.value == o )
				{
					return i;
				}
				
				--i;
				n = n.prev;
			}
			
			return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeAt( i: int ): *
		{
			if( i >= _length || i < 0 )
			{
				return null;
			}
			else
			{
				var n: LinkedNode = getNodeAt( i );
				var v: * = n.value;
				
				removeNode( getNodeAt( i ) );
				
				return v;
			}
		}
		
		/**
		 * @inheriDoc
		 */
		public function swap( o1: *, o2: * ): Boolean
		{
			return swapAt( indexOf( o1 ), indexOf( o2 ) );
		}
		
		/**
		 * @inheriDoc
		 */
		public function swapAt( i1: int, i2: int ): Boolean
		{
			var len: int = size();
			
			if( i1 >= len || i2 >= len || i1 == i2 || i1 < 0 || i2 < 0 ) return false;
			
			var n: LinkedNode = firstNode;
			var n1: LinkedNode;
			
			if( i1 > i2 )
			{
				var tmp: int = i1;
				i1 = i2;
				i2 = tmp;
			}
			
			for( var i: int = 0; i < i2; ++i, n = n.next )
			{
				if( i == i1 ) n1 = n;
			}
			
			var v1: * = n1.value;
			n1.value = n.value;
			n.value = v1;
			
			return true;
		}

		/**
		 * @inheritDoc
		 */
		public function removeArea( fromIndex: int, toIndex: int ): IList
		{
			if( fromIndex >= toIndex || fromIndex == _length ) return null;
			
			if( fromIndex < 0 ) fromIndex = 0;
			if( toIndex > _length ) toIndex = _length;
			
			var list: IList = new LinkedList( );
			
			var i: int = fromIndex;
			var n: LinkedNode = getNodeAt( i );
			var x: LinkedNode;
			
			while( n != null && i++ < toIndex )
			{
				x = n;
				n = n.next;
				
				list.add( x.clearAndCombine() );
			}
			
			if( fromIndex == 0 )
			{
				_first.clearAndCombine();
				_first = n;
			}
			
			if( toIndex == _length )
			{
				_last.clearAndCombine();
			}
			
			_length -= toIndex - fromIndex;
			
			if( _length == 0 )
			{
				_last.dispose();
				_last = null;
			}
			
			return list;
		}

		/**
		 * @inheritDoc
		 */
		public function setAt( i: int, o: * ): *
		{
			if( i < 0 )
			{
				return null;
			}
			else if( i >= _length )
			{
				addAt( i, o );
				
				return null;
			}
			else
			{
				var node: LinkedNode = getNodeAt( i );
				var v: * = node.value;
				
				node.value = o;
				
				return v;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function subList( fromIndex: int, toIndex: int ): IList
		{
			throw new IllegalOperationError( "abstract method needs to be overridden in subclasses!" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get listIterator(): IListIterator
		{
			return new ListIterator( this );
		}
	}
}
