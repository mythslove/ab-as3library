package com.ab.core
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
	*/
	
	public class ScreenSettings 
	{
		import flash.display.StageAlign;
		import flash.display.StageDisplayState;
		import flash.display.StageQuality;
		import flash.display.StageScaleMode;
		
		public static function init():void
		{
			AppManager.stage.displayState 			= StageDisplayState.NORMAL;
			AppManager.stage.quality 				= StageQuality.BEST;
			AppManager.stage.scaleMode 				= StageScaleMode.NO_SCALE;
			AppManager.stage.align 					= StageAlign.TOP_LEFT;
			AppManager.stage.showDefaultContextMenu = false;
		}
		
		public static function setFullScreen():void
		{
			AppManager.stage.displayState 			= StageDisplayState.FULL_SCREEN;
		}
		
		public static function setNormalScreen():void
		{
			AppManager.stage.displayState 			= StageDisplayState.NORMAL;
		}
		
	}
	
}