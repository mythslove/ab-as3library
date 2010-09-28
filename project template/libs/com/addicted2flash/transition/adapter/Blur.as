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
	import com.addicted2flash.transition.adapter.ITransitionAdapter;
	import com.addicted2flash.transition.easing.IEasing;
	
	import flash.display.DisplayObject;
	import flash.filters.BlurFilter;	

	/**
	 * @author Tim Richter
	 */
	public class Blur extends DisplayTransitionAdapter 
	{
		/**
		 * Creates and returns a new <code>IFluxAdapter</code> and automatically
		 * detects its start parameter.
		 * 
		 * @param target target of the property
		 * @param to end
		 * @param quality quality of the blur
		 * @param easing easing
		 * @return property
		 */
		public static function to( target: DisplayObject, to: Number, quality: int = 1, easing: IEasing = null ): ITransitionAdapter
		{
			return new Blur( target, 0, to, quality, easing );
		}
		
		/**
		 * Creates and returns a new <code>IFluxAdapter</code> and automatically
		 * detects its end parameter.
		 * 
		 * @param target target of the property
		 * @param from start
		 * @param quality quality of the blur
		 * @param easing easing
		 * @return property
		 */
		public static function from( target: DisplayObject, from: Number, quality: int = 1, easing: IEasing = null ): ITransitionAdapter
		{
			return new Blur( target, from, 0, quality, easing );
		}

		private var _filter: BlurFilter;
		private var _filters: Array;

		/**
		 * Creates a new <code>FluxBlur</code>.
		 * 
		 * @param target target of the property
		 * @param from start
		 * @param to end
		 * @param quality quality of the blur
		 * @param easing easing
		 */
		public function Blur( target: DisplayObject, from: Number, to: Number, quality: int = 1, easing: IEasing = null )
		{
			super( target, from, to, easing );
			
			_filters = [ _filter = new BlurFilter( from, from, quality ) ];
		}

		/**
		 * @inheritDoc
		 */
		override public function update( t: int, d: int ): void
		{
			var v: Number = easing.ease( t, start, change, d );
			
			_filter.blurX = v;
			_filter.blurY = v;
			
			target.filters = _filters;
		}

		/**
		 * @inheritDoc
		 */
		override public function finalize(): void
		{
			_filter.blurX = end;
			_filter.blurY = end;
			
			target.filters = _filters;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			easing = null;
			target = null;
			
			_filter = null;
			_filters = null;
		}
	}
}