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
	import com.addicted2flash.util.comparator.IComparator;	

	/**
	 * Implementation of an ordered <code>Array</code>-based set.
	 * A collection that contains no duplicate elements and at most one null element.
	 * 
	 * @author Tim Richter
	 */
	public class SortedArraySet extends ArraySet implements ISortedSet
	{
		private var _cmp: IComparator;
		
		/**
		 * Create a new <code>SortedArraySet</code>
		 * 
		 * @param cmp <code>IComparator</code> for ordering elements
		 * @param field (optional) an existing Array ( will be ordered immediately after instantiation )
		 */
		public function SortedArraySet( cmp: IComparator, field: Array = null )
		{
			_cmp = cmp;
			
			super( field );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function add( o: * ): void
		{
			super.add( o );
			
			_list.sort( _cmp.compare );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone(): ICollection
		{
			return new SortedArraySet( _cmp, _list.slice() );
		}
		
		/**
		 * @inheritDoc
		 */
		public function comparator(): IComparator
		{
			return _cmp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function first(): *
		{
			return _list[ 0 ];
		}
		
		/**
		 * @inheritDoc
		 */
		public function headSortedSet( toElement: * ): ISortedSet
		{
			return new SortedArraySet( _cmp, _list.slice( 0, _list.indexOf( toElement ) ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function last(): *
		{
			return _list[ size()-1 ];
		}
		
		/**
		 * @inheritDoc
		 */
		public function subSortedSet( fromElement: *, toElement: * ): ISortedSet
		{
			return new SortedArraySet( _cmp, _list.slice( _list.indexOf( fromElement ), _list.indexOf( toElement ) ) );
		}
		
		/**
		 * @inheritDoc
		 */
		public function tailSortedSet( fromElement: * ): ISortedSet
		{
			return new SortedArraySet( _cmp, _list.slice( _list.indexOf( fromElement ) ) );
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
		 * String representation of <code>SortedArraySet</code>.
		 * 
		 * @return String representation of <code>SortedArraySet</code>
		 */
		override public function toString(): String
		{
			return "[ SortedArraySet list= " + _list + " ]";
		}
	}
}
