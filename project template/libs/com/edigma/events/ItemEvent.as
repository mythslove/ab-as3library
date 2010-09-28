package com.edigma.events
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class ItemEvent extends Event
	{
		public static const OPEN_ITEM:String  	= "openitem";
		public static const CLOSE_ITEM:String 	= "closeitem";
		public static const LOADED:String 	  	= "loaded";
		public static const DATA_LOADED:String	= "dataloaded";
		public static const SELECT:String		= "select";
		
		public var data:*;
		
		public function ItemEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new ItemEvent(type, data);
		}
		
	}
}