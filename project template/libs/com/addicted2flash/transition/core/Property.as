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
	import com.addicted2flash.transition.core.PropertyPool;
	import com.addicted2flash.transition.adapter.ITransitionAdapter;
	import com.addicted2flash.util.IDisposable;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * Linked list node in the flux engine that acts as a property.
	 * 
	 * @author Tim Richter
	 */
	public final class Property implements IDisposable
	{
		private static const POOL: PropertyPool = new PropertyPool( 0x10 );
		
		/** @private */
		internal static var lock: Boolean = true;
		
		/**
		 * Creates and returns a new <code>Property</code>.
		 * 
		 * @param adapter adapter
		 * @param next next property (linked list)
		 * @return a new property
		 */
		public static function create( adapter: ITransitionAdapter, next: Property = null ): Property
		{
			var p: Property = POOL.acquire();
			p.adapter = adapter;
			p.next = next;
			
			return p;
		}
		
		/** @private */
		internal var next: Property;
		/** @private */
		internal var adapter: ITransitionAdapter;

		/**
		 * @private
		 * 
		 * <p>NOTE: do not use the constructor to create new instances, 
		 * use <code>create</code> instead.</p>
		 * 
		 * @param next next property (linked list)
		 */
		public function Property( next: Property )
		{
			if( lock ) throw new IllegalOperationError( "private constructor, use create instead!" );
			
			this.next = next;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			if( next ) next.dispose();
			
			adapter.dispose();
			
			POOL.release( this );
		}
	}
}
