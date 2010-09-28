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

	/**
	 * @author Tim Richter
	 */
	public class Scale extends DisplayTransitionAdapter 
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
			return new Scale( target, -1, to, easing );
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
			return new Scale( target, from, -1, easing );
		}

		private var _xfrom: Number;
		private var _yfrom: Number;
		private var _xchange: Number;
		private var _ychange: Number;
		private var _equal: Boolean;
		
		/**
		 * Creates a new <code>FluxScale</code>.
		 * 
		 * @param target target of the property
		 * @param from start
		 * @param to end
		 * @param easing easing
		 */
		public function Scale( target: DisplayObject, from: Number, to: Number, easing: IEasing = null )
		{
			super( target, from, to, easing );
			
			_yfrom = target.scaleY;
			_xfrom = target.scaleX;
			_xchange = to - _xfrom;
			_ychange = to - _yfrom;
			
			_equal = _yfrom == _xfrom;
		}

		/**
		 * @inheritDoc
		 */
		override public function update( t: int, d: int ): void
		{
			if( _equal )
			{
				var v: Number = easing.ease( t, _xfrom, _xchange, d );
				
				target.scaleX = v;
				target.scaleY = v;
			}
			else
			{
				target.scaleX = easing.ease( t, _xfrom, _xchange, d );
				target.scaleY = easing.ease( t, _yfrom, _ychange, d );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function finalize(): void
		{
			target.scaleY = end;
		}
	}
}
	