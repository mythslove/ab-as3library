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
	import flash.utils.Dictionary;	
	
	import com.addicted2flash.transition.core.TransitionPool;
	import com.addicted2flash.transition.core.TransitionRenderer;
	import com.addicted2flash.transition.core.TransitionState;
	import com.addicted2flash.transition.core.Property;
	import com.addicted2flash.event.TransitionEvent;

	import flash.errors.IllegalOperationError;
	import flash.utils.getTimer;		

	/**
	 * Tween object with the capability to start, stop, pause, resume tweens.
	 * 
	 * @author Tim Richter
	 */
	public class Transition implements ITransition
	{
		/** @private */
		private static const POOL: TransitionPool = new TransitionPool( 0x10 );
		/** @private */
		private static const RENDERER: TransitionRenderer = new TransitionRenderer( );
		/** @private */
		internal static var lock: Boolean = true;

		/**
		 * Creates a new <code>Flux</code>.
		 * 
		 * @param duration duration of the tween
		 * @param delay delay until transition starts
		 * @param property property to render (can be nested as linked list)
		 * @return transition
		 */
		public static function create( duration: int, delay: int, property: Property = null ): ITransition
		{
			var f: Transition = POOL.acquire( );
			f.duration = duration;
			f.delay = delay;
			f.prop = property;
			
			return f;
		}

		/**
		 * Creates a new <code>ITransition</code> and automatically starts it.
		 * 
		 * @param duration duration of the tween
		 * @param delay delay until transition starts
		 * @param runOnce if object should be disposed after tweening (faster!)
		 * @param property property to render (can be nested as linked list)
		 * @return transition
		 */
		public static function createAndStart( duration: int, delay: int, runOnce: Boolean, property: Property ): ITransition
		{
			var f: Transition = POOL.acquire( );
			f.duration = duration;
			f.delay = delay;
			f.runOnce = runOnce;
			f.prop = property;
			f.start( );
			
			return f;
		}

		/** @private */
		internal var next: Transition;
		/** @private */
		internal var prev: Transition;
		/** @private */
		internal var runOnce: Boolean;
		/** @private */
		internal var prop: Property;
		/** @private */
		internal var duration: int;
		/** @private */
		internal var delay: int;
		/** @private */
		internal var startTime: int;
		/** @private */
		internal var elapsed: int;
		/** @private */
		internal var observers: Dictionary;
		/** @private */
		internal var hasObservers: int;
		/** @private */
		internal var fluxState: int;
		/** @private */
		internal var rendering: Boolean;
		/** @private */
		internal var attachedObject: *;

		/**
		 * <p>NOTE: do not use the constructor to create new instances,
		 * use <code>create</code> instead.</p>
		 * 
		 * @throws IllegalOperationError if objects are created
		 */
		public function Transition( next: Transition )
		{
			if( lock ) throw new IllegalOperationError( "private constructor, use create instead!" );
			
			this.next = next;
		}

		/**
		 * @inheritDoc
		 */
		public function start(): void
		{
			if( state == TransitionState.RUNNING ) return;
			
			fluxState = TransitionState.RUNNING;
			
			startTime = getTimer( );
			
			elapsed = 0;
			
			if( !rendering ) RENDERER.add( this );
			
			if( hasObservers & TransitionEvent.START ) notifyTransitionObservers( TransitionEvent.START );
		}

		/**
		 * @inheritDoc
		 */
		public function pause(): void
		{
			if( state == TransitionState.PAUSE ) return;
			
			fluxState = TransitionState.PAUSE;
			
			elapsed += getTimer( ) - startTime;
			
			if( hasObservers & TransitionEvent.PAUSE ) notifyTransitionObservers( TransitionEvent.PAUSE );
		}

		/**
		 * @inheritDoc
		 */
		public function stop(): void
		{
			if( state == TransitionState.STOP ) return;
			
			fluxState = TransitionState.STOP;
			
			startTime = elapsed = 0;
			
			if( hasObservers & TransitionEvent.STOP ) notifyTransitionObservers( TransitionEvent.STOP );
		}

		/**
		 * @inheritDoc
		 */
		public function resume(): void
		{
			if( state == TransitionState.RUNNING ) return;
			
			fluxState = TransitionState.RUNNING;
			
			startTime = getTimer( );
			
			if( !rendering ) RENDERER.add( this );
			
			if( hasObservers & TransitionEvent.RESUME ) notifyTransitionObservers( TransitionEvent.RESUME );
		}

		/**
		 * @inheritDoc
		 */
		public function reverse(): void
		{
			var p: Property = prop;
			
			while( p )
			{
				p.adapter.reverse( );
				
				p = p.next;
			}
			
			if( state == TransitionState.COMPLETE )
			{
				start( );
			}
			else
			{
				var t: Number = getTimer( );
				
				elapsed = duration - ( elapsed + t - startTime );
				startTime = t;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function get state(): int
		{
			return fluxState;
		}

		/**
		 * @inheritDoc
		 */
		public function get totalDuration(): int
		{
			return duration;
		}

		/**
		 * @inheritDoc
		 */
		public function get attachment(): *
		{
			return attachedObject;
		}

		/**
		 * @inheritDoc
		 */
		public function set attachment( attachment: * ): void
		{
			attachedObject = attachment;
		}

		/**
		 * @inheritDoc
		 */
		public function set property( property: Property ): void
		{
			prop = property;
		}

		/**
		 * @inheritDoc
		 */
		public function addTransitionObserver( o: ITransitionObserver, events: int ): void
		{
			if( !observers ) observers = new Dictionary();
			else if( observers[ o ] != null )
			{
				TransitionObserverWrapper( observers[ o ] ).events = events;
				
				return;
			}
			
			hasObservers |= events;
			
			observers[ o ] = new TransitionObserverWrapper( o, events );
		}

		/**
		 * @inheritDoc
		 */
		public function removeTransitionObserver( o: ITransitionObserver ): void
		{
			if( !observers ) return;
			
			delete observers[ o ];
			
			hasObservers = 0;
			
			for each( var w: TransitionObserverWrapper in observers )
			{
				hasObservers |= w.events;
			}
		}

		/**
		 * @inheritDoc
		 */
		public function removeTransitionObservers(): void
		{
			observers = null;
			hasObservers = 0;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			if( state == TransitionState.DISPOSE ) return;
			
			fluxState = TransitionState.DISPOSE;
			
			observers = null;
			attachedObject = null;
			
			prop.dispose( );
			prop = null;
			
			POOL.release( this );
		}

		/**
		 * @private
		 */
		internal function notifyTransitionObservers( event: int ): void
		{
			for each( var o: TransitionObserverWrapper in observers )
			{
				if( event & o.events ) o.observer.processTransitionEvent( event, this );
			}
		}
	}
}
