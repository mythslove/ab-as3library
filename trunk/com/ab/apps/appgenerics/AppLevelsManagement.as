package com.ab.apps.appgenerics 
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.level_top.AlertWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	public class AppLevelsManagement extends Sprite
	{
		private var _caller:*;
		private var _levels:Array;
		
		private var _alert_window_textformat:TextFormat;
		
		public static var __singleton:AppLevelsManagement;
		
		
		public function AppLevelsManagement(caller:*) 
		{
			_caller = caller;
			
			setVars()
			
			setSingleton()
		}
		
		private function setVars():void
		{
			_alert_window_textformat = new TextFormat();
			_alert_window_textformat.font = "Arial";
			//_alert_window_textformat.embedFonts = true;
			_alert_window_textformat.size = 10;
		}
		
		/////////////////////////////// INITIALIZATION //////////////////////////// ///
		
		private function onLevelsReceived():void
		{
			for (var i:int = 0; i < _levels.length; i++) 
			{
				if (i == _levels.length -1) 
				{
					levels[i].addEventListener(Event.ADDED_TO_STAGE, lastLeveladdedToStage, false, 0, true);
				}
				
				this.addChild(levels[i]);
			}
		}
		
		private function lastLeveladdedToStage(e:Event):void 
		{
			e.currentTarget.removeEventListener(Event.ADDED_TO_STAGE, lastLeveladdedToStage);
			
			_caller.init()
		}
		
		/// ////////////////////////////////// FUNCTIONS //////////////////////////////////// ///
		/// ////////////////////////////////// FUNCTIONS /////////////////////////////////// ///
		
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
		
		/// WARNING
		public function showWarning(_warning:String):void
		{
			var toplevel = getLevelByName("TOP_LEVEL")
			
			toplevel.addChild(new AlertWindow(_warning, 0.6, 0x000000, 0x000000, _alert_window_textformat));
		}
		
		/// LOGIN
		private function invokeLogin():void
		{
			/// _content_level.addChild(_LOGIN);
		}
		
		//////////////////////////////////////////////////////////////////////////////// BASIC
		//////////////////////////////////////////////////////////////////////////////// BASIC
		
		private function getLevelByName(_name:String):Object
		{
			var _object;
			
			for (var i:int = 0; i < _levels.length; i++) 
			{
				if (_levels[i].name == _name) 
				{
					//_levels[i].addChild(_object)
					
					_object = _levels[i];
				}
			}
			
			return _object;
		}
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("AppLevelsManagement ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():AppLevelsManagement
		{
			if (__singleton == null)
			{
				throw new Error("AppLevelsManagement ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		public function get levels():Array 				{ return _levels;  };
		public function set levels(value:Array):void  	{ _levels = value; onLevelsReceived()};
		
		public function get alert_window_textformat():TextFormat 			{ return _alert_window_textformat; }
		public function set alert_window_textformat(value:TextFormat):void  { _alert_window_textformat = value; }
		
	}
	
}