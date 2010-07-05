package com.senocular.gyro {
	
	/**
	 * Seekers follow target properites at a constant rate.
	 * Does not work for non-property interpolations
	 */
	public class SeekConstant implements ISeek {
		
		protected var _rate:Number;
		
		/**
		 * A value between 0 and 1 representing how quickly
		 * a seeker approaches the target with every step
		 */
		public function get rate():Number {
			return _rate;
		}
		public function set rate(n:Number):void {
			_rate = n;
		}
	
		/**
		 * Constructor
		 */
		public function SeekConstant(rate:Number = 1){
			_rate = rate;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public function call(interpolater:IInterpolate):void {
			try {
				var end:Number = Object(interpolater).end;
				var prop:Object = interpolater.property;
				var owner:* = interpolater.owner;
				var diff:Number = end - owner[prop];
				if (Math.abs(diff) < rate){
					owner[prop] = end;
				}else{
					owner[prop] += (diff > 0) ? _rate : -_rate;
				}
				
			}catch(error:Error){
				// a non-property interpolater; fail silently
			}
		}
	}
}