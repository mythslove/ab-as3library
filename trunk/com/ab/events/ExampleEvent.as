package com.ab.events
{
	/**
	* @author ABº
	* 
	* see EventCentral class for details
	*/
	
	import flash.events.Event;
	
	public class ExampleEvent extends Event
	{
		public static const EVENT_TYPE:String = "event_type";
		
		public var data:*;
		
		public function ExampleEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new ExampleEvent(type, data);
		}
		
	}
}