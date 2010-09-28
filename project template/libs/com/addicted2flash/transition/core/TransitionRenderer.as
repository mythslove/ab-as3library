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
	import com.addicted2flash.event.TransitionEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;	

	/**
	 * Renderer for <code>Transition</code> tween objects.
	 * 
	 * @author Tim Richter
	 */
	public class TransitionRenderer 
	{
		private var _timer: Sprite = new Sprite();
		private var _first: Transition;
		private var _last: Transition;
		
		private const _complete: int = TransitionEvent.COMPLETE;
		private const _update: int = TransitionEvent.UPDATE;

		/**
		 * Adds a <code>Transition</code> tween object to render process.
		 * 
		 * @param t transition to render
		 */
		public function add( t: Transition ): void
		{
			t.rendering = true;
			
			if( !_first )
			{
				_first = _last = t;
				_timer.addEventListener( Event.ENTER_FRAME, render, false, 0, true );
			}
			else if( _last != t )
			{
				_last.next = t;
				t.prev = _last;
				_last = t;
			}
		}
		
		/**
		 * @private
		 */
		private function render( event: Event ): void
		{
			var r: Transition, f: Transition = _first;
			var p: Property;
			var t: int = getTimer();
			var q: int, d: int, y: int;
			
			while( f )
			{
				y = f.delay;
				q = t - f.startTime + f.elapsed;
				d = f.duration;
				p = f.prop;
				
				if( q > d )
				{
					f.fluxState = TransitionState.COMPLETE;
					
					while( p )
					{
						p.adapter.finalize();
						
						p = p.next;
					}
					
					if( f.hasObservers & _complete ) f.notifyTransitionObservers( _complete );
					
					r = f;
					
					if( f == _first )
					{
						_first = f.next;
						
						if( _first )
						{
							_first.prev = null;
						}
					}
					else if( f == _last )
					{
						_last = _last.prev;
						
						_last.next = null;
					}
					else
					{
						f.prev.next = f.next;
						f.next.prev = f.prev;
					}
					
					f = f.next;
					
					r.rendering = false;
					r.next = r.prev = null;
					
					if( r.runOnce ) r.dispose();
				}
				else if( d+y > q )
				{
					while( p )
					{
						p.adapter.update( q-y, d );
						
						p = p.next;
					}
					
					if( f.hasObservers & _update ) f.notifyTransitionObservers( _update );
					
					f = f.next;
				}
				else
				{
					//-- not rendering during delay
					f = f.next;
				}
			}
			
			if( !_first ) _timer.removeEventListener( Event.ENTER_FRAME, render );
		}
	}
}
