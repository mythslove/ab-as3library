package com.ab.apps.appgenerics.objects 
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.apps.appgenerics.objects.ApplicationItem
	import com.asual.swfaddress.SWFAddress;
	import flash.events.Event;
	import org.casalib.util.StageReference;
	
	public class WebsiteSection extends ApplicationItem
	{
		private var _swfaddress_path:String;
		private var _swfaddress_value:String;
		
		private var _cat:int;
		private var _hrq:String;
		
		/// sys
		public var started:Boolean=false;
		//private var _data:String;
		
		public function WebsiteSection() 
		{
			
		}
		
		override public function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			StageReference.getStage().addEventListener(Event.RESIZE, resizeHandler, false, 0, true);
			
			_swfaddress_path = SWFAddress.getPath();
			
			start();
		}
		
		public function resizeHandler(e:Event):void 
		{
			/// override
		}
		
		override public function openItemHandler(e:ItemEvent):void
		{
			//trace( "com.ab.apps.appgenerics.objects.WebsiteSection.closeItemHandler > e : " + e.data );
			
			if (e.data == "open_website_section") 
			{
				trace("closing section: " + _swfaddress_path);
				
				cleanResizeHandler();
				
				close(); 
			}
		}
		
		public function cleanResizeHandler():void
		{
			StageReference.getStage().removeEventListener(Event.RESIZE, resizeHandler);
		}
		
		public function get swfaddress_path():String 			{ return _swfaddress_path; }
		public function set swfaddress_path(value:String):void  { _swfaddress_path = value; }
		
		public function get cat():int 							{ return _cat;  }
		public function set cat(value:int):void  				{ _cat = value; }
		
		public function get hrq():String 						{ return _hrq; }
		public function set hrq(value:String):void  			{ _hrq = value; }
		
		public function get swfaddress_value():String 			{ return _swfaddress_value; }
		public function set swfaddress_value(value:String):void { _swfaddress_value = value; }
		
	}
}