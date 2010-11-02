package com.ab.core
{
	/**
	* @author ABº
	*/
	
	public class AppMode extends Object
	{
		private var _mode_name:String;
		private var _function_call:Function;
		
		public function AppMode() 
		{
			
		}
		
		public function get mode_name():String 					{ return _mode_name;  }
		public function set mode_name(value:String):void  		{ _mode_name = value; }
		
		public function get function_call():Function 			{ return _function_call;  }
		public function set function_call(value:Function):void  { _function_call = value; }
		
	}

}