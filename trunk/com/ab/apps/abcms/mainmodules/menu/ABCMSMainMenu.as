package com.ab.apps.abcms.mainmodules.menu
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import com.ab.menu.SideTabMenu;
	import flash.events.Event;
	import com.ab.apps.abcms.mainmodules.menu.ABCMSMainMenuItem;
	
	public class ABCMSMainMenu extends SideTabMenu
	{
		//private var _options:Array;
		private var _num_options:Array;
		
		private var _option_1:Object;
		private var _option_2:Object;
		private var _option_3:Object;
		private var _option_4:Object;
		
		public function ABCMSMainMenu() 
		{
			initVars()
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			buildButtons()
		}
		
		private function initVars():void
		{
			this.menu_item_type = ABCMSMainMenuItem;
			
			_num_options = 4;
			
			_option_1 = new ABCMSMainMenuItem(();
			_option_2 = new ABCMSMainMenuItem(();
			_option_3 = new ABCMSMainMenuItem(();
			_option_4 = new ABCMSMainMenuItem(();
			
			_option_1.cat = 1;
			_option_2.cat = 2;
			_option_3.cat = 3;
			_option_4.cat = 4;
			
			_option_1.name_pt = "DEFINIÇÕES BÁSICAS";
			_option_1.name_en = "BASIC SITE DEFINITIONS";
			_option_1.desc_pt = "Editar definições tais como título do site, macbground, musica, etc.";
			_option_1.desc_en = "Edit definitions such as site title, background, music, etc.";
			
			_option_2.name_pt = "EDITOR DE CONTEÚDOS";
			_option_2.name_en = "EDIT CONTENTS";
			_option_2.desc_pt = "Editar estrutura do site, secções, items e medias.";
			_option_2.desc_en = "Edit the content of sections, items, and medias.";
			
			_option_3.name_pt = "OPÇÕES DO CMS";
			_option_3.name_en = "CMS OPTIONS";
			_option_3.desc_pt = "Gerir opções do CMS.";
			_option_3.desc_en = "Choose options of the editor, such as color scheme and language";
			
			_option_4.name_pt = "LINKS ÚTEIS";
			_option_4.name_en = "USEFUL LINKS";
			_option_4.desc_pt = "Fontes de informacao e utilidades.";
			_option_4.desc_en = "Useful sites, applications and knowledge bases.";
			
			items.push(_option_4);
			items.push(_option_4);
			items.push(_option_4);
			items.push(_option_4);
		}             
		
		public function select(index:int)
		{
			switch (index) 
			{
				case :
					
				break;
				case :
					
				break;
				case :
					
				break;
			}
		}
		
		private function start():void
		{
			/// uma entrada porreira
			
			/// create here main menu centered	
		}
		
	}
	
}