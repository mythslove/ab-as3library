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
	 * Heap sorter algorithm class for sorting <code>Array</code>s based
	 * on heap-structure ordered with <code>IComparator</code> configured at construction time.
	 * 
	 * @author Tim Richter
	 */
	public class ArrayHeapSorter implements IArraySorter
	{
		private var _cmp: IComparator;
		private var _a: Array;
		private var _len: int;
		
		
		/**
		 * Create a new <code>ArrayHeapSorter</code>
		 * 
		 * @param cmp <code>IComparator</code> for ordering elements
		 */
		public function ArrayHeapSorter( cmp: IComparator ) 
		{
			_cmp = cmp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort( a: Array ): void
		{
			_a = a;
			_len = a.length;
			
			heapSort();
		}
		
		
		private function heapSort(): void
		{
			buildHeap();
			
			while( _len > 1 )
			{
				--_len;
				exchange( 0, _len );
				downHeap( 0 );
			}
		}
		
		private function exchange( i: int, j: int ): void
		{
			var t: * = _a[ i ];
			_a[ i ] = _a[ j ];
			_a[ j ] = t;
		}

		private function buildHeap(): void
		{
			var i: int = _len >> 1;
			
			while( --i > -1 )
			{
				downHeap( i );
			}
		}
		
		private function downHeap( i: int ): void
		{
			var w: int = ( i << 1 ) + 1;
			
			while( w < _len )
			{
				if( w+1 < _len )
				{
					if( _cmp.compare( _a[ w+1 ], _a[ w ] ) > 0 )
					{
						w++;
					}
				}
				
				if( _cmp.compare( _a[ i ], _a[ w ] ) >= 0)
				{
					return;
				}
				else
				{
					exchange( i, w );
					i = w;
					w = ( i << 1 ) + 1;
				}
			}
		}
	}
}
