package com.ab.apps.appgenerics.edigma
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.utils.Web;
	import flash.display.Sprite;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	
	public class DisplaxApplicationBase extends Sprite
	{
		
		public function DisplaxApplicationBase() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			COREApi.addContextMenuItem("Copyright DISPLAX 2010", displaxHandler);
		}
		
		private function displaxHandler():void
		{
			Web.getURL("http.//www.displax.com/", "_blank");
		}
		
	}

}