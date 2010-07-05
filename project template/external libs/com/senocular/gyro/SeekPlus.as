package com.senocular.gyro {
	
	import flash.events.EventDispatcher;
	
	/**
	 * Matches seeker properties directly to target properties
	 */
	public class SeekPlus
		extends Seek {
		
		override public function set atDestination(b:Boolean):void {
			trace("nuttin");
		}
	}
}