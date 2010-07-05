package com.senocular.gyro {

	public class EaseExponential extends Ease {
		
		public var power:Number;
		
		public function EaseExponential(power:Number = 2, behavior:int = Ease.IN, amount:Number = 1, change:Number = .5) {
			this.power = power;
			super(behavior, amount, change, easeMethod);
		}
		
		override public function easeMethod(t:Number):Number {
			return Math.pow(t, power);
		}
	}
}