package  
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABMovieClip
	import com.ab.ui.ABTreeMenu2Level
	
	public class SectionsTree extends ABMovieClip
	{
		private var _MENU:ABTreeMenu2Level
		private var _data:Object
		
		public function SectionsTree() 
		{
			getData()
		}
		
		private function getData():void
		{
			_data
		}
		
		private function buildMenu()
		{
			_MENU = new ABTreeMenu2Level("_MENU_ITEM_id", "_MENU_SUB_ITEM_id")
			
			_MENU.data = _data
			
			_MENU.build()
		}
		
	}
	
}