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
	import com.addicted2flash.util.IQueue;	

	/**
	 * An sequential collection designed for holding elements prior to processing.
	 * 
	 * @author Tim Richter
	 */
	public class LinkedQueue extends AbstractLinkedCollection implements IQueue 
	{
		/**
		 * Create a new <code>LinkedQueue</code>.
		 */
		public function LinkedQueue()
		{
			super();
		}
		
		/**
		 * @inheritDoc
		 */
		public function poll(): *
		{
			if( _first != null )
			{
				var v: * = _first.value;
				var x: LinkedNode = _first.next;
				
				_first.clearAndCombine();
				_first = x;
				
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
		public function peek(): *
		{
			return _first == null ? null : _first.value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			var clone: IQueue = new LinkedQueue();
			var n: LinkedNode = _first;
			
			while( n != null )
			{
				clone.add( n.value );
				n = n.next;
			}
			
			return clone;
		}
		
		/**
		 * String representation of <code>LinkedQueue</code>.
		 * 
		 * @return String representation of <code>LinkedQueue</code>
		 */
		public function toString(): String
		{
			return "[ LinkedQueue size=" + size() + " ]";
		}
	}
}
