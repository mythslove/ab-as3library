package com.ab.appobjects
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.properties.FilterShortcuts;
	import caurina.transitions.Tweener;
	import com.ab.display.ABSprite;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class Background extends ABSprite
	{
		private var _colour:int;				/// use setter to make solid colour bg
		private var _gradient_array:Array;		/// use setter to make gradient bg
		
		private var _gradient_rotation:Number 	= 1.5707963267948966;
		private var _using_stroke:Boolean		= false;
		private var _stroke_thickness:Number	= 2;
		private var _stroke_colour:uint			= 0x000000;
		
		private var alphas:Array;
		private var ratios:Array;
		
		private var background_class:Class;		/// this class must implement Background interface
		
		public function Background(_background_class:Class=null) 
		{
			background_class = _background_class;
			
			setVars();
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function setVars():void
		{
			_gradient_array = new Array();
			
			alphas = new Array();
			ratios = new Array();
			
			alphas = [ 1, 1];
			ratios = [ 0, 255 ];
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			setAlign("stretch");
		}
		
		public function get gradient_array():Array 				 	{ return _gradient_array;  };
		public function set gradient_array(value:Array):void  	 	{ _gradient_array = value; fillGradient(); };
		
		public function get colour():int 						 	{ return _colour;  };
		public function set colour(value:int):void  			 	{ _colour = value; fillBasic(); };
		
		public function get gradient_rotation():Number 			 	{ return _gradient_rotation; }
		public function set gradient_rotation(value:Number):void 	{ _gradient_rotation = value; }
		
		public function get using_stroke():Boolean 					{ return _using_stroke; }
		public function set using_stroke(value:Boolean):void  		{ _using_stroke = value; }
		
		public function get stroke_thickness():Number 				{ return _stroke_thickness; }
		public function set stroke_thickness(value:Number):void 	{ _stroke_thickness = value;}
		
		public function get stroke_colour():uint 					{ return _stroke_colour; }
		public function set stroke_colour(value:uint):void 			{ _stroke_colour = value;}
		
		private function fillBasic():void
		{
			this.graphics.clear();
			this.graphics.beginFill(_colour);
			this.graphics.drawRect(0, 0, custom_width, custom_height);
			this.graphics.endFill();
			
			if (_using_stroke == true) 
			{
				this.graphics.lineStyle(_stroke_thickness, _stroke_colour);
			}
		}
		
		private function fillGradient():void
		{
			/// default rotation is (Math.PI/180)*90;
			
			var matrix:Matrix = new Matrix();
			
			matrix.createGradientBox(custom_width, custom_height, _gradient_rotation, 0, 0);
			this.graphics.beginGradientFill(GradientType.LINEAR, _gradient_array, alphas, ratios, matrix);
			this.graphics.drawRect( 0.0, 0.0, custom_width, custom_width);
			this.graphics.endFill();
			
			if (_using_stroke == true) 
			{
				this.graphics.lineStyle(_stroke_thickness,_stroke_colour);
			}
			
			if (!using_filters) 	{ FilterShortcuts.init(); using_filters = true; };
			
			Tweener.addTween(this, 	{ _Blur_blurX:10, _Blur_blurY:10, _Blur_quality:4, time:0.2 } );
			
			this.cacheAsBitmap = true;
		}
		
	}
	
}