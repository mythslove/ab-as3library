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
		public static const NORMAL:String 	= "normal";
		public static const FUNCTION:String = "function";
		
		private var _address:String;
		private var _title:String;
		private var _type:String;
		private var _params:Object;
		
		public function SWFAddressManagerItem(address:String, params:Object, title:String="", type:String="normal")
		{
			if (type != "normal" && type != "function" && type != "")  { type == "normal"; };
			
			_type 		= type;
			_address 	= address;
			_title		= title;
			_params		= params;
		}
		
		public function get address():String 			{ return _address;  }
		public function get title():String 				{ return _title;    }
		public function get type():String 				{ return _type;     }
		public function get params():Object 			{ return _params;   }
		
	}

}