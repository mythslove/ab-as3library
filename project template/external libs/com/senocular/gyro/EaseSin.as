package com.senocular.gyro {

	public class EaseSin extends Ease {
		
		public function EaseSin(behavior:int = Ease.IN, amount:Number = 1, change:Number = .5) {
			super(behavior, amount, change, easeMethod);
		}
		
		override public function easeMethod(t:Number):Number {
			return 1 - Math.cos((Math.PI*t)/2);
		}
	}
}