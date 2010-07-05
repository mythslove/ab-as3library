package com.senocular.gyro {
	
	import flash.utils.Dictionary;
	
	/**
	 * Seekers follow a target based on a factor where
	 * with each step the follow moves factor% closer to the target
	 */
	public class SeekRecording extends Seek {
		
		protected var _recording:Array = [];
		protected var _properties:Array = [];
		protected var _delay:uint = 1;
		
		/**
		 * A collection of properties to be recorded
		 * and then reassigned to the owner after a delay
		 */
		public function get properties():Array {
			return _properties.length ? _properties.concat() : null;
		}
		public function set properties(a:Array):void {
			_properties = a.length ? a.concat() : [];
		}
		
		/**
		 * The number of steps each seeker is behind
		 * the target.  Seekers will not start following
		 * until at least delay steps have first been recorded
		 */
		public function get delay():uint {
			return _delay;
		}
		public function set delay(i:uint):void {
			_delay = i;
		}
	
		/**
		 * Constructor
		 */
		public function SeekRecording(delay:uint = 1, properties:Array = null){
			this.properties = properties;
			this.delay = delay;
		}
		
		/**
		 * Seek method; matches seeker properties
		 * to target properties based on the properties list
		 */
		public override function call(interpolate:IInterpolate):void {
			var prop:*;
			var matches:Boolean = true;
			
			// use a Dictionary for a record since property
			// keys may be object keys
			var newRecord:Dictionary = new Dictionary();
			
			// copy targets property values into record
			for each(prop in _properties){
				newRecord[prop] = target[prop];
			}
			
			// add the record into the recording
			_recording.push(newRecord);
			
			// if we've recorded enough to reach the delay
			// records from the recording can be used to
			// set values within the seekers
			if (_recording.length > _delay) {
				
				// remove the first record from the recordigns
				var record:Dictionary = Dictionary(_recording.shift());
				
				// copy the record to the seeker
				for (prop in record){
					seeker[prop] = record[prop];
					if (matches && record[prop] != newRecord[prop]){
						matches = false;
					}
				}
			}
			if (matches){
				if (!_atDestination) atDestination = true;
			}else if (_atDestination){
				_atDestination = false;
			}
		}
	}
}