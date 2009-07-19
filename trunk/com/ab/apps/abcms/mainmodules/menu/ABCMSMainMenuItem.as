package com.ab.apps.abcms.mainmodules.menu 
{
	/**
	* @author ABº
	*/
	
	import com.ab.menu.SideTabMenuItem;
	
	public class ABCMSMainMenuItem extends SideTabMenuItem
	{
		private var _cat:int;
		private var _name_pt:String;
		private var _name_en:String;
		private var _desc_pt:String;
		private var _desc_en:String;
		
		public function ABCMSMainMenuItem() 
		{
			
		}
		
		public function get cat():int 					{ return _cat; 		}
		public function set cat(value:int):void  		{ _cat = value; 	}
		
		public function get name_pt():String 			{ return _name_pt; 	}
		public function set name_pt(value:String):void  { _name_pt = value; }
		
		public function get name_en():String 			{ return _name_en; 	}
		public function set name_en(value:String):void  { _name_en = value; }
		
		public function get desc_pt():String 			{ return _desc_pt; 	}
		public function set desc_pt(value:String):void  { _desc_pt = value; }
		
		public function get desc_en():String 			{ return _desc_en; 	}
		public function set desc_en(value:String):void  { _desc_en = value; }
		
	}
	
}