package com.ab.apps.abcms
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.abcms.mainmodules.menu.ABCMSMainMenu;
	import com.ab.apps.abcms.mainmodules.session.UserManager;
	import com.ab.apps.abcms.mainmodules.session.LoginWindow;
	import com.ab.apps.appgenerics.lang.I18N;
	//import com.ab.lang.I18N;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	
	public class ABCMS extends CasaSprite
	{
		public var _top_level:Sprite;
		public var _content_level:Sprite;
		public var _bg_level:Sprite;
		
		private var _USER_MANAGER:UserManager;
		private var _LOGIN:LoginWindow;
		private var _MAIN_MENU:ABCMSMainMenu;
		private var _ROOT_CORE:CORE;
		private var _I18N:I18N;
		
		public function ABCMS(root:CORE) 
		{
			_ROOT_CORE = root;
			
			initVars();
			
			start();
		}
		
		private function initVars():void
		{
			//_I18N = new I18N();
			
			I18N.LANG = I18N.EN;
			
			_MAIN_MENU 		= new ABCMSMainMenu();
			_LOGIN 			= new LoginWindow();
			_USER_MANAGER   = new UserManager();
			
			_MAIN_MENU.title		 		= "MAIN MENU";
			_MAIN_MENU.custom_width 		= 300;
			_MAIN_MENU.custom_height 		= 600;
			_MAIN_MENU.tab_area_size		= 40;
			//_MAIN_MENU.buttons_area_size	= 300;
			_MAIN_MENU.elements_spacing		= 1;
			//_MAIN_MENU.frame_size 			= 5;
			_MAIN_MENU.x		 			= 0;
			_MAIN_MENU.y		 			= 0;
			//_MAIN_MENU.h_padding 			= -_MAIN_MENU.custom_width + _MAIN_MENU.tab_area_size + _MAIN_MENU.elements_spacing ;
			_MAIN_MENU.status 				= "docked";
			
			_top_level 		= new Sprite();
			_content_level 	= new Sprite();
			_bg_level 		= new Sprite();
		}
		
		private function start():void
		{
			/// uma entrada porreira
			
			/// drop main menu centered
			
			this.addChild(_top_level);
			this.addChild(_content_level);
			this.addChild(_bg_level);
			
			_content_level.x = 0;
			_content_level.y = 0;
			
			createMainMenu();
			invokeLogin();
		}
		
		private function invokeLogin():void
		{
			/// _content_level.addChild(_LOGIN);
		}
		
		private function createMainMenu():void
		{
			_content_level.addChild(_MAIN_MENU);
			//addChild(_MAIN_MENU);
		}
		
	}
	
}