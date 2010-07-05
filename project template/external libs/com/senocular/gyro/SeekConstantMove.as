package com.senocular.gyro {
	
	/**
	 * Seekers follow target at a constant speed
	 */
	public class SeekConstantMove extends SeekMove {
		
		protected var _speed:Number = 1;
		
		/**
		 * A value between 0 and 1 representing how quickly
		 * a seeker speedes the target with every step
		 */
		public function get speed():Number {
			return _speed;
		}
		public function set speed(n:Number):void {
			_speed = n;
		}
	
		/**
		 * Constructor
		 */
		public function SeekConstantMove(speed:Number = 1){
			this.speed = speed;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public override function follow(target:*, seeker:*):void {
			if (!_speed) return;
				
			// get the differences of x and y location
			var dx:Number = target.x - seeker.x;
			var dy:Number = target.y - seeker.y;
			
			// get the disatance away from the target
			// using the differences (pythagorean theorem)
			var dist:Number = Math.sqrt(dx*dx + dy*dy);
			
			// if there is disatnce between the seeker and
			// the target locations, move towards the target
			if (dist > 0) {
				var angle:Number = Math.atan2(dy, dx);
				
				// if orienting, rotate to point
				// to the target location
				if (_orient) {
					seeker.rotation = angle*TO_DEGREES; 
				}
				
				// if the distance is still greater than
				// the distance traveled every step
				// move towards the target
				if (dist > _speed) {
					seeker.x += _speed * Math.cos(angle);
					seeker.y += _speed * Math.sin(angle);
					
					if (_atDestination) _atDestination = false;
				// if the distance is less than speed
				// set the location to match the target
				}else{
					seeker.x = target.x;
					seeker.y = target.y;
					if (!_atDestination) atDestination = true;
				}
			}
		}
	}
}