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
	 * Array based list. Implements all optional list operations, and permits all elements, including null.
	 * 
	 * @author Tim Richter
	 */
	public class ArrayList extends AbstractArrayList implements IList
	{
		/**
		 * Create a new <code>ArrayList</code>.
		 * 
		 * @param field (optional) an existing Array
		 */
		public function ArrayList( field: Array = null ) 
		{
			super( field );
		}
		
		/**
		 * @inheriDoc
		 */
		override public function clone(): ICollection
		{
			return new ArrayList( toArray() );
		}
		
		/**
		 * @inheriDoc
		 */
		override public function subList( fromIndex: int, toIndex: int ): IList
		{
			return new ArrayList( toIndex >= fromIndex ? null : _list.slice( fromIndex, toIndex ) );
		}

		/**
		 * String representation of <code>ArrayList</code>.
		 * 
		 * @return String representation of <code>ArrayList</code>
		 */
		public function toString(): String
		{
			return "[ ArrayList size=" + size() + " ]";
		}
	}
}
