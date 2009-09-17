package com.ab.apps.appgenerics 
{
	/**
	* @author ABº
	* 
	* @EDIGMACOM
	*/
	
	import caurina.transitions.properties.DisplayShortcuts;
	import com.ab.display.PatternFill;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.util.StageReference;
	import com.ab.events.CentralEventSystem;
	import net.hires.debug.Stats
	import com.edigma.web.EdigmaCore;
	import com.ab.apps.appgenerics.AppLevelsManagement;
	import com.ab.apps.appgenerics.AppLevelsManager
	import com.ab.log.ABLogger;
	import com.ab.web.ABCore;
	
	public class APPCORE extends Sprite
	{
		/// private
		private var _appInfo:ABCore;
		private var _levelsManagement:AppLevelsManagement;
		private var _loadedXML:Boolean=false;
		private var _loadedContent:Boolean=false;
		private var _CentralEventSystem:CentralEventSystem;
		private var _appLogger:ABLogger;
		private var _appLevels:Sprite;
		
		
		public function APPCORE() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStage)
		}
		
		private function addedToStage(e:Event):void  { init(); }
		
		private function init():void
		{ 
			StageReference.setStage(this.stage); 
			
			_appLevels  		= new Sprite();
			_appLogger 			= new ABLogger();
			_appInfo   			= new ABCore(this);
			
			/// fazer fundo pixelizado
			var pixeldata:Array = new Array(); 
			pixeldata = [" ", "*"];
			stage.addChild(new PatternFill(stage.stageWidth, stage.stageHeight, pixeldata, 0x000000));
			
			stage.addChild(_appLevels);
			stage.addChild(_appLogger);
			
			_appLogger.x += 300;
		}
		
	}
	
}