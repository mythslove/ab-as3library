package com.senocular.gyro {

	public class EaseCircular extends Ease {
		
		public function EaseCircular(behavior:int = Ease.IN, amount:Number = 1, change:Number = .5) {
			super(behavior, amount, change, easeMethod);
		}
		
		override public function easeMethod(t:Number):Number {
			return 1 - Math.sqrt(1 - t*t);
		}
	}
}