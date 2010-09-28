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
	import com.addicted2flash.transition.core.Property;		

	/**
	 * Pool for <code>Property</code> objects.
	 * 
	 * @author Tim Richter
	 */
	public class PropertyPool 
	{
		private var _first: Property;
		private var _growthRate: int;
		
		/**
		 * Creates a new <code>PropertyPool</code>.
		 * 
		 * @param growthRate growth rate of the pool
		 */
		public function PropertyPool( growthRate: int )
		{
			_growthRate = growthRate;
		}
		
		/**
		 * Returns a <code>Property</code> object out of the pool.
		 * 
		 * @return a <code>Property</code> object out of the pool
		 */
		public function acquire(): Property
		{
			if( !_first )
			{
				Property.lock = false;
				
				var n: int = _growthRate;
				
				while( --n )
				{
					_first = new Property( _first );
				}
				
				Property.lock = true;
			}
			
			var p: Property = _first;
			
			_first = p.next;
			
			p.next = null;
			
			return p;
		}
		
		/**
		 * Puts a property object back to the pool.
		 * 
		 * @param p property object to be released
		 */
		public function release( p: Property ): void
		{
			p.next = _first;
			
			_first = p;
		}
	}
}
