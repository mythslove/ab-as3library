package com.senocular.gyro {
	
	/**
	 * Matches seeker properties directly to target properties
	 */
	public class Modify
		implements IModify {
			
		/**
		 * Constructor
		 */
		public function Modify(){}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public function call(interpolater:IInterpolate):void {
			interpolater.interpolate(1);
		}
	}
}