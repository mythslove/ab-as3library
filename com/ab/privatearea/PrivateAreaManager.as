package com.ab.privatearea 
{
	/**
	* @author ABº
	*/
	
	public class PrivateAreaManager
	{
		private var _LOGGED_IN:Boolean = false;
		private var _USER_ID:int = 0;
		
		public function PrivateAreaManager() 
		{
			
		}
		
		static public function get LOGGED_IN():Boolean 				{ return _LOGGED_IN; 	};
		static public function set LOGGED_IN(value:Boolean):void  	{ _LOGGED_IN = value; 	};
		
		static public function get USER_ID():int 					{ return _USER_ID; 		};
		static public function set USER_ID(value:int):void  		{ _USER_ID = value; 	};
		
	}
	
}