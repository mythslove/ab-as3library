package com.ab.apps.abcms
{
	/**
	* @author ABº
	*/
	
	//import com.ab.web.ABCore
	import com.ab.apps.abcms.mainmodules.menu.MainMenu;
	import com.ab.events.CentralEventSystem;
	import com.ab.apps.appgenerics.ScreenSettings;
	import com.ab.display.ABSprite;
	import com.ab.services.ServerCommunication;
	import org.casalib.util.StageReference
	/// import abcms.menusections.SectionsMenu
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import com.ab.log.ABLogger;
	import com.ab.apps.abcms.keyboard.AppKeyboardControl;
	
	public class CORE extends Sprite
	{
		private var _ABCMS:ABCMS;
		
		private var _logger:ABLogger;
		private var _keyboard:AppKeyboardControl;
		private var _events_system:CentralEventSystem;
		private var _server_communication:ServerCommunication;
		
		public var bg:MovieClip;
		
		///private var test_menu:SectionsMenu;
		
		public function CORE() 
		{
			initVars();
			start();
		}
		
		private function start():void
		{
			//this.addChild(_ABCMS)
			this.addChild(_logger)
			this.addChild(_ABCMS)
		}
		
		private function initVars():void
		{
			StageReference.setStage(stage)
			ScreenSettings.init()
			
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