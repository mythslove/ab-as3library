package com.ab.swfaddress 
{
	/**
	* @author ABº
	* 
	* Valid types:
	* 
	* Normal:    Creates object of specified class in specified level.
	* Function:  Executes a specified function
	* 
	* 
	* Normal:
	* 
	* var params_obj:Object = new Object();
	* params_obj.class 		= SomeClass;
	* params_obj.level 		= COREApi.LEVEL_MAIN;
	* 
	* SWFAddressManager.addAddress("lalala/lalala/", "Lalala Page", "normal", params_obj);
	* 
	* Function:
	* 
	* var params_obj:Object = new Object();
	* params_obj.function	= SomeFunction;
	* 
	* SWFAddressManager.addAddress("lalala/lalala/", "Lalala Page", "funciton", params_obj);
	*/
	
	public class SWFAddressManagerItem extends Object
	{
		private var _address:String;
		private var _title:String;
		private var _type:String;
		private var _params:Object;
		
		public function SWFAddressManagerItem() 
		{
			
		}
		
		public function get address():String 			{ return _address;  }
		public function set address(value:String):void  { _address = value; }
		
		public function get title():String 				{ return _title;  }
		public function set title(value:String):void  	{ _title = value; }
		
		public function get type():String 				{ return _type;  }
		public function set type(value:String):void  	{ _type = value; }
		
		public function get params():Object 			{ return _params;  }
		public function set params(value:Object):void  	{ _params = value; }
		
	}

}