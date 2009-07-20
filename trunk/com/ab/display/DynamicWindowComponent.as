package com.ab.display 
{
	/**
	* @author ABº
	* 
	* INCOMPLETE
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.display.ABSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.ab.display.GradientBox;
	import com.ab.display.PatternFill;
	import com.ab.display.DynamicWindowComponent;
	import org.casalib.util.StageReference;
	
	public class DynamicWindowComponent extends ABSprite
	{
		//private var _align_mode:String="center";
		public var bg:Sprite;
		public var content_holder:Sprite;
		private var _bg_expanded:Boolean = true;
		/// public
		public var CONTENT_align_type:String = "center";
		public var BG_align_type:String      = "center";
		public var BG_distance:String        = "center";
		public var BG_expanded:Boolean 		 = true;
		private var _bg_colour:uint 		 = 0x000000;
		private var _bg_gradient_data:Array;
		private var _bg_pattern_data:Array;
		
		/// align types
		/// 
		/// center
		/// center_fit
		/// 
		/// bottom
		/// bottom_bg_expanded
		/// 
		/// top
		/// top_bg_expanded
		/// 
		/// left
		/// left_bg_expanded
		/// 
		/// right
		/// right_bg_expanded
		
		public function DynamicWindowComponent() 
		{
			initVars();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function initVars():void
		{
			this.alpha = 0;
			
			_bg_gradient_data = new Array();
			_bg_gradient_data = [0x0000000, 0xffffff];
			
			_bg_pattern_data = new Array();
			_bg_pattern_data = ["  ", " *"];
			
			bg		 		  = new Sprite();
			content_holder	  = new Sprite();
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			content_holder.addEventListener(Event.ADDED_TO_STAGE, contentHolderAddedHandler, false, 0, true);
			
			this.addChild(bg)
			this.addChild(content_holder)
		}
		
		private function contentHolderAddedHandler(e:Event):void 
		{
			content_holder.removeEventListener(Event.ADDED_TO_STAGE, contentHolderAddedHandler);
			
			Tweener.addTween(this, { alpha:1, time:1} );
			
			build();
		}
		
		public function buildBG(__width:Number, __height:Number, _type:String="solid", _transparency:Number=1):void
		{
			switch (_type) 
			{
				case "solid":
					/// not done yet
					bg.graphics.beginFill(_bg_colour);
					bg.graphics.drawRect(0, 0, __width, __height);
					bg.graphics.endFill();
					bg.alpha = _transparency;
				break;
				
				case "pattern":
					//PatternFill.create(bg, __width, __height, bg_pattern_data, 0x000000);
					
					bg.addChild(new PatternFill(__width, __height, _bg_pattern_data, 0x000000));
				break;
				
				case "gradient":
					var newgradientbox = new GradientBox(_bg_gradient_data[0], _bg_gradient_data[1], __width, __height);
					//newgradientbox.x = _frame_size;
					//newgradientbox.y = _frame_size;
					bg.addChild(newgradientbox)
				break;
			}
		}
		
		public function get bg_colour():uint 			{ return _bg_colour;  }
		public function set bg_colour(value:uint):void  { _bg_colour = value; }
		
		public function build():void
		{
			/// please extend
		}
		
	}
	
}