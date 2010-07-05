package com.senocular.gyro {
	
	/**
	 * Seekers follow target at a constant speed
	 */
	public class SeekMove extends Seek {
		
		public static const TO_DEGREES:Number = (180/Math.PI);
		
		protected var _orient:Boolean = true;
		
		/**
		 * When true, seeker rotation is set 
		 * to point to the target location
		 */
		public function get orient():Boolean {
			return _orient;
		}
		public function set orient(b:Boolean):void {
			_orient = b;
		}
	
		/**
		 * Constructor
		 */
		public function SeekMove(){
			
			// TODO: move properties only affect x and y 
			// and rotation (if orient) properties
			super();
		}
	}
}