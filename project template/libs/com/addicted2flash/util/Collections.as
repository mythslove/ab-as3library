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
	 * This class consists exclusively of static methods that operate on or return collections.
	 * 
	 * @author Tim Richter
	 */
	public class Collections 
	{
		/**
		 * Sorts a <code>IList</code> with a given <code>IComparator</code>.
		 * 
		 * @param c <code>IList</code> to be sorted
		 * @param comp <code>IComparator</code>
		 */
		public static function sort( list: IList, comp: IComparator ): void
		{
			var n: int = list.size();
			
			if( n == 0 ) return;
			
			var a: Array = list.toArray();
			a.sort( comp.compare );
			
			for( var i: int = 0; i < n; ++i )
			{
				list.setAt( i, a[ i ] );
			}
		}
		
		/**
		 * Reverses the order of the elements in the specified list.
		 * 
		 * @param list <code>IList</code> to be reversed
		 */
		public static function reverse( list: IList ): void
		{
			var n: int = list.size();
			var m: int = n-1;
			
			if( n == 0 ) return;
			
			var a: Array = list.toArray();
			
			for( var i: int = 0; i < n; ++i, --m )
			{
				list.setAt( i, a[ m ] );
			}
		}

		/**
		 * Rotates the elements in the specified list by the specified distance.
		 * 
		 * @param list <code>IList</code>
		 * @param distance distance to rotate the list. It may be zero, negative, or greater 
		 * 		  than <code>list.size()</code>
		 */
		public static function rotate( list: IList, distance: int ): void
		{
			var n: int = list.size();
        	
        	if( n == 0 ) return;
        	
        	if( distance < 0 ) distance = n + distance;
        	
        	var a: Array = list.toArray();
        	
        	for( var i: int = 0; i < n; ++i )
        	{
        		list.setAt( i, a[ ( distance + i ) % n ] );
        	}
		}
		
		/**
	     * Copies all of the elements from one list into another. After the
	     * operation, the index of each copied element in the destination list
	     * will be identical to its index in the source list.
	     *
	     * @param src source list.
	     * @param dest destination list.
	     */
		public static function copy( src: IList, dest: IList ): void
		{
			var n: int = src.size();
			
			for( var i: int = 0; i < n; ++i ) dest.setAt( i, src.getAt( i ) );
		}
		
		/**
		 * Replaces all of the elements of the specified list with the specified element.
		 * 
		 * @param list <code>IList</code> to be filled
		 * @param o element with which to fill the specified list
		 */
		public static function fill( list: IList, o: * ): void
		{
			var n: int = list.size();
			
			for( var i: int = 0; i < n; ++i ) list.setAt( i, o );
		}
		
		/**
		 * Randomly permutes the specified list using <code>Math.random()</code>.
		 * 
		 * @param list <code>IList</code> to be randomly shuffled
		 */
		public static function shuffle( list: IList ): void
		{
			var n: int = list.size();
			var m: int = n-1;
			
			if( n == 0 ) return;
			
			var a: Array = list.toArray();
			
			for( var i: int = 0; i < n; ++i, m = a.length-1 )
			{
				list.setAt( i, a.splice( Math.random() * m, 1 )[ 0 ] );
			}
		}
		
		/**
		 * Returns true if the two specified collections have no elements in common.
		 * 
		 * @param c1 a collection
		 * @param c2 a collection
		 * @return true if the two specified collections have no elements in common
		 */
		public static function disjoint( c1: ICollection, c2: ICollection ): Boolean
		{
			var n1: int = c1.size();
			var n2: int = c2.size();
			var n: int = n1 < n2 ? n1 : n2;
			
			for( var i: int = 0; i < n; ++i )
			{
				if( c1.getAt( i ) == c2.getAt( i ) ) return false;
			}
			
			return true;
		}
		
		/**
		 * Replaces all occurrences of one specified value in a list with another.
		 * 
		 * @param list <code>IList</code>
		 * @param oldVal old value to be replaced
		 * @param newVal new value with which <code>oldVal</code> is to be replaced
		 * @return true if at least one element was replaced
		 */
		public static function replaceAll( list: IList, oldVal: *, newVal: * ): Boolean
		{
			var n: int = list.size();
			var changed: Boolean = false;
			
			for( var i: int = 0; i < n; ++i )
			{
				if( list.getAt( i ) == oldVal )
				{
					list.setAt( i, newVal );
					changed = true;
				}
			}
			
			return changed;
		}
		
		/**
		 * Returns the minimum element of the given collection, according to the order induced
		 * by the spedified <code>IComparator</code>.
		 * 
		 * @param list <code>IList</code>
		 * @param cmp <code>IComparator</code>
		 * @return the minimum element of the given collection, according to the order induced
		 * 		   by the specified <code>IComparator</code>
		 */
		public static function min( list: IList, cmp: IComparator ): *
		{
			var n: int = list.size();
			var min: *, o: *;
			
			for( var i: int = 0; i < n; ++i )
			{
				if( cmp.compare( o = list.getAt( i ), min ) < 0 ) min = o;
			}
			
			return min;
		}
		
		/**
		 * Returns the maximum element of the given collection, according to the order induced
		 * by the spedified <code>IComparator</code>.
		 * 
		 * @param list <code>IList</code>
		 * @param cmp <code>IComparator</code>
		 * @return the maximum element of the given collection, according to the order induced
		 * 		   by the specified <code>IComparator</code>
		 */
		public static function max( list: IList, cmp: IComparator ): *
		{
			var n: int = list.size();
			var max: *, o: *;
			
			for( var i: int = 0; i < n; ++i )
			{
				if( cmp.compare( o = list.getAt( i ), max ) > 0 ) max = o;
			}
			
			return max;
		}
	}
}
