package com.senocular.gyro {
	
	import flash.utils.Dictionary;
	/**
	 * Seekers follow target at a constant acceleration
	
	TODO: option for constant vector acceleration for x/y instead of individually
	option for matching if lower? do automatically?
	 */
	public class SeekGravitate extends Seek {
		
		protected var _acceleration:Number = .5;
		protected var velcities:Dictionary = new Dictionary();
		
		/**
		 * A value between 0 and 1 representing how quickly
		 * a seeker accelerationes the target with every step
		 */
		public function get acceleration():Number {
			return _acceleration;
		}
		public function set acceleration(n:Number):void {
			_acceleration = n;
		}
	
		/**
		 * Constructor
		 */
		public function SeekGravitate(acceleration:Number = .5, properties:Array = null){
			super(properties);
			this.acceleration = acceleration;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public override function follow(target:*, seeker:*):void {
			if (!_acceleration) return;
	
			var diff:Number;
			for each(var prop:* in _properties){

				diff = target[prop] - seeker[prop];

				if (!(prop in velcities)){
					velcities[prop] = 0;
				}

				velcities[prop] += _acceleration * diff;
				seeker[prop] += velcities[prop];
			}
		}
	}
}