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

	/**
	 * Helper class for key/value pairs.
	 * 
	 * @author Tim Richter
	 */
	public class Entry implements IDisposable
	{
		public var key: *;
		public var value: *;
		public var next: Entry;
		public var prev: Entry;
		
		/**
		 * Create a new <code>Entry</code>.
		 * 
		 * @param key (optional) key
		 * @param value (optional) value
		 */
		public function Entry( key: *, value: *, next: Entry = null )
		{
			this.key = key;
			this.value = value;
			this.next = next;
			
			if( next != null )
			{
				next.preAdd( this );
			}
		}
		
		/**
		 * add a node as predecessor ( also handles dependencies f.e pre/post ).
		 * 
		 * @param node predecessor
		 */
		public function preAdd( node: Entry ): void
		{
			if( prev != null )
			{
				prev.next = node;
			}
			
			node.prev = prev;
			node.next = this;
			prev = node;
		}
		
		/**
		 * clear instance and combine pre and post node (if existing).
		 */
		public function clearAndCombine(): void
		{
			if( prev != null )
			{
				prev.next = next;
			}
			if( next != null )
			{
				next.prev = prev;
			}
			
			dispose( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			next = null;
			prev = null;
			key = null;
			value = null;
		}
	}
}
