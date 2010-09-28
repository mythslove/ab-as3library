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
package com.addicted2flash.layout.core  
{
	import com.addicted2flash.layout.core.Component;
	
	import flash.display.Stage;
	import flash.events.Event;	

	/**
	 * LayoutManager handles invalidation/validation cycle.
	 * 
	 * @author Tim Richter
	 */
	public class LayoutManager 
	{
		private static var _instance: LayoutManager;

		public static function initialize( stage: Stage ): void
		{
			getInstance().stage = stage;
		}
		
		public static function getInstance(): LayoutManager
		{
			if( !_instance ) _instance = new LayoutManager();
			
			return _instance;
		}

		internal var stage: Stage;
		
		private var _invalidate: Boolean;
		private var _queue: PriorityQueue = new PriorityQueue();
		
		/**
		 * Invalidates a given component. Component will be measured and arranged.
		 * 
		 * @param c component to be invalidated
		 */
		public function invalidate( c: Component ): void
		{
			_queue.enqueue( c );
			
			c.invalidatePhase = true;
			
			if( !_invalidate )
			{
				_invalidate = true;
				
				stage.addEventListener( Event.RENDER, render );
				stage.invalidate();
			}
		}
		
		/**
		 * Invalidates a given component. If its parent is not invalidating
		 * all measured parents are marked as invalid, too and will be measured and arranged.
		 * 
		 * @param c component to be invalidated
		 */
		public function invalidateTree( c: Component ): void
		{
			invalidate( c );
			
			c = c.parentClient;
			
			if( !c || c.invalidatePhase ) return;
			
			c.invalidatePhase = true;
			_queue.enqueue( c );
			
			while( ( c = c.parentClient ) && !c.invalidatePhase && c.useMeasuredSizes )
			{
				_queue.enqueue( c );
				c.invalidatePhase = true;
			}
		}

		/**
		 * @private
		 */
		private function render( e: Event ): void
		{
			var c: Component = _queue.last;
			
			while( c )
			{
				if( c.useMeasuredSizes ) c.measure();
				c = c.prev;
			}
			
			while( ( c = _queue.dequeue() ) )
			{
				c.arrange();
				c.invalidatePhase = false;
			}
			
			stage.removeEventListener( Event.RENDER, render );
			
			_invalidate = false;
		}
	}
}
