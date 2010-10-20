package com.ab.apps.appgenerics.applicationbase
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	
	public class ABApplicationBase extends Sprite
	{
		public function ABApplicationBase() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			COREApi.addContextMenuItem("Copyright 2010 Antonio Brandao.", copyrightHandler);
			COREApi.addContextMenuItem("Powered by Adobe", poweredHandler);
		}
		
		private function copyrightHandler():void
		{
			//Web.getURL("http.//www.edigma.com/", "_blank");
		}
		
		private function poweredHandler():void
		{
			//Web.getURL("http://www.edigma.com/index.php?cat=8&item=1108", "_blank");
		}
		
	}

}