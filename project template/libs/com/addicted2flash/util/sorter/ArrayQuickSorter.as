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
package com.addicted2flash.util.sorter 
{
	import com.addicted2flash.util.comparator.IComparator;	
	import com.addicted2flash.util.sorter.IArraySorter;
	
	/**
	 * @author Tim Richter
	 */
	public class ArrayQuickSorter implements IArraySorter 
	{
		private var _cmp: IComparator;
		private var _a: Array;
		
		/**
		 * Create a new <code>ArrayQuickSorter</code>
		 * 
		 * @param cmp <code>IComparator</code> for ordering elements
		 */
		public function ArrayQuickSorter( cmp: IComparator ) 
		{
			_cmp = cmp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort( a: Array ): void
		{
			_a = a;
			
			quickSort( 0, a.length-1 );
		}
		
		private function quickSort( lo: int, hi: int ): void
		{
			var i: int = lo;
			var j: int = hi;
			var x: * = _a[ ( lo+hi ) >> 1 ];
			var tmp: *;
			
			while( i <= j )
			{
				while( _cmp.compare( x, _a[ i ] ) > 0 )
				{
					++i;
				}
				
				while( _cmp.compare( _a[ j ], x ) > 0 )
				{
					--j;
				}
				
				if( i <= j )
				{
					tmp = _a[ i ];
					_a[ i ] = _a[ j ];
					_a[ j ] = tmp;
					
					++i;
					--j;
				}
			}
			
			if( lo < j )
			{
				quickSort( lo, j );
			}
			if( i < hi )
			{
				quickSort( i, hi );
			}
		}
	}
}
