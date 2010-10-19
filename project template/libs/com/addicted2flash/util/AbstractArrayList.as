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
	import com.addicted2flash.util.iterator.ListIterator;	
	
	import flash.errors.IllegalOperationError;	
	
	import com.addicted2flash.util.AbstractArrayCollection;
	import com.addicted2flash.util.IList;
	import com.addicted2flash.util.iterator.IListIterator;   

	/**
	 * This class provides a skeletal implementation of the IList interface for arrays to minimize
	 * the effort required to implement this interface.
	 *
	 * @author Tim Richter
	 */
	public class AbstractArrayList extends AbstractArrayCollection implements IList
	{
		/**
		 * Create a new <code>AbstractArrayList</code>
		 *
		 * @param field an existing Array
		 */
		public function AbstractArrayList( field: Array = null )
		{
			super( field );
		}

		/**
		 * @inheritDoc
		 */
		public function addAt( i: int, o: * ): void
		{
			if( i < size() )
			{
				_list.splice( i, 0, o );
			}
            else
			{
				_list[ i ] = o;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function addAllAt( i: int, c: ICollection ): void
		{
			var a: Array = c.toArray();
			var n: int = a.length;
			
			for( var j: int = 0; j < n; ++j, ++i )
			{
				addAt( i, c.getAt( j ) );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOf( o: * ): int
		{
			return _list.indexOf( o );
		}

		/**
		 * @inheritDoc
		 */
		public function lastIndexOf( o: * ): int
		{
			return _list.lastIndexOf( o );
		}

		/**
		 * @inheritDoc
		 */
		public function removeAt( i: int ): *
		{
			if( i < size() )
			{
				return _list.splice( i, 1 )[ 0 ];
			}
            else
			{
				return null;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeArea( fromIndex: int, toIndex: int ): IList
		{
			return ( fromIndex < toIndex ) ? new ArrayList( _list.splice( fromIndex, toIndex - fromIndex ) ) : null;
		}

		/**
		 * @inheritDoc
		 */
		public function setAt( i: int, o: * ): *
		{
			addAt( i, o );
			
			return removeAt( i + 1 );
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
			var n: int = size();
			
			if( i1 != i2 && i1 < n && i2 < n && i1 > -1 && i2 > -1 )
			{
				_list.splice( i2, 1, _list.splice( i1, 1, _list[ i2 ] )[ 0 ] );
				
				return true;
			}
			
			return false;
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