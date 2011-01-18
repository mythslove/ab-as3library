package com.ab.paging 
{
	/**
	* @author AB
	*/
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.display.geometry.Circle;
	import com.ab.events.CentralEventSystem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CirclesPagingItem extends Sprite
	{
		private var _page:int;
		private var _diameter:int	= 10;
		private var _selected_colour:uint 	= 0xffffff;
		private var _unselected_colour:uint = 0x666666;
		private var _select_function:Function;
		private var _selected:Boolean=false;
		private var circle_selected:Circle;
		private var circle_unselected:Circle;
		private var _host:CirclesPaging;
		
		public function CirclesPagingItem() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		private function addedHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			this.addEventListener(MouseEvent.CLICK, itemClickHandler, false, 0, true);
			
			this.buttonMode = true;
			
			build();
		}
		
		private function itemClickHandler(e:MouseEvent):void 
		{
			_select_function(page);
			
			selected = true;
			
			host.selected_page = page;
		}
		
		private function build():void 
		{
			circle_selected 	= new Circle(_diameter / 2, _selected_colour, 1);
			circle_unselected 	= new Circle(_diameter / 2, _unselected_colour, 1);
			
			this.addChildAt(circle_unselected, 	0);
			this.addChildAt(circle_selected, 	1);
			
			if (_selected == false)
			{
				circle_unselected.alpha = 1;
				circle_selected.alpha 	= 0;
			}
		}
		
		public function get page():int 				{ return _page; }
		public function set page(value:int):void 
		{
			_page = value;
		}
		
		public function get diameter():int 				{ return _diameter; }
		public function set diameter(value:int):void 
		{
			_diameter = value;
		}
		
		public function get select_function():Function 	{ return _select_function; }
		public function set select_function(value:Function):void 
		{
			_select_function = value;
		}
		
		public function get host():CirclesPaging { return _host; }
		public function set host(value:CirclesPaging):void 
		{
			_host = value;
		}
		
		public function get selected():Boolean 			{ return _selected; }
		public function set selected(value:Boolean):void 
		{
			_selected = value;
			
			if (circle_unselected) 
			{
				switch (value) 
				{
					case true:
						circle_unselected.alpha = 0;
						circle_selected.alpha 	= 1;
					break;
					case false:
						circle_unselected.alpha = 1;
						circle_selected.alpha 	= 0;
					break;
				}
			}
		}
		
	}

}