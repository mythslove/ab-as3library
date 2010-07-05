package com.senocular.gyro {
	
	import flash.events.EventDispatcher;
	
	/**
	 * Matches seeker properties directly to target properties
	 */
	public class Seek
		extends EventDispatcher
		implements ISeek {
		
		protected var _atDestination:Boolean = false;
		
		/**
		 * Itentifies whether or not the Seek is currently
		 * at it's intended destination. If a Seeker is at
		 * its destination, you cannot set its value to
		 * false. However, you can set its value to true
		 * to send the Seek to the destination.
		 */
		public function get atDestination():Boolean {
			return _atDestination;
		}
		public function set atDestination(value:Boolean):void {
			if (!value || !_atDestination) return;
			_atDestination = value;
			if (_atDestination) {
				desitnationReached();
			}
		}
		
		/**
		 * Constructor
		 */
		public function Seek(){}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public function call(interpolater:IInterpolate):void {
			interpolater.interpolate(1);
			if (!_atDestination){
				_atDestination = true;
				desitnationReached();
			}
		}
		
		/**
		 * Signals that the destination for this seek instance
		 * has been reached, firing the respective event.
		 */
		protected function desitnationReached():void {
			dispatchEvent(new GyroEvent(GyroEvent.AT_DESTINATION, this));
		}
	}
}