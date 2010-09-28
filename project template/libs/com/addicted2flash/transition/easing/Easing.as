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

	import com.addicted2flash.transition.easing.StrongOutEasing;
	/**
	 * Enumeration class for <code>ITweenEasing</code>-objects.
	 * 
	 * @author Tim Richter
	 */
	public class Easing 
	{
		/**
		 * Constant LINEAR-Easing
		 */
		public static const LINEAR: IEasing = new LinearEasing( );

		/**
		 * Constant SINE_IN-Easing
		 */
		public static const SINE_IN: IEasing = new SineInEasing( );

		/**
		 * Constant SINE_OUT-Easing
		 */
		public static const SINE_OUT: IEasing = new SineOutEasing( );

		/**
		 * Constant STRONG_IN-Easing
		 */
		public static const STRONG_IN: IEasing = new StrongInEasing( );

		/**
		 * Constant STRONG_OUT-Easing
		 */
		public static const STRONG_OUT: IEasing = new StrongOutEasing( );

		/**
		 * Constant EXPO_IN-Easing
		 */
		public static const EXPO_IN: IEasing = new ExpoInEasing( );

		/**
		 * Constant EXPO_OUT-Easing
		 */
		public static const EXPO_OUT: IEasing = new ExpoOutEasing( );

		/**
		 * Constant BOUNCE_IN-Easing
		 */
		public static const BOUNCE_IN: IEasing = new BounceInEasing( );

		/**
		 * Constant BOUNCE_OUT-Easing
		 */
		public static const BOUNCE_OUT: IEasing = new BounceOutEasing( );
	}
}
