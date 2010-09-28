package com.ab.apps.appgenerics.level_bg 
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
		
		public var _gradient_rotation:Number 	= 1.5707963267948966;
		public var _using_stroke:Boolean		= false;
		public var _stroke_thickness:Number		= 2;
		public var _stroke_colour:uint			= 0x000000;
		
		private var alphas:Array;
		private var ratios:Array;
		
		public function Background() 
		{
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
		
		public function get gradient_array():Array 				{ return _gradient_array;  };
		public function set gradient_array(value:Array):void  	{ _gradient_array = value; fillGradient(); };
		
		public function get colour():int 						{ return _colour;  };
		public function set colour(value:int):void  			{ _colour = value; fillBasic(); };
		
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
			// default rotation is (Math.PI/180)*90;
			
			
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