/**
 * EaseExponential 
 *
 * Exponential-based ease method
 */
package com.senocular.motion {

	public class EaseExponential extends EaseMethod {
		
		private var power:Number;	// the power to ease by
		
		/**
		 * Constructor 
		 */
		public function EaseExponential(power:Number = 2) {
			this.power = power;
		}
		
		public override function call(t:Number):Number {
			return Math.pow(t, power);
		}
	}
}