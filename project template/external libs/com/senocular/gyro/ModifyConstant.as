package com.senocular.gyro {
	
	/**
	 * Matches seeker properties directly to target properties
	 */
	public class ModifyConstant
		implements IModify {
		
		protected var _rate:Number;
		
		public function get rate():Number {
			return _rate;
		}
		public function set rate(value:Number):void {
			_rate = value;
		}
		
		/**
		 * Constructor
		 */
		public function ModifyConstant(rate:Number = 0){
			_rate = rate;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public function call(interpolater:IInterpolate):void {
			var prop:Object = interpolater.property;
			if (prop) interpolater.owner[prop] += _rate;
		}
	}
}