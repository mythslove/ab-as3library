package com.ab.apps.wpflashblog 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	
	public class Posts extends ABSprite
	{
		private var _posts:Array;
		
		public function Posts() 
		{
			
		}
		
		override public function start()
		{
			/// create posts list
			/// - send AMF request
			/// - create posts
			
			FlashPressBridge.singleton.getPosts(getposthandler, 50);
		}
		
		private function getposthandler(result:Object):void
		{
			
		}
		
	}
}