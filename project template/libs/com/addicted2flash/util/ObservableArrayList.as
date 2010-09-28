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
	import com.addicted2flash.util.event.ListEventType;	
	import com.addicted2flash.util.ArrayList;
	
	/**
	 * Array based list. Implements all optional list operations, and permits all elements, including null.
	 * In addition events will be triggered after list has changed.
	 * 
	 * @author Tim Richter
	 * @see ListEventType
	 */
	public class ObservableArrayList extends ArrayList implements IListObservable
	{
		private var _observers: Array;
		
		/**
		 * Creates a new <code>ObservableArrayList</code>.
		 * 
		 * @param field an existing Array
		 */
		public function ObservableArrayList( field: Array = null )
		{
			super( field );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function add( o: * ): void
		{
			super.add( o );
			
			notifyListObservers( ListEventType.ADD, o );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addAt( i: int, o: * ): void
		{
			super.addAt( i, o );
			
			notifyListObservers( ListEventType.ADD, o );
		}

		/**
		 * @inheritDoc
		 */
		override public function remove( o: * ): Boolean
		{
			if( super.remove( o ) )
			{
				notifyListObservers( ListEventType.REMOVE, o );
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAt( i: int ): *
		{
			var o: * = super.removeAt( i );
			
			if( o )
			{
				notifyListObservers( ListEventType.REMOVE, o );
				
				return o;
			}
			
			return null;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeArea( fromIndex: int, toIndex: int ): IList
		{
			if( fromIndex < toIndex )
			{
				var a: Array = [];
				
				for( var i: int = fromIndex; i < toIndex; ++i )
				{
					a.push( removeAt( i ) );
				}
				
				return new ObservableArrayList( a );
			}
			else
			{
				return null;
			}
		}

		/**
		 * @inheritDoc
		 */
		override public function clear(): void
		{
			if( _list )
			{
				var a: Array = _list.slice();
				
				super.clear( );
				
				notifyListObservers( ListEventType.CLEAR, a );
			}
			else
			{
				super.clear();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			return new ObservableArrayList( toArray() );
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			var a: Array = _list.slice();
			
			super.dispose( );
			
			notifyListObservers( ListEventType.CLEAR, a );
		}

		/**
		 * @inheritDoc
		 */
		public function addListObserver( o: IListObserver ): void
		{
			if( !_observers ) _observers = [];
			else if( _observers.indexOf( o ) > -1 ) return;
			
			_observers.push( o );
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeListObserver( o: IListObserver ): void
		{
			var x: int = _observers.indexOf( o );
			
			if( x < 0 ) return;
			
			_observers.splice( x, 1 );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get listObserverCount(): int
		{
			return _observers ? _observers.length : 0;
		}
		
		/**
		 * String representation of <code>ObservableArrayList</code>.
		 * 
		 * @return String representation of <code>ObservableArrayList</code>
		 */
		override public function toString(): String
		{
			return "[ ObservableArrayList size=" + size() + " ]";
		}
		
		/**
		 * @private
		 */
		private function notifyListObservers( type: int, data: * ): void
		{
			if( !_observers ) return;
			
			var a: Array = _observers.slice();
			var n: int = a.length;
			
			while( --n > -1 )
			{
				IListObserver( a[ n ] ).processListEvent( type, this, data );
			}
		}
	}
}
