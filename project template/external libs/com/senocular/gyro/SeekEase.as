package com.senocular.gyro {
	
	/**
	 * Seekers follow a target based on a factor where
	 * with each step the follow moves approach% closer to the target
	 */
	public class SeekEase extends Seek {
		
		protected var _approach:Number = .5;
		
		/**
		 * A value between 0 and 1 representing how quickly
		 * a seeker approaches the target with every step
		 */
		public function get approach():Number {
			return _approach;
		}
		public function set approach(n:Number):void {
			if (n != _approach && n >= 0 && n <= 1) {
				_approach = n;
			}
		}
	
		/**
		 * Constructor
		 */
		public function SeekEase(approach:Number = .5, properties:Array = null){
			super(properties);
			this.approach = approach;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public override function call(target:*, seeker:*):void {
			if (!_approach) return;
			for each(var prop:* in _properties){
				seeker[prop] += _approach*(target[prop] - seeker[prop]);
			}
		}
	}
}