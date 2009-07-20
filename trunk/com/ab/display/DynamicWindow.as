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
	import com.ab.display.PatternFill;
	
	/// implement activate_new_element
	
	/// implement remove_actual_element
	/// implement actual_element_removal_from_stage_listener
	///       - > add the new one 
	///             - > send him to stage
	///                      -> when he's on stage (0,0), resize & reposition window to fit size, centered (?)
	
	public class DynamicWindow extends ABSprite
	{
		private var _frame_size:Number = 0;
		private var _align_mode:String = "center";
		
		private var _bg:Sprite;
		private var _frame:Sprite;
		private var _content_holder:Sprite;
		private var _mask:Sprite;
		
		private var _frame_pattern_data:Array;
		private var _bg_pattern_data:Array;
		private var _bg_gradient_data:Array;
		private var _nested_components:Array;
		
		public function DynamicWindow() 
		{
			initVars();
		}
		
		private function initVars():void
		{
			this.alpha = 0;
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			_nested_components 	= new Array();
			
			_bg_gradient_data 	= new Array();
			_bg_pattern_data 	= new Array();
			_frame_pattern_data = new Array();
			
			_bg_gradient_data 	= [0x000000, 0xFFFFFF];
			_bg_pattern_data 	= ["   ", " * ", "   "];
			_frame_pattern_data	= ["   ", " * ", "   "];
			
			_frame 				= new Sprite();
			_bg 				= new Sprite();
			_content_holder 	= new Sprite();
			_mask 				= new Sprite();
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			Tweener.addTween(this, { alpha:1, time:1} );
			
			this.addChild(_frame);
			this.addChild(_bg);
			this.addChild(_content_holder);
			this.addChild(_mask); 
			
			_content_holder.mask = _mask;
			
			build();
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// 
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// 
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// /// 
		
		public function insertDynamicWindowComponent(component:DynamicWindowComponent):void
		{
			_content_holder.addChild(component)
		}
		
		public function build():void
		{
			/// please override			
			
			
			//this.addChild(_content_holder)
		}
		
		public function buildBG(__width:Number, __height:Number, _type:String="solid"):void
		{
			switch (_type) 
			{
				case "solid":
					/// not done yet
				break;
				
				case "pattern":
					//PatternFill.create(_bg, __width, __height, _bg_pattern_data, 0x000000);
					
					_bg.addChild(new PatternFill(__width, __height, _bg_pattern_data, 0x000000));
				break;
				
				case "gradient":
					var newgradientbox = new GradientBox(_bg_gradient_data[0], _bg_gradient_data[1], __width, __height);
					newgradientbox.x = _frame_size;
					newgradientbox.y = _frame_size;
					_bg.addChild(newgradientbox)
				break;
			}
		}
		
		public function buildFrame(__width:Number, __height:Number, _type:String="solid"):void
		{
			switch (_type) 
			{
				case "solid":
					/// not done yet
				break;
				case "pattern":
					//PatternFill.create(_frame, __width, __height, _frame_pattern_data, 0x000000);
					_frame.addChild(new PatternFill(__width, __height, _frame_pattern_data, 0x000000));
				break;
				case "gradient":
					//GradientBox.createShape(_bg, __width, __height, _frame_pattern_data, 0x000000);
					/*_bg.addChild(new GradientBox(
												_bg_gradient_data[0], 
												_bg_gradient_data[1], 
												__width, __height));*/
				break;
			}
		}
		
		public function addToContent(something:*):void
		{
			_content_holder.addChild(something);
		}
		
		/// VISUAL BEHAVIOUR FUNCTIONS
		/// VISUAL BEHAVIOUR FUNCTIONS
		/// VISUAL BEHAVIOUR FUNCTIONS
		
		override public function onCustomWidthChange():void 
		{ 
			/// tween mask to custom width
			
			Tweener.addTween(_bg,    { width:_custom_width - (2*_frame_size), time:.5, transition:"EaseOutSine" } );
			Tweener.addTween(_mask, { width:_custom_width, time:.5, transition:"EaseOutSine" } );
		};
		
		override public function onCustomHeightChange():void 
		{
			/// tween mask to custom height
			Tweener.addTween(_bg,    { height:_custom_height - (2*_frame_size), time:.5, transition:"EaseOutSine" } );
			Tweener.addTween(_mask, { height:_custom_height, time:.5, transition:"EaseOutSine" } );
		};
		
		public function get frame_size():Number 					{ return _frame_size;  			};
		public function set frame_size(value:Number):void  			{ _frame_size = value; 			};
		
		public function get frame_pattern_data():Array 				{ return _frame_pattern_data; 	};
		public function set frame_pattern_data(value:Array):void  	{ _frame_pattern_data = value; 	};
		
		public function get bg_pattern_data():Array 				{ return _bg_pattern_data; 		};
		public function set bg_pattern_data(value:Array):void  		{ _bg_pattern_data = value; 	};
		
		public function get bg_gradient_data():Array 				{ return _bg_gradient_data; 	};
		public function set bg_gradient_data(value:Array):void  	{ _bg_gradient_data = value; 	};
		
		/// BASIC FUNCTIONS
		
		public function close()
		{
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } );
		}
		
		private function endClose():void
		{
			if (ALIGN_TYPE != "") 
			{
				removeAlign()
			}
			
			destroy();
		}
		
	}
}