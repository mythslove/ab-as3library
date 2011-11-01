package com.ab.display.special  
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	public class ZoomAndPanObject extends Sprite
	{
		/// settings
		public var strength:Number = 3;
		private var _stagereference:Stage;
		/// sys
		private var _zoomed:Boolean=false;
		private var open_width:Number;
		private var open_height:Number;
		private var init_width:Number;
		private var init_height:Number;
		private var init_x:Number;
		private var init_y:Number;
		private var _systembusy:Boolean=false;
		
		public function ZoomAndPanObject() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		/// setting the stage reference is required to run
		public function set stagereference(value:Stage):void   {  _stagereference = value; };
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			init_width  = this.width;
			init_height = this.height;
			init_x 		= this.x;
			init_y 		= this.y;
			
			this.addEventListener(MouseEvent.CLICK, zoomClick, false, 0, true);
		}
		
		private function zoomClick(e:MouseEvent):void 
		{
			if (_stagereference != null && _systembusy == false) 
			{
				if (_zoomed == true)
				{
					_zoomed 					= false;
					_systembusy 				= true;
					
					this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
					
					Tweener.addTween(this, { width:init_width, height:init_height, x:init_x, y:init_y, time:1, transition:"easeOutExpo", onComplete:reactivate } );
				}
				else
				{
					_zoomed 					= true;
					_systembusy 				= true;
					
					open_width  				= _stagereference.stageWidth  * strength;
					
					open_height 				= _stagereference.stageHeight * strength;
					
					init_x 						= this.x;
					init_y 						= this.y;
					
					var mouse_x_percent:Number 	= (_stagereference.mouseX * 100) / _stagereference.stageWidth;
					var mouse_y_percent:Number 	= (_stagereference.mouseY * 100) / _stagereference.stageHeight;
					
					var width_diff   			= init_width  - open_width;
					var height_diff  			= init_height - open_height;
					
					var x_pos 					= (mouse_x_percent * width_diff)  / 100;
					var y_pos 					= (mouse_y_percent * height_diff) / 100;
					
					Tweener.addTween(this, { width:open_width, height:open_height, x:x_pos, y:y_pos, time:1, transition:"easeOutExpo", onComplete:reactivate } );
					
					this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
				}
				
			}
			
		}
		
		private function reactivate():void 		{ _systembusy = false; };
		
		private function enterFrameHandler(e:Event):void
		{	
			if (_stagereference != null) 
			{
				var mouse_x_percent:Number 		= (_stagereference.mouseX * 100) / _stagereference.stageWidth;
				var mouse_y_percent:Number 		= (_stagereference.mouseY * 100) / _stagereference.stageHeight;
				
				var width_diff   				= _stagereference.stageWidth  - open_width;
				var height_diff  				= _stagereference.stageHeight - open_height;
				
				var x_pos 						= (mouse_x_percent * width_diff)  / 100;
				var y_pos 						= (mouse_y_percent * height_diff) / 100;
				
				Tweener.addTween(this, 			{x:x_pos, y:y_pos, time:1, transition:"easeOutExpo" } );
			}
		}
		
	}
	
}