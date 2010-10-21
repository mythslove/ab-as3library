package com.ab.apps.wpflashblog 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	
	public class Post extends ABSprite
	{
		/// data
		private var _data:Object;
		
		/// visual
		private var _header:PostHeader;
		private var _footer:PostFooter;
		
		/// sys
		private var _mode:String; 			/// "list" | "open" ///
		
		public function Post()
		{
			
		}
		
		override public function start():void
		{
			switch (mode) 
			{
				case "list":
					buildListCase();
				break;
				
				case "open":
					buildOpenCase();
				break;
			}
		}
		
		private function buildListCase():void
		{
			
		}
		
		private function buildOpenCase():void
		{
			
		}
		
		public function get data():Object 				{ return _data;  }
		public function set data(value:Object):void  	{ _data = value; }
		
		public function get mode():String 				{ return _mode; }
		public function set mode(value:String):void  	{ _mode = value; }
		
	}
}