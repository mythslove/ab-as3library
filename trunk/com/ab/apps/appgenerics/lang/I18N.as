package com.ab.apps.appgenerics.lang
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.ab.apps.appgenerics.lang.I18NEvent
	
	public class I18N extends EventDispatcher
	{
		private static var instance:I18N = new I18N();
		
		public static const EN:String    = "en";
		public static const PT:String    = "pt";
		
		public static var DEFAULT:String = EN;
		private static var _LANG:String  = EN;
		
		
		//public function I18N() 
		//{
			//super();
		//}
		
		static public function get LANG():String { return _LANG; }
		
		static public function set LANG(value:String):void 
		{
			if (value != _LANG) 
			{
				_LANG = value;
				
				dispatchEvent(new I18NEvent(I18NEvent.LANG_CHANGE));
			}
		}
		
		static public function translate(o:Object):String
		{
			trace(_LANG)
			trace(o)
			
			var t:Object = o[_LANG];
			
			if (t == null) t = o[DEFAULT];
			
			for each(var r in o) return r;
			
			trace("I18N ::: Translation not found for " + o);
			
			return "I18N ::: not found";
		}
		
	}
	
}