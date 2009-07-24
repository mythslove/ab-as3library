package com.ab.menu 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SideTabMenuItem extends ABSprite
	{
		private var _index:int;
		private var _title:int;
		private var _lead:int;
		
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
			
			this.addEventListener(MouseEvent.CLICK, onClickHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OVER, onHover, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, onHoverOut, false, 0, true);
			this.buttonMode = true;
			this.mouseChildren = false;
			
			build();
		}
		
		protected function onHoverOut(e:MouseEvent):void 
		{
			/// nothing, please extend
		}
		
		protected function onHover(e:MouseEvent):void 
		{
			/// nothing, please extend
		}
		
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, onClickHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function onClickHandler(e:MouseEvent):void 
		{
			onClick();
		}
		
		protected function onClick():void
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
		
		protected function click():void
		{
			
		}
		
	}
	
}