package com.ab.appobjects.preloaders.minimalbar 
{
	/**
	 * ...
	 * @author Antonio Brandao
	 */
	
	import caurina.transitions.Tweener;
	import com.ab.core.COREUtils;
	import com.ab.display.geometry.PolygonQuad;
	import com.ab.display.SmartStageMovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	
	public class MinimalBarPreloader extends SmartStageMovieClip
	{
		private var bg:PolygonQuad;
		private var bar:PolygonQuad;
		private var bar2:PolygonQuad;
		private var bar_holder:Sprite;
		
		private var _bg_size:Rectangle;
		private var _bar_size:Rectangle;
		private var _bg_colour:uint;
		private var _bar_colour:uint;
		private var _type:String;
		private var bar_init_x:Number;
		private var bar_init_y:Number;
		private var bar_final_width:Number=0;
		
		public function MinimalBarPreloader(bg_size:Rectangle, bg_colour:uint, bar_size:Rectangle, bar_colour:uint, type:String="fill_from_left") 
		{
			_type 			= type;
			_bar_colour 	= bar_colour;
			_bg_colour 		= bg_colour;
			_bar_size 		= bar_size;
			_bg_size 		= bg_size;
			
			bg 				= new PolygonQuad(_bg_size.width, _bg_size.height, _bg_colour);
			bar 			= new PolygonQuad(1, _bar_size.height, _bar_colour);
			bar2 			= new PolygonQuad(1, _bar_size.height, _bar_colour);
			bar_holder 		= new Sprite();
			
			bg.alpha 		= 0;
			
			switch (type) 
			{
				case "fill_from_left":
					
					bar_final_width = 1;
					bar.width 		= 1;
					bar2.width 		= 1;
					bar.x 			= 0;
					bar2.x 			= 0;
					bar_init_x 		= (_bg_size.width / 2) - (_bar_size.width / 2);
					
					
				break;
				case "fill_from_center":
					
					bar_final_width = 2;
					bar.width 		= 2;
					bar2.width 		= 2;
					bar.x 			= -1;
					bar2.x 			= -1;
					bar_init_x 		= _bg_size.width / 2;
					
				break;
			}
			
			bar_init_y 		= (_bg_size.height / 2) - (_bar_size.height / 2);
			
			bar_holder.x  	= bar_init_x;
			bar_holder.y  	= bar_init_y;
			
			bar.filters 	= [new BlurFilter(5, 5, 3)]
			
			bar.alpha   	= 0.8;
			
			this.addChild(bg);
			this.addChild(bar_holder);
			
			bar_holder.addChild(bar);
			bar_holder.addChild(bar2);
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		private function removedHandler(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			bar_holder.width += (bar_final_width - bar_holder.width) / 8;
		}
		
		public function setPercentage(new_percentage:Number):void
		{
			trace("MinimalBarPreloader.setPercentage > new_percentage : " + new_percentage);
			
			if (new_percentage > 0.01 && new_percentage < 100.01) 
			{
				var new_width:Number = (new_percentage * _bar_size.width) / 100;
				
				//COREUtils.resizeObjectWidth(bar_holder, new_width, 0.8);
				
				bar_final_width = new_width;
				
				if (new_width  == _bar_size.width) 
				{
					//if (this.hasEventListener(Event.ENTER_FRAME)) 
					//{
						this.removeEventListener(Event.ENTER_FRAME, removedHandler);
					//}
				}
			}
		}
		
		public function setPercentageFast(new_percentage:Number):void
		{
			//trace("MinimalBarPreloader.setPercentageFast > new_percentage : " + new_percentage);
			//var new_width:Number = (new_percentage * _bar_size.width) / 100;
			
			//bar_holder.width = new_width;
		}
		
		public function vanishBar(time:Number=0.5):void
		{
			trace("MinimalBarPreloader.vanishBar > time : " + time);
			COREUtils.setAlpha(bar_holder, 0, time);
		}
		
		public function shrinkBar(time:Number=0.5, transition:String="EaseOutExpo"):void
		{
			//trace("MinimalBarPreloader.shrinkBar > time : " + time + ", transition : " + transition);
			
			//if (this.hasEventListener(Event.ENTER_FRAME)) 
			//{
				//this.removeEventListener(Event.ENTER_FRAME, removedHandler);
			//}
			
			//COREUtils.resizeObjectWidth(bar_holder, 0, time, transition);
		}
		
		public function vanish(time:Number=0.5):void
		{
			trace("MinimalBarPreloader.vanish > time : " + time);
			COREUtils.setAlpha(this, 0, time, "EaseOutSine", 0.5);
		}
		
	}

}