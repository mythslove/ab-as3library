package com.ab.apps.appgenerics.objects
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.display.Image;
	import com.ab.events.CentralEventSystem;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import com.ab.utils.Make;
	import com.edigma.web.EdigmaCore;
	
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	/// app generics
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.apps.appgenerics.events.AppEvent;
	
	//public class ApplicationItem extends MovieClip
	public class ApplicationItem extends CasaSprite
	{
		//private var _data:Array;
		private var _closed:Boolean=false;
		
		public function ApplicationItem() 
		{
			//trace ("ApplicationItem()"); 
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.OPEN_ITEM, this.openItemHandler, false, 0, true);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		public function start():void
		{
			/// override this function
		}
		
		public function openItemHandler(e:ItemEvent):void  
		{ 
			//trace("CLOSING ITEM");
			
			close(); 
			
			_closed = true;
			
		}
		
		public function close():void 
		{
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } ); 
		}
		
		public function endClose():void 			
		{
			CentralEventSystem.singleton.removeEventListener(ItemEvent.OPEN_ITEM, this.openItemHandler);
			
			destroy();
		}
		
		public function get closed():Boolean 			{ return _closed; }
		public function set closed(value:Boolean):void  { _closed = value; }
		
		//public function get data():Array 				{ return _data;  };
		//public function set data(value:Array):void  	{ _data = value; };
		
	}
	
}