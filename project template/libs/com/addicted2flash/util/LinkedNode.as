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
	 * Helper class for building sequential data-structures.
	 * 
	 * @author Tim Richter
	 */
	public class LinkedNode 
	{
		public var next: LinkedNode;
		public var prev: LinkedNode;
		public var value: *;
		
		/**
		 * Create a new <code>LinkedNode</code>.
		 * 
		 * @param value any value
		 * @param prev predecessor of node
		 * @param next post node
		 */
		public function LinkedNode( value: * = null, prev: LinkedNode = null, next: LinkedNode = null ) 
		{
			this.value = value;
			this.prev = prev;
			this.next = next;
			
			if( prev != null )
			{
				prev.postAdd( this );
			}
			if( next != null )
			{
				next.preAdd( this );
			}
		}

		/**
		 * add a node as predecessor ( also handles dependencies f.e prev/next ).
		 * 
		 * @param node predecessor
		 */
		public function preAdd( node: LinkedNode ): void
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
		 * add a node as next node ( also handles dependencies f.e prev/next ).
		 * 
		 * @param node next node
		 */
		public function postAdd( node: LinkedNode ): void
		{
			if( next != null )
			{
				next.prev = node;
			}
			
			node.next = next;
			node.prev = this;
			next = node;
		}
		
		/**
		 * shift value to the left (value of prev node and this node change).
		 */
		public function shiftLeft(): void
		{
			if( prev != null )
			{
				var v: * = prev.value;
				
				prev.value = value;
				
				value = v;
			}
		}
		
		/**
		 * shift value to the left (value of next node and this node change).
		 */
		public function shiftRight(): void
		{
			if( next != null )
			{
				var v: * = next.value;
				
				next.value = value;
				
				value = v;
			}
		}
		
		/**
		 * clear instance and combine prev and next node (if existing).
		 */
		public function clearAndCombine(): *
		{
			if( prev != null )
			{
				prev.next = next;
			}
			if( next != null )
			{
				next.prev = prev;
			}
			
			var v: * = value;
			
			dispose();
			
			return v;
		}
		
		/**
		 * clear all internal dependencies.
		 */
		public function dispose(): void
		{
			prev = null;
			next = null;
			value = null;
		}
		
		/**
		 * recursive dispose.
		 */
		public function purge(): void
		{
			prev = null;
			value = null;
			
			if( next ) next.dispose();
			next = null;
		}
		
		/**
		 * string representation of <code>LinkedNode</code>.
		 * 
		 * @return String representation of <code>LinkedNode</code>
		 */
		public function toString(): String
		{
			return "[ LinkedNode value=" + value + " ]";
		}
	}
}
