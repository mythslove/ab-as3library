﻿package com.ab.apps.abcms.mainmodules.menu
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import com.ab.menu.SideTabMenu;
	import flash.events.Event;
	import com.ab.apps.abcms.mainmodules.menu.ABCMSMainMenuItem;
	import com.ab.apps.abcms.mainmodules.configurators.ABCMSSiteVars;
	
	public class ABCMSMainMenu extends SideTabMenu
	{
		private var _items:Array;
		private var _num_options:int;
		
		public function ABCMSMainMenu() 
		{
			initVars()
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			init();
			build();
		}
		
		private function build():void
		{
			buildButtons();
		}
		
		private function initVars():void
		{
			_items = new Array();
			
			_num_options = ABCMSSiteVars.MAIN_MENU.length;
			
			button_spacing = 5;
		}
		
		private function init():void
		{
			trace("_num_options = " + _num_options)
			
			for (var i:int = 0; i < _num_options; i++)
			{
				var newitem:ABCMSMainMenuItem = new ABCMSMainMenuItem();
				
				trace("MAIN_MENU[i] = " + ABCMSSiteVars.MAIN_MENU[i])
				
				newitem.data = ABCMSSiteVars.MAIN_MENU[i];
				
				_items.push(newitem);
			}
			
			sidetabmenuitems = _items;
		}	
	}
}