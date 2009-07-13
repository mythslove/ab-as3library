package com.ab.apps.appgenerics 
{
	/**
	* 
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* use it screw it and sell it, no problem
	* 
	* @about
	* later
	* 
	*/
	
	public class ScreenSettings 
	{
		import flash.display.StageQuality;
		import org.casalib.util.StageReference;
		
		public static function init():void
		{
			StageReference.getStage().quality = StageQuality.BEST;
			StageReference.getStage().scaleMode = "noScale";
			StageReference.getStage().showDefaultContextMenu = false;
			StageReference.getStage().align = "TL";
		}
		
	}
	
}