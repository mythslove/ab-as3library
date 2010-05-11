package com.ab.apps.appgenerics.events
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class AppEvent extends Event
	{
		public static const INTRO_RESUMED:String 		= "introresumed";
		public static const LOADED_SETTINGS:String 		= "loadedsettings";
		public static const LOADED_DATA:String 			= "loadeddata";
		public static const MODE_CHANGE:String 			= "modechange";
		public static const ACTIVITY_RESUMED:String  	= "activityresumed";
		public static const INACTIVITY_DETECTED:String 	= "inactivitydetected";
		public static const TOGGLE_MAIN_MENU:String 	= "togglemainmenu";
		public static const APP_STEP_FURTHER:String 	= "appstepfurther";
		public static const UPDATE_MENU:String 			= "updatemenu";
		public static const CLEAN_MENU:String 			= "cleanmenu";
		public static const RESET_APP:String 			= "resetapp";
		
		/// interactivity events
		//public static const MOUSE_UP:String 			= "mouseup";
		//public static const MOUSE_DOWN:String 			= "mousedown";
		
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