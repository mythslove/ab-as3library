package com.ab.display 
{
	/**
	* @author ABº
	* 
	* INCOMPLETE
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.display.ABSprite;
	import com.ab.utils.Get;
	import com.ab.utils.Kill;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.ab.display.GradientBox;
	import com.ab.display.PatternFill;
	import com.ab.display.DynamicWindowComponent;
	import org.casalib.util.StageReference;
	
	public class DynamicWindowComponent extends ABSprite
	{
		//private var _align_mode:String="center";
		private var _bg:Sprite;
		private var _content_holder:Sprite;
		private var _bg_expanded:Boolean = true;
		/// public
		public var parent_dynamicWindow:DynamicWindow;
		public var CONTENT_align_type:String = "center";
		public var BG_align_type:String      = "center";
		public var BG_distance:String        = "center";
		public var BG_expanded:Boolean 		 = true;
		private var _bg_colour:uint 		 = 0x222222;
		private var _bg_gradient_data:Array;
		private var _bg_pattern_data:Array;
		private var _elements_added_counter:int = 0;
		
		/// align types
		/// center
		/// center_fit
		/// bottom
		/// bottom_bg_expanded
		/// top
		/// top_bg_expanded
		/// left
		/// left_bg_expanded
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
			
			_bg		 		  = new Sprite();
			_content_holder	  = new Sprite();
		}
		
		private function addedHandler(e:Event):void 
		{
			parent_dynamicWindow = DynamicWindow(this.parent.parent);
			
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			_bg.addEventListener(Event.ADDED_TO_STAGE, bgAddedHandler, false, 0, true);
			_content_holder.addEventListener(Event.ADDED_TO_STAGE, contentHolderAddedHandler, false, 0, true);
			
			this.addChild(_bg)
			this.addChild(_content_holder)
		}
		
		private function bgAddedHandler(e:Event):void 
		{
			_bg.removeEventListener(Event.ADDED_TO_STAGE, bgAddedHandler);
			
			_elements_added_counter++;
			
			readyCheck()
		}
		
		private function contentHolderAddedHandler(e:Event):void 
		{
			_content_holder.removeEventListener(Event.ADDED_TO_STAGE, contentHolderAddedHandler);
			
			_elements_added_counter++;
			
			readyCheck()
		}
		
		private function readyCheck():void
		{
			if (_elements_added_counter == 2) 
			{
				GoVisible();
				
				buildDynamicWindowComponent();
			}
		}
		
		public function buildBG(__width:Number, __height:Number, _type:String="solid", _transparency:Number=1):void
		{
			switch (_type) 
			{
				case "solid":
					_bg.graphics.clear();
					_bg.graphics.beginFill(_bg_colour);
					_bg.graphics.drawRect(0, 0, __width, __height);
					_bg.graphics.endFill();
					_bg.alpha_bg.alpha = _transparency;
				break;
				
				case "pattern":
					//PatternFill.create(bg, __width, __height, bg_pattern_data, 0x000000);
					
					var asdasd:Array = new Array() 
					asdasd = Get.AllChildren(_bg);
					
					for (var i:int = 0; i < asdasd.length; i++) 
					{
						_bg.removeChild(asdasd[i]);
						asdasd[i] = null;
					}
					
					asdasd = null;
					
					_bg.addChild(new PatternFill(__width, __height, _bg_pattern_data, 0x000000));
				break;
				
				case "gradient":
					var newgradientbox = new GradientBox(_bg_gradient_data[0], _bg_gradient_data[1], __width, __height);
					//newgradientbox.x = _frame_size;
					//newgradientbox.y = _frame_size;
					_bg.addChild(newgradientbox)
				break;
			}
		}
		
		public function get bg_colour():uint 			{ return _bg_colour;  }
		public function set bg_colour(value:uint):void  { _bg_colour = value; }
		
		public function get bg_pattern_data():Array 	{ return _bg_pattern_data; }
		public function set bg_pattern_data(value:Array):void  { _bg_pattern_data = value; }
		
		public function buildDynamicWindowComponent():void
		{
			/// please extend & override
		}
		
	}
	
}