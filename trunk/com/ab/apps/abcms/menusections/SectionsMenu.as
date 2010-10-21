package abcms.menusections 
{
	/**
	* @author ABº
	*/
	
	import com.ab.display.ABSprite;
	import com.ab.ui.menu.DynamicStackMenu;
	import abcms.menusections.assets.SectionItem;
	import com.bumpslide.ui.BaseClip;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.bumpslide.ui.Component;
	import flash.events.MouseEvent;
	
	public class SectionsMenu extends ABSprite
	{
		private var mymenu:DynamicStackMenu;
		
		public function SectionsMenu() 
		{
			trace("SectionsMenu()");
			
			build();
		}
		
		private function build():void
		{
			trace("SectionsMenu ::: build()");
			
			var _ITEMS_ARRAY:Array = new Array();
			
			for (var i:int = 0; i < 10; i++) 
			{
				var newitem = new SectionItem();
				
				newitem.x = 200;
				
				newitem.addEventListener( MouseEvent.DOUBLE_CLICK, onITEMSelect );
				
				this.addChildAt(newitem, i)
				
				_ITEMS_ARRAY.push(newitem);
			}
			
			mymenu = new DynamicStackMenu(_ITEMS_ARRAY, "EaseOutBounce", 2)
		}
		
		private function onITEMSelect(e:MouseEvent):void 
		{
			e.currentTarget.select()
			trace("asdasd")
		}
		
	}
	
}