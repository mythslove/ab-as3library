package com.ab.apps.appgenerics.objects
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.events.CentralEventSystem;
	import flash.display.Sprite;
	
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	/// ab
	import com.ab.display.ABSprite;
	
	/// ab - app generics
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.apps.appgenerics.events.AppEvent;
	
	public class ApplicationItem extends ABSprite
	{
		private var _data:Array;
		private var _closed:Boolean=false;
		
		public function ApplicationItem() 
		{
			trace ("ApplicationItem()"); 
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.OPEN_ITEM,  this.openItemHandler, false, 0, true);
			CentralEventSystem.singleton.addEventListener(ItemEvent.CLOSE_ITEM, this.closeItemHandler, false, 0, true);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		public function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		public function closeItemHandler(e:ItemEvent):void
		{
			if (e.data == "close_application_items") 
			{
				close(); 
				
				_closed = true;
			}
		}
		
		public function start():void
		{
			/// override this function
		}
		
		public function openItemHandler(e:ItemEvent):void
		{ 
			
		}
		
		public function close():void 
		{
			_closed = true;
			
			CentralEventSystem.singleton.removeEventListener(ItemEvent.OPEN_ITEM,  this.openItemHandler);
			CentralEventSystem.singleton.removeEventListener(ItemEvent.CLOSE_ITEM, this.closeItemHandler);
			
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } ); 
		}
		
		public function endClose():void
		{
			destroy();
		}
		
		public function get closed():Boolean 			{ return _closed; }
		public function set closed(value:Boolean):void  { _closed = value; }
		
		public function get data():Array 				{ return _data;  };
		public function set data(value:Array):void  	{ _data = value; };
		
	}
	
}