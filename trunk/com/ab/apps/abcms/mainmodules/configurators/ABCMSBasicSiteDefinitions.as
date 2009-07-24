package com.ab.apps.abcms.mainmodules.configurators 
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.AppLevelsManagement;
	import com.ab.display.ABSprite;
	import flash.events.Event;
	
	public class ABCMSBasicSiteDefinitions extends ABSprite
	{
		
		
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
			trace ("ABCMSBasicSiteDefinitions ::: build()"); 
			
			AppLevelsManagement.getSingleton().showWarning("UNDER CONSTRUCTION - PLEASE FUCK OFF AND COME BACK LATER");
		}
		
	}
	
}