package com.ab.core 
{
	import com.ab.events.AppEvent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Antonio Brandao
	 */
	public class DataManagerDataProcess 
	{
		private var dict:Dictionary;
		private var type:String;
		private var id:String;
		private var target_path:String;
		private var return_function:Function;
		
		public function DataManagerDataProcess(_dict:Dictionary, _type:String, _id:String, _target_path:String, _return_func:Function) 
		{
			this.target_path 	= _target_path;
			this.id 			= _id;
			this.type 			= _type;
			this.dict 			= _dict;
			
			if (_return_func!= null)
			{
				return_function = _return_func;
			}
			
			switch (type.toUpperCase()) 
			{
				case "XML":
					COREApi.getXMLdata(target_path, xmlReturnHandler);
				break;
			}
		}
		
		private function xmlReturnHandler(o:XML):void 
		{
			if (id != "" && id != "none") 
			{
				var new_data_object:DataManagerDataObject = new DataManagerDataObject(id, o);
				
				dict[id] = new_data_object;
				
				COREApi.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA_OBJECT, id));
			}
			
			if (return_function != null) 
			{
				return_function(o);
			}
		}
		
	}

}