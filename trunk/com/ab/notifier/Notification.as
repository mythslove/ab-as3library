package com.ab.notifier 
{
	/**
	* @author AB
	*/
	
	public class Notification 
	{
		public var id:String;
		public var data:*;
		
		public function Notification(id:String, data:*=null) 
		{
			this.id 	= id;
			this.data 	= data;
		}
		
	}

}