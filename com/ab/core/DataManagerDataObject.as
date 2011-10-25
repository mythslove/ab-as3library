package com.ab.core 
{
	/**
	 * ...
	 * @author Antonio Brandao
	 */
	public class DataManagerDataObject 
	{
		public var type:String;
		public var id:String;
		public var data:*;
		
		public function DataManagerDataObject(_id:String, _data:*, _type:String="XML")
		{
			id = _id;
			data = _data;
			type = _type;
		}
		
	}

}