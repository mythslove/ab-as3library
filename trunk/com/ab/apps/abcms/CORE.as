package com.ab.apps.abcms
{
	/**
	* @author ABº
	*/
	
	import com.ab.events.CentralEventSystem
	/// import abcms.menusections.SectionsMenu
	
	import com.ab.display.ABSprite
	import com.ab.services.ServerCommunication
	//import com.ab.as3websystem.core.system.ScreenSettings
	//import com.ab.web.ABCore
	import org.casalib.util.StageReference
	
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import com.ab.log.ABLogger;
	import com.ab.apps.abcms.keyboard.AppKeyboardControl;
	
	public class CORE extends Sprite
	{
		private var _ABCMS:ABCMS;
		
		private var _events_system:CentralEventSystem
		private var _server_communication:ServerCommunication;
		private var _logger:ABLogger;
		private var _keyboard:AppKeyboardControl;
		
		//private var _screen_settings:ScreenSettings;
		//private var test_menu:SectionsMenu;
		//private var main_panel:Panel;
		
		public var bg_mc:Object;
		
		public function CORE() 
		{
			trace("")
			initVars()
			start()
		}
		
		private function start():void
		{
			//this.addChild(_ABCMS)
			this.addChild(_logger)
		}
		
		private function initVars():void
		{
			StageReference.setStage(stage)
			
			_ABCMS         = new ABCMS(this);
			_logger        = new ABLogger();
			_logger.totalwidth = 300;
			_keyboard	   = new AppKeyboardControl();
			
			_server_communication = new ServerCommunication();
			
			//ABCore.getSingleton();
			
			trace("asd")
		}
		
	}
	
}











	/*
	if (nini.kissBihaninhu() ==  true) 
	{
		bihaninhu.smile(true)
	}
	else 
	{
		bihaninhu.smile(false)
	}*/


/**


			_screen_settings = new ScreenSettings(this);
			_server_communication = new ServerCommunication();
			
			main_panel = new Panel()
			
			this.addChild(main_panel)
			
			main_panel._height = 400;
			main_panel._width = 600;
			main_panel.bg_colour = 0x000000;
			
			main_panel.build()
			
			test_menu = new SectionsMenu();
			
			main_panel.addChild(test_menu);
			
			main_panel.setAlign("center", true, true, 400, 600)
			
			test_menu.setAlign("topleft", false, false, 0, 0, 10, 10)
			
			
/*/