package wpflashblog.elements
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import com.ab.services.FlashPressBridge;
	
	public class Posts extends ABSprite
	{
		private var _posts:Array;
		
		public function Posts() 
		{
			
		}
		
		override public function start():void
		{
			/// create posts list
			/// - send AMF request
			/// - create posts
			
			FlashPressBridge.singleton.getPosts(getposthandler, 50);
		}
		
		private function getposthandler(result:Object):void
		{
			for (var prop:* in result) 
			{
				trace("myObject." + prop + " = " + result[prop]);
			}
			
			trace(result, result as Array);
		}
		
	}
}