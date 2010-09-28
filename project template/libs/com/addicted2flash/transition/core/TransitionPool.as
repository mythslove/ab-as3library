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
package com.addicted2flash.transition.core 
{
	import com.addicted2flash.transition.core.Transition;
	/**
	 * Pool for <code>Flux</code> objects.
	 * 
	 * @author Tim Richter
	 */
	internal class TransitionPool 
	{
		private var _first: Transition;
		private var _growthRate: int;
		
		/**
		 * Creates a new <code>FluxPool</code>.
		 * 
		 * @param growthRate growth rate of the pool
		 */
		public function TransitionPool( growthRate: int )
		{
			_growthRate = growthRate;
		}
		
		/**
		 * Returns a <code>Flux</code> object out of the pool.
		 * 
		 * @return a <code>Flux</code> object out of the pool
		 */
		public function acquire(): Transition
		{
			if( !_first )
			{
				Transition.lock = false;
				
				var n: int = _growthRate;
				
				while( --n )
				{
					_first = new Transition( _first );
				}
				
				Transition.lock = true;
			}
			
			var f: Transition = _first;
			
			_first = f.next;
			
			f.next = f.prev = null;
			
			return f;
		}
		
		/**
		 * Puts a <code>Flux</code> object back to the pool.
		 * 
		 * @param f <code>Flux</code> object to be released
		 */
		public function release( f: Transition ): void
		{
			f.prev = null;
			f.next = _first;
			
			_first = f;
		}
	}
}
