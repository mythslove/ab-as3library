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
	import com.addicted2flash.util.IQueue;	

	/**
	 * An array collection designed for holding elements prior to processing.
	 * 
	 * @author Tim Richter
	 */
	public class ArrayQueue extends AbstractArrayCollection implements IQueue 
	{
		/**
		 * Create a new <code>ArrayQueue</code>.
		 * 
		 * @param field ( optional ) an existing Array
		 */
		public function ArrayQueue( field: Array = null )
		{
			super( field );
		}
		
		/**
		 * @inheritDoc
		 */
		public function poll(): *
		{
			return _list.shift();
		}
		
		/**
		 * @inheritDoc
		 */
		public function peek(): *
		{
			return getAt( 0 );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			return new ArrayQueue( toArray() );
		}
		
		/**
		 * String representation of <code>ArrayQueue</code>.
		 * 
		 * @return String representation of <code>ArrayQueue</code>
		 */
		public function toString(): String
		{
			return "[ ArrayQueue size=" + size() + " ]";
		}
	}
}
