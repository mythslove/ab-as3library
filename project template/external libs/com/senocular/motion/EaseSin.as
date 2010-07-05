/**
 * EaseSin 
 *
 * Sin-based ease method
 */
package com.senocular.motion {

	public class EaseSin extends EaseMethod {
		
		/**
		 * Constructor 
		 */
		public function EaseSin() {}
		
		public override function call(t:Number):Number {
			return 1 - Math.sin((Math.PI + Math.PI*t)/2);
		}
	}
}