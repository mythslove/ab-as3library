package com.ab.apps.appgenerics.objects
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.display.Image;
	import com.ab.events.CentralEventSystem;
	
	import com.ab.utils.Make;
	import com.edigma.web.EdigmaCore;
	
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	/// app generics
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.apps.appgenerics.events.AppEvent;
	
	/// app specifics
	////
	
	public class ApplicationItem extends CasaSprite
	{
		private var _data:Array;
		private var _closed:Boolean=false;
		
		public function ApplicationItem() 
		{
			//trace ("ApplicationItem()"); 
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.LOADED, this.loadedItemHandler, false, 0, true);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			openContent();
		}
		
		private function openContent():void
		{
			
		}
		
		private function loadedItemHandler(e:ItemEvent):void  
		{ 
			if (e.data[1] != this.data[1])   {  close(); }; //trace("CLOSING ITEM");  }; 
		}
		
		private function close():void 
		{
			_closed = true;
			
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } ); 
		}
		
		private function endClose():void 			
		{ 
			//CentralEventSystem.singleton.removeEventListener(MultimediaSlideshowEvent.MODE_CHANGE, modeChangeHandler);
			CentralEventSystem.singleton.removeEventListener(ItemEvent.LOADED, this.loadedItemHandler);
			
			destroy(); 
		}
		
		public function get data():Array 				{ return _data;  };
		public function set data(value:Array):void  	{ _data = value; };
		
	}
	
}