package com.edigma.events
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class CustomMouseEvent extends Event
	{
		public static const CLICK:String 		= "click";
		public static const MOUSE_OVER:String 	= "mouseover";
		public static const MOUSE_OUT:String 	= "mouseout";
		public static const ROLL_OUT:String 	= "rollout";
		public static const ROLL_OVER:String  	= "rollover";
		
		/// interactivity events
		
		public var data:*;
		
		public function CustomMouseEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new CustomMouseEvent(type, data);
		}
		
	}
}