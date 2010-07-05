/**
 * EaseMethod 
 *
 * Base class for all other ease methods
 * Used directly it provides a linear (no) ease
 */
package com.senocular.motion {

	import flash.events.EventDispatcher;

	internal class EaseMethod extends EventDispatcher {
		
		/**
		 * Constructor 
		 */
		public function EaseMethod() {}
		
		/**
		 * call
		 * overridden by subclasses to apply ease to t
		 */
		public function call(t:Number):Number {
			return t;
		}
	}
}