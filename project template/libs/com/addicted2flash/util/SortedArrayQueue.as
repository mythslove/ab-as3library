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
	import com.addicted2flash.util.ArrayQueue;
	import com.addicted2flash.util.IQueue;
	import com.addicted2flash.util.comparator.IComparator;	

	/**
	 * An unbounded sorted queue. The elements of the sorted queue are ordered by a Comparator 
	 * provided at queue construction time. 
	 * 
	 * A sorted queue does not permit null elements.
	 * 
	 * @author Tim Richter
	 */
	public class SortedArrayQueue extends ArrayQueue implements IQueue
	{
		private var _cmp: IComparator;

		/**
		 * Create a new <code>SortedArrayQueue</code>
		 * 
		 * @param cmp <code>IComparator</code> for ordering elements
		 * @param field ( optional ) an existing Array
		 */
		public function SortedArrayQueue( cmp: IComparator, field: Array = null )
		{
			_cmp = cmp;
			
			super( field );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function add( o: * ): void
		{
			if( o != null )
			{
				super.add( o );
				
				_list.sort( _cmp.compare );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			super.dispose();
			
			_cmp = null;
		}

		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			return new SortedArrayQueue( _cmp, toArray() );
		}
		
		/**
		 * String representation of <code>SortedArrayQueue</code>.
		 * 
		 * @return String representation of <code>SortedArrayQueue</code>
		 */
		override public function toString(): String
		{
			return "[ SortedArrayQueue size=" + size() + " comparator= " + _cmp + " ]";
		}
	}
}
