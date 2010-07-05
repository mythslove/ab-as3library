package com.senocular.gyro {

	import flash.events.Event;
	
	public class GyroEvent extends Event {
		
		public static const AT_DESTINATION:String = "atDestination";
		public static const COMPLETE:String = "complete";
		public static const PAUSE:String = "pause";
		public static const REPEAT:String = "repeat";
		public static const REVERSE:String = "reverse";
		public static const START:String = "start";
		public static const STOP:String = "stop";
		public static const TWEEN:String = "tween";
	
		protected var _source:*; // TODO: generalized motion-er for gyro (IStartable? different interface? Different base class?  How many classes are dispatching this?)
			
		public function get source():* {
			return _source;
		}
		
		public function GyroEvent(type:String, source:* = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_source = source;
		}
		public override function clone():Event {
			return new GyroEvent(type, bubbles, cancelable, _source);
		}
	}
}