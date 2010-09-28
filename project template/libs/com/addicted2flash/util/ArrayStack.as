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
	import flash.errors.IllegalOperationError;			

	/**
	 * The <code>ArrayStack</code> class represents a last-in-first-out (LIFO) stack of elements.
	 * 
	 * @author Tim Richter
	 */
	public class ArrayStack extends AbstractArrayCollection implements IStack
	{
		/**
		 * Create a new <code>ArrayStack</code>
		 * 
		 * @param field (optional) an existing Array
		 */
		public function ArrayStack( field: Array = null ) 
		{
			super( field );
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
			
			return _list[ size()-1 ];
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
			
			return _list.pop();
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
		override public function clone(): ICollection
		{
			return new ArrayStack( toArray() );
		}
		
		/**
		 * String representation of <code>ArrayStack</code>.
		 * 
		 * @return String representation of <code>ArrayStack</code>
		 */
		public function toString(): String
		{
			return "[ ArrayStack size=" + size() + " ]";
		}
	}
}
