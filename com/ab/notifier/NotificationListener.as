package com.ab.notifier 
{
	/**
	* @author AB
	*/
	
	public class NotificationListener 
	{
		public var notification:Notification;
		public var callback:Function;
		
		public function NotificationListener(notification:Notification, callback:Function) 
		{
			this.notification 	= notification;
			this.callback 		= callback;
		}
		
		public function notify():void
		{
			callback(notification);
		}
		
	}

}