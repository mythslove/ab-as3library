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
	import com.addicted2flash.util.LinkedNode;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * The <code>LinkedStack</code> class represents a last-in-first-out (LIFO) stack of elements
	 * implemented with Sequential structure.
	 * 
	 * @author Tim Richter
	 */
	public class LinkedStack extends AbstractLinkedCollection implements IStack
	{
		/**
		 * Create a new <code>LinkedStack</code>
		 */
		public function LinkedStack()
		{
			super( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function peek(): *
		{
			if( isEmpty() )
			{
				throw new IllegalOperationError( "stack is empty!" );
			}
			
			return _last.value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function push( o: * ): *
		{
			add( o );
			
			return o;
		}
		
		/**
		 * @inheritDoc
		 */
		public function pop(): *
		{
			if( isEmpty() )
			{
				throw new IllegalOperationError( "stack is empty!" );
			}
			
			var v: * = _last.value;
			
			_last.prev.next = null;
			_last = _last.prev;
						
			--_length;
			
			return v;
		}
		
		/**
		 * @inheritDoc
		 */
		public function indexOf( o: * ): int
		{
			var i: int = 0;
			var n: LinkedNode = _first;
			
			while( n != null )
			{
				if( n.value == o )
				{
					return i;
				}
				
				n = n.next;
				
				++i;
			}
			
			return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			var clone: LinkedStack = new LinkedStack();
			var n: LinkedNode = _first;
			
			while( n != null )
			{
				clone.add( n.value );
				n = n.next;
			}
			
			return clone;
		}
		
		/**
		 * String representation of <code>LinkedStack</code>.
		 * 
		 * @return String representation of <code>LinkedStack</code>
		 */
		public function toString(): String
		{
			return "[ LinkedStack size=" + size() + " first=" + _first + " last=" + _last + " ]";
		}
	}
}
