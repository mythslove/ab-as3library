/**
 * EaseCircular 
 *
 * circular-based ease method
 */
package com.senocular.motion {

	public class EaseCircular extends EaseMethod {
		
		/**
		 * Constructor 
		 */
		public function EaseCircular() {}
		
		public override function call(t:Number):Number {
			return 1 - Math.sqrt(1 - t*t);
		}
	}
}