package com.ab.utils 
{
	
	/**
	* ...
	* @author ABº
	* 
	*/
	
	public class AS2Love 
	{
		
		public function AS2Love() 
		{
			
		}
		
		public static function removeClip(mc:Object):void 
		{ 
			if (mc != null)
			{
				mc.parent.removeChild(mc);
			}
		}
		
	}
	
}