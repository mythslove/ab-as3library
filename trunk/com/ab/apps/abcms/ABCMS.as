package com.ab.apps.abcms
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.abcms.mainmodules.session.UserManager;
	import com.ab.apps.abcms.mainmodules.session.LoginWindow;
	import flash.display.Sprite;
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	import com.ab.apps.abcms.mainmodules.browsers.SectionsNavigator;
	import com.ab.apps.abcms.mainmodules.browsers.ItemsBrowser;
	import com.ab.apps.abcms.mainmodules.browsers.MediaBrowser;
	import com.ab.apps.abcms.mainmodules.editors.ItemEditor;
	import com.ab.apps.abcms.mainmodules.editors.MediaEditor;
	import com.ab.apps.abcms.mainmodules.menu.MainMenu;
	
	public class ABCMS extends CasaSprite
	{
		public var _top_level:Sprite;
		public var _content_level:Sprite;
		public var _bg_level:Sprite;
		
		private var _USER_MANAGER:UserManager;
		private var _LOGIN:LoginWindow;
		private var _MAIN_MENU:MainMenu;
		
		public function ABCMS(root:CORE) 
		{
			initVars()
			
			start()
		}
		
		private function initVars():void
		{
			_MAIN_MENU 		= new MainMenu();
			_LOGIN 			= new LoginWindow();
			_USER_MANAGER   = new UserManager();
			
			_MAIN_MENU.title		 		= "MAIN MENU";
			_MAIN_MENU.custom_width 		= 300;
			_MAIN_MENU.custom_height 		= 600;
			_MAIN_MENU.tab_area_size		= 40;
			_MAIN_MENU.buttons_area_size	= 300;
			_MAIN_MENU.elements_spacing		= 1;
			_MAIN_MENU.frame_size 			= 5;
			_MAIN_MENU.x		 			= 0;
			_MAIN_MENU.y		 			= 0;
			
			_MAIN_MENU.setAlign("center");			
			
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