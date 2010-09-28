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
	public class ArraySelectionSorter implements IArraySorter 
	{
		private var _cmp: IComparator;
		
		/**
		 * Create a new <code>ArraySelectionSorter</code>
		 * 
		 * @param cmp <code>IComparator</code> for ordering elements
		 */
		public function ArraySelectionSorter( cmp: IComparator ) 
		{
			_cmp = cmp;
		}
		
		/**
		 * @inheritDoc
		 */
		public function sort( a: Array ): void
		{
			var i: int = 0;
			var j: int;
			var k: int;
			var x: *;
			var n: int = a.length;
			
			for( ; i < n; ++i )
			{
				j = i;
				k = i + 1;
	
				for( ; k < n; ++k ) 
				{
					if ( _cmp.compare( a[ j ], a[ k ] ) > 0 ) 
					{
						j = k;
					}
				}
				
				x = a[ i ];
				a[ i ] = a[ j ];
				a[ j ] = x;
			}
		}
	}
}
