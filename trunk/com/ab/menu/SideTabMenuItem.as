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
		private var _menu:SideTabMenu;
		
		public function SideTabMenuItem()
		{
			initVars();
			
			setListeners();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			this.addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
			
			build();
		}
		
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, onClick);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		protected function onClick(e:MouseEvent):void
		{
			/// nothing, please extend
		}
		
		protected function build():void
		{
			trace("SideTabMenuItem ::: build")
			
			/// nothing, please extend
		}
		
		protected function update():void
		{
			/// nothing, please extend
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