package com.ab.core
	/**
	* @author ABº
	*/
	
	import com.ab.core.AppMode;
	import com.ab.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	
	public class AppModesManager extends Object
	{
		private var _mode:String;
		private var _modes:Array;
		private var _actual_app_mode:String;
		
		public function AppModesManager() 
		{
			_modes = new Array();
		}
		
		public function addMode(mode_name:String, function_call:Function):void
		{
			var new_app_mode:AppMode 	= new AppMode();
			
			new_app_mode.mode_name 		= mode_name;
			new_app_mode.function_call 	= function_call;
			
			_modes.push(new_app_mode);
		}
		
		public function set mode(mode_name:String):void  	
		{ 
			if (mode_name != mode) 
			{
				switch (mode_name)
				{
					case AppModes.DEBUG:
						
						COREApi.dispatchEvent(new AppEvent(AppEvent.MODE_CHANGE, AppModes.DEBUG));
						
					break;
					
					default:
						
						for (var i:int = 0; i < _modes.length; i++) 
						{
							if (AppMode(_modes[i]).mode_name == mode_name) 
							{
								_mode = AppMode(_modes[i]).mode_name;
								
								AppMode(_modes[i]).function_call();
								
								COREApi.dispatchEvent(new AppEvent(AppEvent.MODE_CHANGE, _modes[i].mode_name));
								
								break;
							}
						}
						
					break;
				}
			}			
		}
		
		public function get mode():String 				{ return _mode; }
		public function get modes():Array 				{ return _modes;  }
		
	}

}