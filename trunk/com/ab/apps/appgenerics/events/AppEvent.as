package com.ab.apps.appgenerics.events
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const ACTIVITY_RESUMED:String  	= "activityresumed";
		public static const INACTIVITY_DETECTED:String 	= "inactivitydetected";
		public static const LOADED_SETTINGS:String 		= "loadedsettings";
		public static const LOADED_DATA:String 			= "loadeddata";
		
		public var data:*;
		
		public function AppEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new AppEvent(type, data);
		}
		
	}
}