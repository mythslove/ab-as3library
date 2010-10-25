package com.ab.apps.abcms.mainmodules.configurators 
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.properties.CurveModifiers;
	import com.ab.core.AppLevelsManagement;
	import com.ab.display.ABSprite;
	import flash.events.Event;
	import com.ab.services.ABServerCommunication;
	
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
			
			var asd:Array = new Array();
			asd = [];
			
			ABServerCommunication.__singleton.listSectionsRequest(1, yeah);
		}
		
		private function yeah(O:Object):void
		{
			trace("result999");
		}
		
	}
	
}