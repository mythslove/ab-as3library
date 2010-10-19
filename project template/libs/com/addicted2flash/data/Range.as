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
package com.addicted2flash.data 
{

	/**
	 * Represents a specific numeric range.
	 * 
	 * @author Tim Richter
	 */
	public class Range
	{
		protected var _start: int;
		protected var _end: int;
		
		/**
		 * Create a new <code>Range</code>.
		 * 
		 * @param from start index (including)
		 * @param to end index (excluding)
		 */
		public function Range( start: int, end: int ) 
		{
			_start = start > end ? end : start;
			_end = end;
		}
		
		/**
		 * return start index (including).
		 * 
		 * @return start index (including)
		 */
		public function get start(): int
		{
			return _start;
		}
		
		/**
		 * return end index (excluding).
		 * 
		 * @return intnd index (excluding)
		 */
		public function get end(): int
		{
			return _end;
		}
		
		/**
		 * return value of start/end difference.
		 * 
		 * @return value of start/end difference
		 */
		public function get difference(): int
		{
			return end - start;
		}
		
		/**
		 * return new <code>Range</code> with cutted start index (excluding).
		 * 
		 * @param index cut index (excluding) (index have to be in the origin range)
		 * @return Range
		 */
		public function cutStart( index: int ): Range
		{
			if( index >= _end )
			{
				return new Range( _end, _end );
			}
			else if( index < _start )
			{
				return new Range( _start, _end );
			}
			else
			{
				return new Range( index+1, _end );
			}
		}
		
		/**
		 * return new <code>Range</code> with cutted end index (excluding).
		 * 
		 * @param index cut index (excluding) (index have to be in the origin range)
		 * @return Range
		 */
		public function cutEnd( index: int ): Range
		{
			if( index > _end )
			{
				return new Range( _start, _end );
			}
			else if( index <= _start )
			{
				return new Range( _start, _start );
			}
			else
			{
				return new Range( _start, index-1 );
			}
		}
		
		
		/**
		 * return new <code>Range</code> with <code>start = 0, end = formerEnd-index</code>.
		 * Same result as cutEnd() and afterwards moveToOrigin().
		 * 
		 * @param index cut index
		 * @return Range
		 */
		public function cutAndMoveToOrigin( index: int ): Range
		{
			var cut: int = _end-index;
			
			return new Range( 0, cut < 0 ? 0 : cut );
		}
		
		/**
		 * return new <code>Range</code> moved to start = 0 (<code>end = formerEnd-start</code>).
		 * 
		 * @return Range
		 */
		public function moveToOrigin(): Range
		{
			return new Range( 0, _end-_start );
		}
		
		/**
		 * return new <code>Range</code> with moved indexes.
		 * 
		 * @param delta move delta
		 * @return Range
		 */
		public function move( delta: int ): Range
		{
			return new Range( _start + delta, _end + delta );
		}
		
		/**
		 * return new <code>Range</code> with moved start index.
		 * 
		 * @param delta move delta
		 * @return Range
		 */
		public function moveStart( delta: int ): Range
		{
			var d: int = _start + delta;
			
			return new Range( d > _end ? _end : d, _end );
		}
		
		/**
		 * return new <code>Range</code> with moved end index.
		 * 
		 * @param delta move delta
		 * @return Range
		 */
		public function moveEnd( delta: int ): Range
		{
			var d: int = _end + delta;
			
			return new Range( _start, d < _start ? _start : d );
		}
		
		/**
		 * return true if this <code>Range</code> is a subset of a given <code>Range</code>.
		 * (start >= range.start && end <= range.end)
		 * 
		 * @return true if this <code>Range</code> is subset of given <code>Range</code>
		 */
		public function isSubsetOf( range: Range ): Boolean
		{
			return _start >= range.start && _end <= range.end;
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone(): Range
		{
			return new Range( _start, _end );
		}
		
		/**
		 * String representation of <code>Range</code>.
		 * 
		 * @return String representation of <code>Range</code>
		 */
		public function toString(): String
		{
			return "[ Range start=" + _start + " end=" + _end + " ]";
		}
	}
}
