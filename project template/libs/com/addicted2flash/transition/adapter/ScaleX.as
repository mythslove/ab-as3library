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
	import com.addicted2flash.transition.easing.IEasing;
	
	import flash.display.DisplayObject;	

	/**
	 * @author Tim Richter
	 */
	public class ScaleX extends DisplayTransitionAdapter 
	{
		/**
		 * Creates and returns a new <code>IFluxAdapter</code> and automatically
		 * detects its start parameter.
		 * 
		 * @param target target of the property
		 * @param to end
		 * @param easing easing
		 * @return property
		 */
		public static function to( target: DisplayObject, to: Number, easing: IEasing = null ): ITransitionAdapter
		{
			return new ScaleX( target, target.scaleX, to, easing );
		}
		
		/**
		 * Creates and returns a new <code>IFluxAdapter</code> and automatically
		 * detects its end parameter.
		 * 
		 * @param target target of the property
		 * @param from start
		 * @param easing easing
		 * @return property
		 */
		public static function from( target: DisplayObject, from: Number, easing: IEasing = null ): ITransitionAdapter
		{
			return new ScaleX( target, from, target.scaleX, easing );
		}
		
		/**
		 * Creates a new <code>FluxScaleX</code>.
		 * 
		 * @param target target of the property
		 * @param from start
		 * @param to end
		 * @param easing easing
		 */
		public function ScaleX( target: DisplayObject, from: Number, to: Number, easing: IEasing = null )
		{
			super( target, from, to, easing );
			
			target = target;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function update( t: int, d: int ): void
		{
			target.scaleX = easing.ease( t, start, change, d );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function finalize(): void
		{
			target.scaleX = end;
		}
	}
}
