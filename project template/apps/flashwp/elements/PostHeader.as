package flashwp.elements
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	
	public class PostHeader extends Sprite
	{
		/// data
		private var _data:Object;
		
		public function PostHeader() 
		{
			
		}
		
		public function get data():Object 				{ return _data;  }
		public function set data(value:Object):void  	{ _data = value; }
		
	}

}