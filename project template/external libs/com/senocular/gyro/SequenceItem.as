package com.senocular.gyro {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Object representing the callback/event information for an item the sequence
	 */
	class SequenceItem extends EventDispatcher {
		
		public var target:IEventDispatcher;	// object handling events for event id
		public var eventType:String;		// event id to indicate callback completion and start of next event
		public var initiator:Function;		// event id to indicate callback completion and start of next event
		public var initiatorArguments:Array = [];		// event id to indicate callback completion and start of next event
			
		/**
		 * Constructor
		 */
		public function SequenceItem(target:IEventDispatcher = null, eventType:String = Event.COMPLETE, initiator:Function = null, initiatorArguments:Array = null):void {
			this.target = (target) ? target : this;
			this.eventType = eventType;
			this.initiator = (initiator == null) ? complete : initiator;
			this.initiatorArguments = (initiatorArguments) ? initiatorArguments : [];
		}
		
		/**
		 * Default initiator event that immediately calls the completion event.
		 */
		private function complete():void {
			dispatchEvent(new Event(eventType));
		}
	}
}