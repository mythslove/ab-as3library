package com.ab.swfaddress
{
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	* 
	* 
	* Valid types:
	* 
	* Normal:    Creates object of specified class in specified level (also executes some Function if provided).
	* Function:  Just executes a specified function
	* 
	* 
	* @usage:
	* 
	* Adding a "normal" situation:
	* 
	* var params_obj:Object = new Object();
	* params_obj.class 		= SomeClass;
	* params_obj.level 		= COREApi.LEVEL_MAIN;
	* 
	* SWFAddressManager.addAddress("Lalala Page", "lalala/lalala/", params_obj, "normal");
	* 
	* Adding a "function" situation:
	* 
	* var params_obj:Object = new Object();
	* params_obj.function	= SomeFunction;
	* 
	* SWFAddressManager.addAddress("Lalala Page", "lalala/lalala/", params_obj, "function");
	* 
	* 
	* @calling situations
	* 
	* - simple:
	* 
	* COREApi.setSituation("Section 3", lalala); 
	* 
	* - including optional parameters;
	* 
	* var lalala:Object 	= new Object();
	* lalala.cat 			= "12";
	* lalala.op 			= "6";
	* 
	* COREApi.setSituation("Section 3", lalala); 
	* 
	*/
	
	import com.ab.core.COREApi;
	import com.ab.appobjects.ApplicationItem;
	import com.ab.appobjects.WebsiteSection;
	
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public class SWFAddressManager extends Object
	{
		private static var addresses:Array = new Array();
		private static var _site_title:String;
		private static var current_base_address:String="";
		private static var times_count:int;
		
		public static function activate():void
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddressChange);
		}
		
		public static function get site_title():String 			{ return _site_title;   }
		public static function set site_title(value:String):void  	{  _site_title = value; }
		
		/// GET CURRENT VALUE
		/// GET CURRENT VALUE
		/// GET CURRENT VALUE
		
		public static function getCurrentValue():String
		{
			return SWFAddress.getValue();
		}
		
		public static function processCurrentAddress():void
		{
			COREApi.log("processCurrentAddress: " + SWFAddress.getPathNames()[0]);
			trace("com.ab.swfaddress.SWFAddressManager.processCurrentAddress");
			handleSWFAddress();
		}
		
		/// ADD ADDRESS
		/// ADD ADDRESS
		/// ADD ADDRESS
		
		public static function addAddress(_title:String, _address:String, _params:Object=null, _type:String="normal"):void
		{
			var newitem:SWFAddressManagerItem = new SWFAddressManagerItem(_address, _params, _title, _type);
			
			addresses.push(newitem);
		}
		
		/// SET ADDRESS
		/// SET ADDRESS
		/// SET ADDRESS
		
		public static function setAddress(title:String, extra_params:Object = null):void
		{
			trace("com.ab.swfaddress.SWFAddressManager.setAddress > title : " + title + ", extra_params : " + extra_params);
			
			var extraparamstring:String = "";
			
			if (extra_params != null) 
			{
				extraparamstring = "?";
				
				for (var param:* in extra_params)
				{
					/*
					* para ver os parametros enviados e respectivos valores
					* 
					* trace(param + " :: " + extra_params[param]);
					*/
					
					if (extraparamstring != "?") 
					{
						extraparamstring = extraparamstring + "&" + param + "=" + extra_params[param];
					}
					else
					{
						extraparamstring = extraparamstring + param + "=" + extra_params[param];
					}
				}
				
				/*
				* para ver o que é acrescentado no swfaddress
				* 
				* trace("extraparamstring : " + extraparamstring);
				*/ 
			}
			
			for (var i:int = 0; i < addresses.length; i++) 
			{
				trace("String(addresses[i].title).toUpperCase() : " + String(addresses[i].title).toUpperCase());
				
				if (String(addresses[i].title).toUpperCase() == title.toUpperCase())
				{
					
					SWFAddress.setValue(addresses[i].address + "/" + extraparamstring);
				}
			}
		}
		
		/// SWFAddress handling
		private static function handleSWFAddressChange(e:SWFAddressEvent=null):void
		{
			if (e)  { e.stopPropagation(); };
			
			handleSWFAddress();
		}
		
		/// SWFAddress handling
		private static function handleSWFAddress():void
		{
			COREApi.log("-------- " + times_count + " ----------- ");
			COREApi.log("handleSWFAddress: SWFAddress.getPathNames()[0]: " + SWFAddress.getPathNames()[0]);
			COREApi.log("handleSWFAddress: current_base_address: " + current_base_address);
			
			trace("::: SWFAddress changed. new path: "  + SWFAddress.getPath());
			trace("::: SWFAddress changed. new value: " + SWFAddress.getValue());
			
			times_count++;
			
			if (SWFAddress.getPathNames()[0] != current_base_address)
			{
				var _class:Class;
				
				var found:Boolean = false;
				
				for (var i:int = 0; i < addresses.length; i++) 
				{
					COREApi.log("addresses[i].address : " + addresses[i].address);
					
					if (addresses[i].address == SWFAddress.getPathNames()[0])
					{
						trace("swfaddress manager: addresses found: " + addresses[i].address);
						
						found = true;
						
						if (addresses[i].title)
						{
							if (addresses[i].title != "")  { SWFAddress.setTitle(site_title + " : " + addresses[i].title); }
						}
						
						switch (addresses[i].type)
						{
							case "function":
								
								for each (var x:* in addresses[i].params)  { if (x is Function) { x(); } };
								
							break;
							
							case "normal":
							
							default:
								
								for each (var w:* in addresses[i].params) 
								{
									//trace("typeof addresses[i] : " + typeof addresses[i]);
									
									if (w is Class)
									{ 
										var classref:* 		= w;
										var new_instance:*	= new classref();
										
										if (new_instance is ApplicationItem) 
										{ 
											ApplicationItem(new_instance).swfaddress_path = addresses[i].address;
										}
										else
										{
											if (new_instance is WebsiteSection) 
											{
												WebsiteSection(new_instance).swfaddress_path = addresses[i].address;
											}
										}
										
										COREApi.addChildToLevel(new_instance, addresses[i].params.level);
									}
									else 
									{ 
										if (w is Function) { w(); }; 
									}
								}
								
							break;
						}
					}
				}
				
				COREApi.log("found : " + found);
				
				if (found) 
				{
					current_base_address = SWFAddress.getPathNames()[0];
				}
				else
				{
					trace("swfaddress manager: address NOT found: " + SWFAddress.getPathNames()[0]);
				}
				
				
			}
		}
	}
}