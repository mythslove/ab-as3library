package com.ab.apps.wpflashblog 
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	
	public class PostFooter extends Sprite
	{
		/// data
		private var _data:Object;
		
		public function PostFooter() 
		{
			
		}
		
		public function get data():Object 				{ return _data;  }
		public function set data(value:Object):void  	{ _data = value; }
		
	}

}