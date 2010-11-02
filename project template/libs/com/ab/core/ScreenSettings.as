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
		import org.casalib.util.StageReference;
		
		public static function init():void
		{
			StageReference.getStage().displayState 				= StageDisplayState.NORMAL;
			StageReference.getStage().quality 					= StageQuality.BEST;
			StageReference.getStage().scaleMode 				= StageScaleMode.NO_SCALE;
			StageReference.getStage().align 					= StageAlign.TOP_LEFT;
			StageReference.getStage().showDefaultContextMenu 	= false;
		}
		
		public static function setFullScreen():void
		{
			StageReference.getStage().displayState 				= StageDisplayState.FULL_SCREEN;
		}
		
		public static function setNormalScreen():void
		{
			StageReference.getStage().displayState 				= StageDisplayState.NORMAL;
		}
		
	}
	
}