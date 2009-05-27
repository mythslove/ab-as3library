package com.ab.events
{
	/**
	* @author ABº
	* 
	* http://blog.antoniobrandao.com/
	*/
	
	import flash.events.Event;
	
	public class ABDataEvent extends Event
	{
		public var data:*;
		
		public function ABDataEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			super(type, _bubbles, _cancellable);
		}
		
	}
}