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
	
	import com.ab.core.COREApi;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	
	public class SWFAddressManager extends Object
	{
		private var addresses:Array = new Array();
		
		public function SWFAddressManager() 
		{
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, handleSWFAddress);
			
			SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Home");
		}
		
		public function addAddress(_address:String, _title:String, type:String="normal", _params:Object=null):void
		{
			var newitem:SWFAddressManagerItem 	= new SWFAddressManagerItem();
			
			newitem.address 					= _address;
			newitem.title 						= _title;
			newitem.type 						= _type;
			newitem.params 						= _params;
			
			addresses.push(newitem);
		}
		
		/// SWFAddress handling
		private function handleSWFAddress(e:SWFAddressEvent) 
		{
			trace("::: SWFAddress path :"  + SWFAddress.getPath()  + ":");
			trace("::: SWFAddress value :" + SWFAddress.getValue() + ":");
			
			var _class:Class;
			
			for (var i:int = 0; i < addresses_container.length; i++) 
			{
				if (addresses_container[i].address == SWFAddress.getPath())
				{
					switch (addresses_container[i].type)
					{
						case "normal":
							_class = addresses_container[i].params.class;
							
							COREApi.addChildToLevel(new _class(), addresses_container[i].params.level);
						break;
						
						case "function":
							addresses_container[i].params.functionname();
						break;
					}
				}
			}
			
			
			
			switch(SWFAddress.getPath())
			{
				case "/empresa/":
					SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Empresa");
				break;
				
				case "/produtos/":
					
					SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Produtos");
				break;
				
				case "/portfolio/":
					SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Portfolio");
				break;
				
				case "/contactos/":
					SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Contactos");
				break;
				
				case "/newsletter/":
					SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Newsletter");
				break;
				
				default:
					SWFAddress.setTitle(EdigmaCore.singleton.SITE_TITLE + " : Home");
				break;	
			}
		}
		
	}

}