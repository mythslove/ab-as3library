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
	public class ArrayMergeSorter implements IArraySorter 
	{
		private var _cmp: IComparator;
		private var _a: Array;
		private var _b: Array;
		
		/**
		 * Create a new <code>ArrayMergeSorter</code>
		 * 
		 * @param cmp <code>IComparator</code> for ordering elements
		 */
		public function ArrayMergeSorter( cmp: IComparator ) 
		{
			_cmp = cmp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort( a: Array ): void
		{
			_a = a;
			_b = [];
			
			mergeSort( 0, a.length-1 );
		}
		
		private function mergeSort( lo: int, hi: int ): void
		{
			if( lo < hi )
			{
				var m: int = ( lo+hi ) >> 1;
				mergeSort( lo, m );
				mergeSort( m+1, hi );
				merge( lo, m, hi );
			}
		}
		
		private function merge( lo : int, m : int, hi : int ) : void 
		{
			var i: int = 0;
			var j: int = lo;
			var k: int = lo;
			
			// -- copy first half of list
			while( j <= m )
			{
				_b[ i++ ] = _a[ j++ ];
			}
			
			i = 0;
			
			while( k < j && j <= hi )
			{
				if( _cmp.compare( _a[ j ], _b[ i ] ) > 0 )
				{
					_a[ k++ ] = _b[ i++ ];
				}
				else
				{
					_a[ k++ ] = _a[ j++ ];
				}
			}
			
			// -- copy rest of list
			while( k < j ) 
			{
				_a[ k++ ] = _b[ i++ ];
			}
		}
	}
}
