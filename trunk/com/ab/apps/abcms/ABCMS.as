package com.ab.apps.abcms
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.AppLevelsManagement;
	import com.ab.apps.appgenerics.lang.I18N;
	import org.casalib.util.StageReference;
	
	import com.ab.apps.abcms.mainmodules.menu.ABCMSMainMenu;
	import com.ab.apps.abcms.mainmodules.session.UserManager;
	import com.ab.apps.abcms.mainmodules.session.LoginWindow;
	import com.ab.apps.abcms.mainmodules.configurators.ABCMSSiteTextFormats;
	import com.ab.apps.appgenerics.level_bg.Background;
	
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
		private var _LEVELS_MANAGEMENT:AppLevelsManagement;
		private var _BACKGROUND:Background;
		
		private var _ROOT_CORE:CORE;
		private var _I18N:I18N;
		private var _main_menu_level:Sprite;
		
		public function ABCMS(root:CORE) 
		{
			_ROOT_CORE = root;
			
			initVars();
			
			start();
		}
		
		private function initVars():void
		{
			I18N.LANG = I18N.EN;
			
			_MAIN_MENU 			= new ABCMSMainMenu();
			_LOGIN 				= new LoginWindow();
			_USER_MANAGER   	= new UserManager();
			_LEVELS_MANAGEMENT	= new AppLevelsManagement(this);
			_BACKGROUND			= new Background();
			
			_LEVELS_MANAGEMENT.alert_window_textformat = ABCMSSiteTextFormats.WARNING();
			
			_MAIN_MENU.title		 		= "MAIN MENU";
			_MAIN_MENU.custom_width 		= 300;
			_MAIN_MENU.bg_colour 			= 0x000000;
			_MAIN_MENU.custom_height 		= 600;
			_MAIN_MENU.tab_area_size		= 20;
			_MAIN_MENU.button_spacing		= 5;
			_MAIN_MENU.status				= "centered";
			_MAIN_MENU.elements_spacing		= 1;
			_MAIN_MENU.tabtext_style		= ABCMSSiteTextFormats.H3P();
			_MAIN_MENU.x		 			= 0;
			_MAIN_MENU.y		 			= 0;
			
			
			_BACKGROUND.custom_width 		= StageReference.getStage().stageWidth;
			_BACKGROUND.custom_height 		= StageReference.getStage().stageHeight;
			//_BACKGROUND.gradient_array		= [0x31383a, 0x286e80];
			_BACKGROUND.gradient_array		= [0x202628, 0x286e80];
			//_BACKGROUND.alpha				= .5;
			
			_top_level 			= new Sprite();
			_content_level 		= new Sprite();
			_bg_level 			= new Sprite();
			_main_menu_level	= new Sprite();
			
			
			_top_level.name 		= "TOP_LEVEL";
			_content_level.name 	= "CONTENT_LEVEL";
			_bg_level.name 			= "BG_LEVEL";
			_main_menu_level.name 	= "MAIN_MENU_LEVEL";
		}   
		
		private function start():void
		{
			_LEVELS_MANAGEMENT.addEventListener(Event.ADDED_TO_STAGE, levelManagementAdded, false, 0, true);
			
			this.addChild(_LEVELS_MANAGEMENT);
		}
		
		private function levelManagementAdded(e:Event):void 
		{
			_LEVELS_MANAGEMENT.removeEventListener(Event.ADDED_TO_STAGE, levelManagementAdded);
			
			var levelsarray:Array = new Array()
			
			levelsarray = [_bg_level, _content_level, _main_menu_level, _top_level];
			
			_LEVELS_MANAGEMENT.levels = levelsarray;
		}
		
		/// called by AppLevelsManagement after all levels are added to stage
		public function init():void
		{
			createMainMenu();
		}
		
		private function createMainMenu():void
		{
			_LEVELS_MANAGEMENT.addDisplayObjectToLevel("BG_LEVEL", _BACKGROUND);
			_LEVELS_MANAGEMENT.addDisplayObjectToLevel("MAIN_MENU_LEVEL", _MAIN_MENU);
		}
		
	}
	
}