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
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;

	/**
	 * This class represents a utility for observing frames per second and the total amount
	 * of memory currently in use by Flash Player.
	 * 
	 * NOTE: <code>value</code> does not have to be setted in this <code>MicroObservable</code>-implementation. 
	 * Observers will be notified every second.
	 * 
	 * @author Tim Richter
	 */
	public class PerformanceObservable extends Observable implements IPerformanceObservable
	{
		private var _dispatcher: DisplayObject;
		private var _timer: Timer;
		private var _frames: int;
		
		/**
		 * Create a new <code>PerformanceObservable</code>.
		 */
		public function PerformanceObservable()
		{
			initialize( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get fps(): int
		{
			return value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get bytes(): int
		{
			return System.totalMemory;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get kiloBytes(): int
		{
			return bytes >> 10;
		}

		/**
		 * @inheritDoc
		 */
		public function get megaBytes(): Number
		{
			return kiloBytes / 1024;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			super.dispose();
			
			if( _timer != null )
			{
				_timer.stop();
				_timer.removeEventListener( TimerEvent.TIMER, onTimer );
				_timer = null;
			}
			
			if( _dispatcher != null )
			{
				_dispatcher.removeEventListener( Event.ENTER_FRAME, onEnterFrame );
				_dispatcher = null;
			}
		}
		
		/**
		 * @private
		 */
		private function onEnterFrame( event: Event ): void
		{
			++_frames;
		}
		
		/**
		 * @private
		 */
		private function onTimer( event: TimerEvent ): void
		{
			value = _frames;
			
			_frames = 0;
		}
		
		/**
		 * @private
		 */
		private function initialize(): void
		{
			_frames = 0;
			
			_timer = new Timer( 1000 );
			_timer.addEventListener( TimerEvent.TIMER, onTimer );
			_timer.start();
			
			_dispatcher = new Shape();
			_dispatcher.addEventListener( Event.ENTER_FRAME, onEnterFrame );
		}
	}
}
