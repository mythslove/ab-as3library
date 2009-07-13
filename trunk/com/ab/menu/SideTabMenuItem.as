package com.ab.menu 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SideTabMenuItem extends Sprite
	{
		private var _index:int;
		private var _title:int;
		private var _lead:int;
		
		public function SideTabMenuItem() 
		{
			initVars();
			
			setListeners();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function initVars():void
		{
			this.mouseChildren = false;
		}
		
		private function setListeners():void 				{ this.addEventListener(MouseEvent.CLICK, clickHandler) }
		
		private function clickHandler(e:MouseEvent):void  	{ click(); }
		
		private function click():void
		{
			
		}
		
	}
	
}