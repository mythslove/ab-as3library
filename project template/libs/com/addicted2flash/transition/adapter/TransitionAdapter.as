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
package com.addicted2flash.transition.adapter 
{
	import com.addicted2flash.transition.easing.Easing;
	import com.addicted2flash.transition.easing.IEasing;
	
	import flash.errors.IllegalOperationError;		

	/**
	 * Abstract class for <code>ITransitionAdapter</code> implementations.
	 * 
	 * @author Tim Richter
	 */
	public class TransitionAdapter implements ITransitionAdapter 
	{
		/** Start position */
		protected var start: Number;
		/** End position */
		protected var end: Number;
		/** Difference of start and end position */
		protected var change: Number;
		/** Easing object */
		protected var easing: IEasing;

		/**
		 * Creates a new <code>TransitionAdapter</code>.
		 * 
		 * @param from start
		 * @param to end position
		 * @param easing easing
		 */
		public function TransitionAdapter( from: Number, to: Number, easing: IEasing = null )
		{
			this.start = from;
			this.end = to;
			this.change = to - from;
			this.easing = easing ? easing : Easing.LINEAR;
		}
		
		/**
		 * @inheritDoc
		 */
		public function reverse(): void
		{
			var s: Number = start;
			start = end;
			end = s;
			change = end - start;
		}
		
		/**
		 * @inheritDoc
		 */
		public function update( t: int, d: int ): void
		{
			throw new IllegalOperationError( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function finalize(): void
		{
			throw new IllegalOperationError( );
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			easing = null;
		}
	}
}
