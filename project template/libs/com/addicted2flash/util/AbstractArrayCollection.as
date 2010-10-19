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
	 * This class provides a skeletal implementation of the ICollection interface for arrays to minimize 
	 * the effort required to implement this interface. 
	 * 
	 * @author Tim Richter
	 */
	public class AbstractArrayCollection implements ICollection 
	{
		protected var _list: Array;
		
		/**
		 * Create a new <code>AbstractArrayCollection</code>
		 * 
		 * @param field (optional) an existing Array
		 */
		public function AbstractArrayCollection( field: Array = null ) 
		{
			clear();
			
			if( field != null )
			{
				internalAddList( field );
			}
		}
		
		/**
		 * return the internal list.
		 * 
		 * @return Array the internal list
		 */
		internal function get list(): Array
		{
			return _list;
		}
		
		/**
		 * @inheritDoc
		 */
		public function add( o: * ): void
		{
			_list[ _list.length ] = o;
		}

		/**
		 * @inheritDoc
		 */
		public function addAll( c: ICollection ): void
		{
			var i: int = 0;
			var n: int = c.size();
			
			for( ; i < n; ++i )
			{
				add( c.getAt( i ) );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt( i: int ): *
		{
			return _list[ i ];
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear(): void
		{
			_list = [];
		}

		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			_list = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function contains( o: * ): Boolean
		{
			return _list.indexOf( o ) > -1;
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
			return size() == 0;
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
			if( !isEmpty() )
			{
				var i: int = _list.indexOf( o );
				
				if( i > -1 )
				{
					_list.splice( i, 1 );
					
					return true;
				}
				else
				{
					return false;
				}
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
			return _list.length;
		}
		
		/**
		 * @inheritDoc
		 */
		public function toArray(): Array
		{
			return _list.slice();
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone(): ICollection
		{
			throw new IllegalOperationError( "abstract instance cannot be cloned!" );
		}
		
		
		/**
		 * @private
		 */
		private function internalAddList( field: Array ): void
		{
			var i: int = 0;
			var n: int = field.length;
			
			for( ; i < n; ++i )
			{
				add( field[ i ] );
			}
		}
		
	}
}
