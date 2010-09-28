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
package com.addicted2flash.layout.core 
{

	/**
	 * @private
	 * @author Tim Richter
	 */
	internal final class PriorityQueue 
	{
		/** @private */
		public var first: Component;
		/** @private */
		public var last: Component;
		
		/**
		 * @private
		 */
		public function enqueue( c: Component ): void
		{
			if( !first )
			{
				first = last = c;
			}
			else
			{
				var n: int = c.depth;
				var p: Component = first;
				
				while( p )
				{
					if( p.depth >= n )
					{
						if( !p.prev )
						{
							p.prev = c;
							c.next = p;
							first = c;
						}
						else
						{
							p.prev.next = c;
							c.prev = p.prev;
							c.next = p;
							p.prev = c;
						}
						
						break;
					}
					
					p = p.next;
				}
				
				if( !c.next && !c.prev )
				{
					last.next = c;
					c.prev = last;
					last = c;
				}
			}
		}
		
		/**
		 * @private
		 */
		public function dequeue(): Component
		{
			if( !first ) return null;
			
			var c: Component = first;
			first = c.next;
			if( first ) first.prev = null;
			
			c.next = c.prev = null;
			
			return c;
		}
	}
}
