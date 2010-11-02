package com.ab.appobjects
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.events.CentralEventSystem;
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.display.Sprite;
	
	import flash.events.Event;
	import org.casalib.display.CasaSprite;
	
	/// ab
	import com.ab.display.ABSprite;
	
	/// ab - app generics
	import com.ab.events.ItemEvent;
	import com.ab.events.AppEvent;
	
	public class ApplicationItem extends ABSprite
	{
		private var _data:Array;
		private var _closed:Boolean = false;
		private var _swfaddress_path:String;
		private var _swfaddress_sensitive:Boolean=false;
		
		public function ApplicationItem() 
		{
			trace ("ApplicationItem()"); 
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.OPEN_ITEM,  this.openItemHandler, false, 0, true);
			CentralEventSystem.singleton.addEventListener(ItemEvent.CLOSE_ITEM, this.closeItemHandler, false, 0, true);
			
			//this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function SWFAddressChangeHandler(e:SWFAddressEvent):void 
		{
			trace("ApplicationItem: SWFAddressChange: new path = " + SWFAddress.getPath());
			
			if (SWFAddress.getPath() != this.swfaddress_path)  
			{ 
				trace(this.name + " closing!");
				
				close(); 
			};
		}
		
		//public function addedHandler(e:Event):void 
		//{
			//this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			//
			//start();
		//}
		
		public function closeItemHandler(e:ItemEvent):void
		{
			/// normally this function should be overridden
			
			if (e.data == "close_application_items")  { close(); };
		}
		
		//public function start():void
		//{
			/// this function should be overridden
			//
			//trace( "ApplicationItem.start" );
		//}
		
		public function openItemHandler(e:ItemEvent):void
		{ 
			/// normally this function should be overridden
		}
		
		public function close():void 
		{
			_closed = true;
			
			if (swfaddress_sensitive == true)  { SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, this.SWFAddressChangeHandler); };
			
			CentralEventSystem.singleton.removeEventListener(ItemEvent.OPEN_ITEM,  this.openItemHandler);
			CentralEventSystem.singleton.removeEventListener(ItemEvent.CLOSE_ITEM, this.closeItemHandler);
			
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } ); 
		}
		
		public function endClose():void { destroy(); }
		
		public function get closed():Boolean 							{ return _closed; }
		public function set closed(value:Boolean):void  				{ _closed = value; }
		
		public function get data():Array 								{ return _data;  };
		public function set data(value:Array):void  					{ _data = value; };
		
		public function get swfaddress_path():String 					{ return _swfaddress_path;  }
		public function set swfaddress_path(value:String):void  		{ _swfaddress_path = value; }
		
		public function get swfaddress_sensitive():Boolean 				{ return _swfaddress_sensitive; }
		public function set swfaddress_sensitive(value:Boolean):void 
		{
			if (value == false && _swfaddress_sensitive == true)
				{ SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, this.SWFAddressChangeHandler); };
			
			if (value == true)
				{ SWFAddress.addEventListener(SWFAddressEvent.CHANGE, this.SWFAddressChangeHandler); };
			
			_swfaddress_sensitive = value;
		}
	}
}