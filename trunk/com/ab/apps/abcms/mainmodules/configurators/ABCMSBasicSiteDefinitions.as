package com.ab.apps.abcms.mainmodules.configurators 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.DynamicWindow
	import flash.events.Event;
	
	public class ABCMSBasicSiteDefinitions extends DynamicWindow
	{
		import com.ab.display.DynamicWindow;
		import flash.events.Event;
		
		public function ABCMSBasicSiteDefinitions() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			build()
		}
		
		private function build():void
		{
			
		}
		
	}
	
}