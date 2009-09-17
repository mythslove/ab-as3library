package com.ab.apps.appgenerics 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	import com.ab.events.CentralEventSystem;
	
	public class AppLevelsManager extends Sprite
	{
		/// private
		private var BG_LEVEL:Sprite
		private var APP_LEVEL:Sprite
		private var TOP_LEVEL:Sprite
		private var _levels:Array
		
		/// singleton
		public static var __singleton:AppLevelsManager;
		
		/// fazer addClassObjectToLevel
		
		public function AppLevelsManager() 
		{
			initVars();
			setSingleton();
			addLevelsToStage();
			start();
		}
		
		private function initVars():void
		{
			BG_LEVEL 		= new Sprite();
			APP_LEVEL 		= new Sprite();
			TOP_LEVEL 		= new Sprite();
			
			BG_LEVEL.name  	= "BG_LEVEL";
			APP_LEVEL.name 	= "APP_LEVEL";
			TOP_LEVEL.name 	= "TOP_LEVEL";
			
			_levels 		= new Array();
			_levels 		= [BG_LEVEL, APP_LEVEL, TOP_LEVEL];
			
			///CentralEventSystem.getSingleton().addEventListener(
		}
		
		private function addLevelsToStage():void
		{
			addChild(BG_LEVEL);
			addChild(APP_LEVEL); 
			addChild(TOP_LEVEL);
		}
		
		private function start():void
		{
			/// call main menu in app level to start app
		}
		
		public function addDisplayObjectToLevel(_levelame:String, _object:*):void
		{
			for (var i:int = 0; i < _levels.length; i++) 
			{
				if (_levels[i].name == _levelame) 
				{
					_levels[i].addChild(_object);
				}
			}
		}
		
		public function addClassObjectToLevel(_levelame:String, __class:*):void
		{
			var _object = new __class();
			
			var level = getLevelByName(_levelame);
			
			level.addChild(_object);
		}
		
		private function getLevelByName(_name:String):Object
		{
			var _object;
			
			for (var i:int = 0; i < _levels.length; i++) 
			{
				if (_levels[i].name == _name) 
				{
					_object = _levels[i];
				}
			}
			
			return _object;
		}
		
		/// SET SINGLETON
		
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("AppLevelsManager ::: SINGLETON REPLICATION ATTEMPTED") }
			__singleton = this
		}
		
		public static function getSingleton():AppLevelsManager
		{
			if (__singleton == null) { throw new Error("AppLevelsManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }			
			return __singleton;
		}
		
	}
	
}