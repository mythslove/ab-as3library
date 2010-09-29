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
package com.addicted2flash.transition.easing 
{
	import com.addicted2flash.transition.easing.IEasing;
	
	/**
	 * This class represents a bounce (easeOut) easing based on Grant Skinners easing equations.
	 * 
	 * @author Tim Richter
	 */
	public class BounceOutEasing implements IEasing 
	{
		/**
		 * @inheritDoc
		 */
		public function ease( t: Number, b: Number, c: Number, d: Number ): Number
		{
			if( ( t /= d ) < ( 1 / 2.75 ) ) 
			{
				return c * ( 7.5625 * t * t ) + b;
			}
			else
			if( t < ( 2 / 2.75 ) ) 
			{
				return c * ( 7.5625 * ( t -= ( 1.5 / 2.75 ) ) * t + .75 ) + b;
			}
			else
			if( t < ( 2.5 / 2.75 ) ) 
			{
				return c * ( 7.5625 * ( t -= ( 2.25 / 2.75 ) ) * t + .9375 ) + b;
			}
			else 
			{
				return c * ( 7.5625 * ( t -= ( 2.625 / 2.75 ) ) * t + .984375 ) + b;
			}
		}
	}
}