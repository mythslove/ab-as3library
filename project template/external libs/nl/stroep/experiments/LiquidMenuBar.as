package nl.stroep.experiments 
{
	import flash.display.Sprite;
	
	/**
	 * Menubar with fixed width
	 * @author Mark Knol - Stroep.nl - 2009 (c)
	 */
	public class LiquidMenuBar extends Sprite
	{
		public var menuItems:Array = [];
		public var menuList:Array = [];
		private var current_mode:String;
		private var _width:Number;
		
		public function LiquidMenuBar( menuList:Array, mode:String, _width:Number = 800 ) 
		{
			this.menuList = menuList;
			this.current_mode = mode;
			
			for (var i:int = 0; i < menuList.length; ++i) 
			{				
				var menuitem:MenuItem = new MenuItem( menuList[i], 0 );				
				this.addChild(menuitem);
				menuItems.push(menuitem);
			}
			
			this._width = _width; 
			
			updateWidth(_width);
		}
		
		private function updateWidth( _width:Number ):void
		{			
			var xPos:Number = 0;
			
			for (var i:int = 0; i < menuItems.length; ++i) 
			{
				var menuitem:MenuItem = menuItems[i] as MenuItem;
			
				var itemWidth:Number = LiquidMenuUtil.getItemWidth(menuList, i, _width, this.current_mode);
				
				menuitem.backgroundWidth = itemWidth;
				
				menuitem.x = xPos;
				
				xPos += itemWidth + 1;
			}
		}
		
		override public function get width():Number { return this._width; }
		
		override public function set width(value:Number):void 
		{
			// super.width = value;			
			updateWidth (value);
		}
	}
	
}