package com.ab.apps.abcms.mainmodules.menu 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.DynamicWindow;
	import flash.events.Event;
	
	public class ContentMenu extends DynamicWindow
	{
		
		public function ContentMenu() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			build();
		}
		
		private function build():void
		{
			
		}
		
	}
	
}