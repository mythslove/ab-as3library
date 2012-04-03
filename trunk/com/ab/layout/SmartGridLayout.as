package com.ab.layout 
{
	/**
	* @author Antonio Brandao
	*/
	
	import com.ab.core.COREApi;
	import com.ab.core.COREUtils;
	import com.ab.display.geometry.PolygonQuad;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	public class SmartGridLayout extends Object
	{
		
		private var transition_type:String = "slide_to_sides";	/// transition types: none, slide_to_bottom, slide_to_sides
		private var start_type:String = "come_from_bottom";		/// start types: start_placed, come_from_right, come_from_left, come_from_bottom
		
		private var types:Array = new Array();
		private var columns:int;
		private var rows:int;
		private var column_width:Number;
		private var num_columns:int;
		private var max_rows:int;
		private var row_height:Number;
		
		private var _available_width:Number;
		
		/// visual
		private var paginator:CirclesPagination;
		
		private var children:Array;
		private var children_holder:DisplayObjectContainer;;
		private var started:Boolean=false;
		private var current_page:int=99999;
		private var items_per_page:int;
		private var first_page_loaded:Boolean=false;
		
		public function SmartGridLayout(_children_holder:DisplayObjectContainer, _children:Array, _column_width:Number, _row_height:Number, _num_columns:int=4, _max_rows:int=4)
		{
			children 		= _children;
			children_holder = _children_holder;
			
			max_rows 		= _max_rows;
			num_columns 	= _num_columns;
			items_per_page  = max_rows * num_columns;
			column_width 	= _column_width;
			row_height		= _row_height;
		}
		
		public function start(delay:Number=0):void
		{
			trace("SmartGridLayout.start");
			//if (delay == 0) 
			//{
				goStart();
			//}
			//else
			//{
				//setTimeout(goStart, delay);
			//}
		}
		
		private function goStart():void 
		{
			trace("com.ab.layout.SmartGridLayout.goStart");
			if (!started) 
			{
				started = true;
				
				var current_column:int = 0;
				var current_row:int = 0;
				var item_count:int = 0;
				
				for (var i:int = 0; i < children.length; i++) 
				{
					if (item_count < items_per_page) 
					{
						if (current_column == num_columns) 
						{
							current_column = 0;
							
							current_row++;
						}
						
						switch (start_type) 
						{
							case "come_from_bottom":
								children[i].y = Math.round(COREApi.stage.stageHeight);
								children[i].x = Math.round(current_column * column_width);
							break;
							case "come_from_right":
								children[i].y = Math.round(current_row * row_height);
								children[i].x = Math.round(COREApi.stage.stageWidth);
							break;
							case "come_from_left":
								children[i].y = Math.round(current_row * row_height);
								children[i].x = Math.round(0 - DisplayObject(children[i]).width);
							break;
						}
						
						current_column++;
						
						children_holder.addChild(children[i]);
					}
					
					item_count++;
				}
				
				callPage(0);
			}
		}
		
		public function callPage(num:int):void
		{
			trace("SmartGridLayout.callPage > num : " + num);
			//trace("callPage > num : " + num);
			
			if (num != current_page) 
			{
				current_page = num;
				
				var item_count:int = 0;
				
				for (var i:int = num; i < children.length; i++) 
				{
					
					//trace("item_count : " + item_count);
					
					if (item_count <= items_per_page) 
					{
						//trace("SENDING ONE");
						COREUtils.moveObjectXY(children[i], getXAtIndex(i), getYAtIndex(i), 0.5, "easeOutExpo", item_count*0.1);
					}
					
					item_count++;
				}
			}
		}
		
		private function getYAtIndex(i:int):Number
		{
			var new_y:Number;
			var row:Number;
			var base_index:int;
			
			base_index = i - (current_page * items_per_page);
			
			row = Math.floor(base_index / num_columns);
			
			new_y = row * row_height;
			
			return Math.round(new_y);
		}
		
		private function getXAtIndex(i:int):Number 
		{
			var new_x:Number;
			var aux:Number;
			var base_index:int;
			
			base_index = i - (current_page * items_per_page);
			
			base_index = base_index - (Math.floor(base_index / num_columns) * num_columns);
			
			new_x = base_index * column_width;
			
			return Math.round(new_x);
		}
		
		public function get available_width():Number { return _available_width; }
		public function set available_width(value:Number):void 
		{
			_available_width = value;
		}
		
	}

}