package com.edigma.appgenerics 
{
	/**
	* @author ABº
	*/
	
	import com.ab.core.COREApi;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	
	public class EdigmaApplicationBase extends Sprite
	{
		public function EdigmaApplicationBase() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			COREApi.addContextMenuItem("Copyright 2010 EDIGMA.COM S.A.", edigmaHandler);
			COREApi.addContextMenuItem("Powered by NetBusiness - Smart Solutions", netbusinessHandler);
		}
		
		private function edigmaHandler():void
		{
			Web.getURL("http.//www.edigma.com/", "_blank");
		}
		
		private function netbusinessHandler():void
		{
			Web.getURL("http://www.edigma.com/index.php?cat=8&item=1108", "_blank");
		}
		
	}

}