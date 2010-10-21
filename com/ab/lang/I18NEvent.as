package com.ab.lang
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class I18NEvent extends Event
	{
		public static const LANGUAGE_CHANGE:String = "lang";
		
		public var current_language:String = I18N.DEFAULT;
		public var next_language:String    = "pt";
		
		public function I18NEvent(type:String = null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
	
}