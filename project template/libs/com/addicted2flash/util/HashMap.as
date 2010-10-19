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
	import com.addicted2flash.util.IMap;
	
	import flash.utils.Dictionary;	

	/**
	 * Hashtable (Dictionary) based implementation of the IMap interface. This implementation provides all 
	 * of the optional IMap operations, and permits null values and the null key.
	 * 
	 * @author Tim Richter
	 */
	public class HashMap implements IMap 
	{
		protected var _keyMap: Dictionary;
		protected var _first: Entry;
		protected var _count: int;

		/**
		 * Create a new <code>HashMap</code>
		 */
		public function HashMap() 
		{
			_keyMap = new Dictionary();
			
			_count = 0;
		}
		
		/**
		 * return first <code>Entry</code>.
		 * 
		 * @return first <code>Entry</code>
		 */
		public function get firstEntry(): Entry
		{
			return _first;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clear(): void
		{
			_keyMap = new Dictionary();
			
			_first.dispose();
			_first = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsKey( key: * ): Boolean
		{
			return _keyMap[ key ] != null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function containsValue( value: * ): Boolean
		{
			var e: Entry = _first;
			
			while( e != null )
			{
				if( e.value == value )
				{
					return true;
				}
				
				e = e.next;
			}
			
			return false;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getValue( key: * ): *
		{
			var entry: Entry = _keyMap[ key ];
			
			return entry != null ? entry.value : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function isEmpty(): Boolean
		{
			return _count == 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function put( key: *, value: * ): *
		{
			var old: Entry = _keyMap[ key ];
			
			if( old != null )
			{
				var v: * = old.value;
				
				old.value = value;
				
				return v;
			}
			else
			{
				++_count;
				
				_keyMap[ key ] = _first = new Entry( key, value, _first );
				
				return value;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function remove( key: * ): *
		{
			var removed: Entry = _keyMap[ key ];
			
			if( removed != null )
			{
				var v: * = removed.value;
				
				if( removed == _first )
				{
					var n: Entry = _first.next;
					_first.dispose();
					_first = n;
				}
				else
				{
					removed.clearAndCombine();
				}
				
				delete _keyMap[ key ];
				
				--_count;
				
				return v;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function size(): int
		{
			return _count;
		}
		
		/**
		 * @inheritDoc
		 */
		public function values(): ICollection
		{
			var c: ICollection = new ArrayList();
			var e: Entry = _first;
			
			while( e != null )
			{
				c.add( e.value );
				
				e = e.next;
			}
			
			return c;
		}
		
		/**
		 * @inheritDoc
		 */
		public function keySet(): ISet
		{
			var s: ISet = new ArraySet();
			var e: Entry = _first;
			
			while( e != null )
			{
				s.add( e.key );
				
				e = e.next;
			}
			
			return s;
		}
		
		/**
		 * @inheritDoc
		 */
		public function entrySet(): ISet
		{
			var s: ISet = new ArraySet();
			var e: Entry = _first;
			
			while( e != null )
			{
				s.add( e );
				
				e = e.next;
			}
			
			return s;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone(): IMap
		{
			var clone: HashMap = new HashMap();
			
			var e: Entry = _first;
			
			while( e != null )
			{
				clone.put( e.key, e.value );
				
				e = e.next;
			}
			
			return clone;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			_keyMap = null;
			_first = null;
		}
		
		/**
		 * String representation of the <code>HashMap</code>.
		 * 
		 * @return String representation of the <code>HashMap</code>
		 */
		public function toString(): String
		{
			return "[ HashMap size=" + size() + " ]";
		}
	}
}
