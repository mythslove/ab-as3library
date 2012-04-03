package com.ab.notifier 
{
	/**
	 * ...
	 * @author AB
	 */
	
	import com.ab.notifier.Notification;
	
	public class CentralNotifier 
	{
		private static var notificationListeners:Vector.<NotificationListener>;
		
		public static function addNotificationListener(notification_id:String, callback:Function, data:*=null):void
		{
			var notification:Notification 					= new Notification(id, data);
			var notification_listener:NotificationListener 	= new NotificationListener(notification, callback);
			
			notificationListeners.push(new_notification_listener);
		}
		
		public static function notify(notification_id:String):void
		{
			var found:Boolean = false;
			
			for (var i:int = 0; i < notificationListeners.length; i++) 
			{
				if (notificationListeners[i].notification.id == notification_id) 
				{
					found = true;
					
					notificationListeners[i].notify();
					
					//return;
				}
			}
			
			if (!found) 
			{
				trace("Central Notifier ::: notify: '" + notification_id + "' could not be found");
			}
		}
		
		public static function removeListener(notification_id:String):void
		{
			var found:Boolean = false;
			
			for (var i:int = 0; i < notificationListeners.length; i++) 
			{
				if (notificationListeners[i].notification.id == notification_id) 
				{
					found = true;
					
					notificationListeners.splice(i, 1);
					
					return;
				}
			}
			
			if (!found) 
			{
				trace("Central Notifier ::: removeListener: '" + notification_id + "' could not be found");
			}
		}
		
	}

}