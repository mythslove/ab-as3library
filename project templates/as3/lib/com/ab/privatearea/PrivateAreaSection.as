package com.ab.privatearea 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.DynamicWindowComponent;
	import com.ab.privatearea.PrivateAreaEvent;
	
	public class PrivateAreaSection extends DynamicWindowComponent
	{
		
		public function PrivateAreaSection()
		{
			this.addEventListener(PrivateAreaEvent.OPEN_SECTION, areaPrivadaSectionEventListener, false, 0, true);
		}
		
		private function areaPrivadaSectionEventListener(e:PrivateAreaEvent):void 
		{
			this.removeEventListener(PrivateAreaEvent.OPEN_SECTION, areaPrivadaSectionEventListener);
			
			goodbye();
		}
		
	}
	
}