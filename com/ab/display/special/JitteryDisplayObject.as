package com.ab.display.special
{
	/**
	* @author Cadin Batrack
	* Original: http://active.tutsplus.com/tutorials/effects/create-a-static-distortion-effect-using-the-displacement-map-filter/
	* 
	* @modified by Antonio Brandao
	* http://blog.antoniobrandao.com/
	*/
	
	/// flash
	import flash.display.Sprite;
	import flash.display.SimpleButton;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.DisplacementMapFilterMode;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.display.DisplayObject;
	import org.casalib.display.CasaSprite;
	/// ab
	import com.ab.display.ABSprite;
	/// other
	import caurina.transitions.Tweener;
	
	public class JitteryDisplayObject extends ABSprite
	{
		//private var my_object:DisplayObject;
		
		private var _mouse_over:Boolean;
		
		private var staticTimes:int;
		private var fuzzMin:int;
		private var fuzzMax:int;
		
		private var dmFilter:DisplacementMapFilter = createDMFilter();
		private var _staticSound:Sound;// = new StaticSound();
		private var _sound_set:Boolean = false;
		private var roll_over_and_out_effect_activated:Boolean=false;
		
		/// constructor
		//public function JitteryDisplayObject(display_object:DisplayObject) 
		public function JitteryDisplayObject()
		{
			//my_object = display_object;
			
			//this.addEventListener(Event.ADDED_TO_STAGE, 	addedHandler, false, 0, true)
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true)
			// start displaying the static effect
			this.addEventListener(Event.ENTER_FRAME, 		displayStatic, false, 0, true);
			
			//this.addEventListener(MouseEvent.ROLL_OVER, jitteryRollOver, false, 0, true);
		}
		
		/// clean listeners after death
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE,	removedHandler);
			
			_mouse_over = false;
			
			if (roll_over_and_out_effect_activated == true) 
			{
				this.removeEventListener(MouseEvent.ROLL_OVER,	jitteryRollOver);
				this.removeEventListener(MouseEvent.ROLL_OUT,	jitteryRollOut);
			}
		}
		
		/// set roll over & out handlers
		public function activaterollOverRollOutEffects():void
		{
			roll_over_and_out_effect_activated = true;
			
			this.addEventListener(MouseEvent.ROLL_OVER, 	jitteryRollOver, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT,  	jitteryRollOut,  false, 0, true);
		}
		
		/// ROLL OVER handler
		private function jitteryRollOver(e:MouseEvent):void 
		{
			trace( "com.ab.display.special.JitteryDisplayObject.jitteryRollOver");
			
			_mouse_over = true;
			//Tweener.addTween(this, { scaleX: 1.1, time: .5, transition: "easeOutElastic" } );
			Tweener.addTween(this, { scaleX: 1.1, time: .5, transition: "easeOutElastic" } );
			
			setStaticHigh();
			
			if (_sound_set == true)  { _staticSound.play(); };
		}
		
		/// ROLL OUT handler
		private function jitteryRollOut(e:MouseEvent):void 
		{
			_mouse_over = false;
			
			Tweener.addTween(this, { scaleX: 1, time: .5, transition: "easeOutElastic" } );
			setStaticMedium();
		}
		
		/// set fuzzyness intensity to high
		private function setStaticHigh(e:MouseEvent = null):void 
		{	
			fuzzMin = 12;
			fuzzMax = 25;
			staticTimes = 12;
		}
		
		/// set fuzzyness intensity to medium
		private function setStaticMedium(e:MouseEvent = null):void 
		{
			fuzzMin 	= 2;
			fuzzMax 	= 6;
			staticTimes = randRange(8, 12);
		}
		
		// apply fuzzyness constantly
		private function displayStatic(e:Event):void 
		{
			if (_mouse_over == true) 
			{
				staticTimes --;
				
				dmFilter.scaleX 	= randRange(fuzzMin, fuzzMax);
				dmFilter.mapPoint 	= new Point(0, randRange(0, -160));
				this.filters 	= new Array(dmFilter);
				
				if (staticTimes <= 0)
				{
					fuzzMin = 0;
					fuzzMax = 2;
				}
			}
		}	
		
		/// create displacement map filter
		private function createDMFilter():DisplacementMapFilter 
		{
			var mapBitmap:BitmapData = new StaticMap(0,0); // use the bitmap data from our StaticMap image
			var mapPoint:Point       = new Point(0, 0);  // this is the position of the StaticMap image in relation to our button
			var channels:uint        = BitmapDataChannel.RED; // which color to use for displacement
			var componentX:uint      = channels;
			var componentY:uint      = channels;
			var scaleX:Number        = 5; // the amount of horizontal shift
			var scaleY:Number        = 1; // the amount of vertical shift
			var mode:String          = DisplacementMapFilterMode.COLOR;
			var color:uint           = 0;
			var alpha:Number         = 0;
			
			return new DisplacementMapFilter(
							mapBitmap,
							mapPoint,
							componentX,
							componentY,
							scaleX,
							scaleY,
							mode,
							color,
							alpha	);
		}
		
		/// get a random number between a specified range (inclusive)
		private function randRange(min:int, max:int):int 
		{
		    var randomNum:int = Math.floor(Math.random() * (max - min + 1)) + min;
		    return randomNum;
		}
		
		/// set a sound to be played on mouse rollOver
		public function set staticSound(value:Sound):void 
		{
			_staticSound = value;
			
			_sound_set = true;
		}
	}
	
}