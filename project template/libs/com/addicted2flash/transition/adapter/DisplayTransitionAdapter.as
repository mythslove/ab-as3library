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
	import com.addicted2flash.transition.adapter.TransitionAdapter;
	import com.addicted2flash.transition.easing.IEasing;
	
	import flash.display.DisplayObject;	

	/**
	 * Abstract class for <code>ITransitionAdapter</code> implementations that tween <code>DisplayObject</code>s.
	 * 
	 * @author Tim Richter
	 */
	public class DisplayTransitionAdapter extends TransitionAdapter 
	{
		/** Target of the adapter */
		protected var target: DisplayObject;
		
		/**
		 * Creates a new <code>DisplayFluxAdapter</code>.
		 * 
		 * @param target target of the adapter
		 * @param from start
		 * @param to end position
		 * @param easing easing
		 */
		public function DisplayTransitionAdapter( target: DisplayObject, from: Number, to: Number, easing: IEasing = null )
		{
			super( from, to, easing );
			
			this.target = target;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			easing = null;
			target = null;
		}
	}
}
