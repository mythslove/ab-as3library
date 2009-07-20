package com.ab.privatearea
{
	/**
	* @author ABº
	* 
	* @EDIGMACOM
	*/
	
	import flash.events.Event;
	
	public class PrivateAreaEvent extends Event
	{
		public static const LOGGED_IN:String     = "loggedin";
		public static const LOGGED_OUT:String    = "loggedout";
		public static const EDIT_USERDATA:String = "edituserdata";
		public static const OPEN_SECTION:String  = "opensection";
		
		public var data:*;
		
		public function PrivateAreaEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new PrivateAreaEvent(type, data);
		}
		
	}
}