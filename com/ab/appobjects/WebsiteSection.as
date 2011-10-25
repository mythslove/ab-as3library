package com.ab.appobjects
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.core.COREApi;
	import com.ab.display.SmartStageSprite;
	import com.ab.events.AppEvent;
	import com.ab.events.ItemEvent;
	import com.ab.appobjects.ApplicationItem
	import com.asual.swfaddress.SWFAddress;
	import com.asual.swfaddress.SWFAddressEvent;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import org.casalib.util.StageReference;
	
	public class WebsiteSection extends SmartStageSprite
	{
		private var _swfaddress_path:String;
		//private var _swfaddress_value:String;
		
		private var _cat:int;
		private var _hrq:String;
		
		private var _data:Array;
		
		public 	var close_delay:Number=1.5;
		public var aux_var:Number;
		
		public function WebsiteSection() 
		{
			//COREApi.addEventListener(ItemEvent.OPEN_ITEM,  		this.openItemHandler, false, 0, true);
			//COREApi.addEventListener(ItemEvent.CLOSE_ITEM, 		this.closeItemHandler, false, 0, true);
			
			COREApi.addEventListener(AppEvent.SECTION_LEAVING, 		this.sectionLeavingHandler, false, 0, true);
			
			SWFAddress.addEventListener(SWFAddressEvent.CHANGE, swfaddressChangeHandler, false, 0, true);
		}
		
		public function sectionLeavingHandler():void 
		{
			
		}
		
		public function swfaddressChangeHandler(e:SWFAddressEvent):void 
		{
			if (closed == false) 
			{
				//trace("WebsiteSection.swfaddressChangeHandler ::: new path: " + SWFAddress.getPath() );
				//
				//trace("SWFAddress.getPathNames[0] : " + SWFAddress.getPathNames()[0]);
				
				if (SWFAddress.getPathNames()[0] != swfaddress_path) 
				{
					trace("SWFAddress changed and base CHANGED - section leaving.");
					
					SWFAddress.removeEventListener(SWFAddressEvent.CHANGE, 	swfaddressChangeHandler);
					
					close("delayed");
					
					onStartClose();
				}
				else
				{
					trace("SWFAddress changed but base remains, section NOT leaving.");
				}
			}
		}
		
		public function onStartClose():void 
		{
			/// normally this function should be overridden
		}
		
		//public function closeItemHandler(e:ItemEvent):void
		//{
			/// normally this function should be overridden
			//
			//if (e.data == "close_application_items") 
			//{
				//close();
			//}
		//}
		
		override public function onStage():void 
		{
			//_swfaddress_path = SWFAddress.getPath();
			
			//onStage();
		}
		
		//public function openItemHandler(e:ItemEvent):void
		//{
			//trace( "com.ab.appobjects.WebsiteSection.closeItemHandler > e : " + e.data );
			//
			// this function can be overridden sometimes
			//
			//if (e.data == "open_website_section") 
			//{
				//trace("closing section: " + _swfaddress_path);
				//
				//close(); 
			//}
		//}
		
		public function close(type:String="fadeout", delay_time:Number=1):void 
		{
			trace("CLOSING SECTION '" + _swfaddress_path + "'");
			
			closed = true;
			
			onClose();
			
			switch (type) 
			{
				case "fadeout":
					Tweener.addTween(this, { alpha:0, time:delay_time, onComplete:endClose } ); 
				break;
				case "delayed":
					//aux_var = 0;
					setTimeout(endClose, delay_time * 1000);
					//Tweener.addTween(this, { alpha:1, time:delay_time, delay:close_delay, onComplete:endClose } ); 
				break;
				case "immediate":
					endClose();
				break;
			}
		}
		
		private function endClose():void 
		{
			//COREApi.removeEventListener(ItemEvent.OPEN_ITEM,  		this.openItemHandler);
			//COREApi.removeEventListener(ItemEvent.CLOSE_ITEM, 		this.closeItemHandler);
			
			destroy();
		}
		
		public function onClose():void 
		{
			/// to override
		}
		
		//public function get closed():Boolean 					{ return _closed; }
		//public function set closed(value:Boolean):void  		{ _closed = value; }
		
		public function get data():Array 						{ return _data;  };
		public function set data(value:Array):void  			{ _data = value; };
		
		public function get swfaddress_path():String 			{ return _swfaddress_path; }
		public function set swfaddress_path(value:String):void  { _swfaddress_path = value; }
		
		//public function get swfaddress_value():String 			{ return _swfaddress_value; }
		//public function set swfaddress_value(value:String):void { _swfaddress_value = value; }
		
		public function get cat():int 							{ return _cat;  }
		public function set cat(value:int):void  				{ _cat = value; }
		
		public function get hrq():String 						{ return _hrq; }
		public function set hrq(value:String):void  			{ _hrq = value; }
		
	}
}