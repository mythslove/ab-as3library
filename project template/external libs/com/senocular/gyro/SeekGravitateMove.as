package com.senocular.gyro {
	
	import flash.geom.Point;
	/**
	 * Seekers follow target at a constant acceleration
	
	TODO: option for constant vector acceleration for x/y instead of individually
	option for matching if lower? do automatically?
	 */
	public class SeekGravitateMove extends SeekMove {
		
		protected var _acceleration:Number = .5;
		protected var vector:Point = new Point(0, 0);
		
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
		public function SeekGravitateMove(acceleration:Number = .5, orient:Boolean = true){
			this.acceleration = acceleration;
			this.orient = orient;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public override function follow(target:*, seeker:*):void {
			if (!_acceleration) return;
			var dx:Number = target.x - seeker.x;
			var dy:Number = target.y - seeker.y;
			var dist:Number = Math.sqrt(dx*dx + dy*dy);
			var angle:Number = Math.atan2(dy, dx);
			
			if (_orient) {
				seeker.rotation = angle*TO_DEGREES; 
			}
			
			vector.x += _acceleration * Math.cos(angle);
			vector.y += _acceleration * Math.sin(angle);
			
			seeker.x += vector.x;
			seeker.y += vector.y;
		}
	}
}