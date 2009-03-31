package com.ab.display
{
	/**
	* @author
	* ABº
	*/
	
	import flash.display.MovieClip;
	import org.casalib.display.CasaSprite
	import org.casalib.display.CasaMovieClip
	import caurina.transitions.Tweener
	import org.casalib.util.ObjectUtil
	import flash.events.Event
	import org.casalib.util.StageReference
	import flash.geom.Point
	
	/* Métodos Funcionais:
	 * 
	 * GoVisible
	 * GoInvisible
	 * GoInvisibleWithOnComplete
	 * GoToAlpha
	 * GoToPositionX
	 * GoToPositionY
	 * GoToPositionXY
	 * GoToColour
	 * 
	 * setAlign (alguns tipos falta miplementar a smoothness)
	 * 
	 * SizeToXY
	 * ScaleToXY
	 * 
	 */
	
	
	public dynamic class ABSprite extends CasaSprite
	{
		private var _SMOOTH_ALIGN = false;
		private var h_padding:int = 0;
		private var v_padding:int = 0;
		private var _EASING_SPEED:int=8;
		private var _ALIGN_TYPE:String;
		private var _CUSTOM_HEIGHT:Number;
		private var _CUSTOM_WIDTH:Number;
		
		public function ABSprite() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (StageReference.getStage() == null) 
			{
				throw new Error("StageReference not initialized: Use StageReference.setStage(this.stage); in the project's root")
			}
		}
		
		//// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		//// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		//// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		
		public function GoVisible(duration:Number=NaN, onCompleteFunc:Function=null, _transition:String="EaseOutSine"):void
		{
			this.alpha = 0
			this.visible = true
			
			if (onCompleteFunc != null)
			{
				Tweener.addTween(this, {alpha:1, time:isNaN(duration) ? 0.5 : duration, transition:_transition, onComplete:onCompleteFunc })  //Tweener.addTween(this, {alpha:1, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:onCompleteFunc, onCompleteParams:[this]})				
			}
			else
			{
				Tweener.addTween(this, {alpha:1, time:isNaN(duration) ? 0.5 : duration, transition:_transition})
			}
		}
		
		public function GoInvisible(duration:Number=NaN, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:_transition, onComplete:function(){this.visible = false}} )
		}
		
		/// go to alpha zero and set invisible = true - with optional onComplete Function
		public function GoInvisibleWithOnComplete(duration:Number=NaN, oncompletefunc:Function=null):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:function() { this.visible = false;  oncompletefunc() }} )
		}
		
		public function GoToAlpha(alphavalue:Number, duration:Number=NaN, onCompleteFunc:Function=null):void
		{
			if (onCompleteFunc != null)
			{
				Tweener.addTween(this, {alpha:alphavalue, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:onCompleteFunc, onCompleteParams:[this]})
			}
			else
			{
				Tweener.addTween(this, {alpha:alphavalue, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine"})
			}
		}
		
		//// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		//// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		//// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		
		////////////////////////// TO POSITION X
		public function GoToPositionX(xpos:Number, duration:Number, alphavalue=NaN, _transition:String="EaseOutSine"):void
		{
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(this, { x:xpos, time:duration, transition:_transition } );
			}
			else
			{
				Tweener.addTween(this, { x:xpos, time:duration, alpha:alphavalue, transition: _transition } );
			}	
		}
		
		////////////////////////// TO POSITION Y
		public function GoToPositionY(ypos:Number, duration:Number, alphavalue:Number=NaN, _transition:String="EaseOutSine"):void
		{
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(this, { y:ypos, time:duration, transition:_transition } );
			}
			else
			{
				Tweener.addTween(this, { y:ypos, time:duration, alpha:alphavalue, transition:_transition } );
			}
		}
		
		////////////////////////// TO POSITION X Y
		public function GoToPositionXY(xpos:Number, ypos:Number, duration:Number, alphavalue:Number=NaN, transitionstyle:String="EaseOutsine"):void
		{
			if (isNaN(alphavalue)) 
			{
				Tweener.addTween(this, { x:xpos, y:ypos, time:duration, transition:transitionstyle } );
			}
			else
			{
				Tweener.addTween(this, { x:xpos, y:ypos, time:duration, alpha:alphavalue, transition:transitionstyle } );
			}
		}
		
		//// //// //// //// //// SIZE METHODS
		//// //// //// //// //// SIZE METHODS
		//// //// //// //// //// SIZE METHODS
		
		public function SizeToXY(_width:Number=NaN, _height:Number=NaN, _duration:Number=0.5, _alpha:Number=NaN, _transitionstyle:String="EaseOutsine"):void
		{
			Tweener.addTween(this, { 	width:isNaN(_width) ? this.width : _width,
										height:isNaN(_height) ? this.height : _height,
										time: _duration,
										alpha:isNaN(_alpha) ? this.alpha : _alpha,
										transition: _transitionstyle } );
		}
		
		//// //// //// //// //// SCALE METHODS
		//// //// //// //// //// SCALE METHODS
		//// //// //// //// //// SCALE METHODS
		
		public function ScaleToXY(_xscale:Number=NaN, _yscale:Number=NaN, _duration:Number=0.5, _alpha:Number=NaN, _transitionstyle:String="EaseOutsine"):void
		{
			Tweener.addTween(this, { 	scaleX:isNaN(_xscale) ? this.scaleX : _xscale,
			                            scaleY:isNaN(_xscale) ? this.scaleX : _xscale,
										time: _duration,
										alpha:isNaN(_alpha) ? this.alpha : _alpha,
										transition: _transitionstyle } );
		}
		
		//// //// //// //// //// COLOUR METHODS
		//// //// //// //// //// COLOUR METHODS
		//// //// //// //// //// COLOUR METHODS
		
		public function Colorize(colour:*, _time:Number, _transition:String = "EaseOutSine" ):void
		{
			Tweener.addTween(this, { _color:colour, time:_time, transition:_transition } );
		}
		
		//// //// //// //// //// ALIGN METHODS
		//// //// //// //// //// ALIGN METHODS
		//// //// //// //// //// ALIGN METHODS
		
		public function setAlign(_type:String, _smooth:Boolean=true, custom_height:Number=0, custom_width:Number=0):void
		{
			_SMOOTH_ALIGN = _smooth
			_ALIGN_TYPE = _type
			_CUSTOM_HEIGHT = custom_height;
			_CUSTOM_WIDTH = custom_width;
			
			switch (_type) 
			{
				case "center":
					StageReference.getStage().addEventListener(Event.ENTER_FRAME, centerResizeEnterFrame, false, 0, true);
					break;
					
				case "stretch":
					StageReference.getStage().addEventListener(Event.ENTER_FRAME, stretchResizeEnterFrame, false, 0, true);
					break;
					
				case "topleft":
					StageReference.getStage().addEventListener(Event.RESIZE, topleftResizeEnterFrame, false, 0, true);
					break;
					
				case "topright":
					StageReference.getStage().addEventListener(Event.RESIZE, toprightResizeEnterFrame, false, 0, true);
					break;
					
				case "bottomleft":
					StageReference.getStage().addEventListener(Event.RESIZE, bottomleftResizeEnterFrame, false, 0, true);
					break;
					
				case "bottomright":
					StageReference.getStage().addEventListener(Event.RESIZE, bottomrightResizeEnterFrame, false, 0, true);
					break;
			}
		}
		
		public function removeAlign():void
		{
			switch (_ALIGN_TYPE) 
			{
				case "center":
					StageReference.getStage().removeEventListener(Event.ENTER_FRAME, centerResizeEnterFrame);
					break;
					
				case "stretch":
					StageReference.getStage().removeEventListener(Event.ENTER_FRAME, stretchResizeEnterFrame);
					break;
					
				case "topleft":
					StageReference.getStage().removeEventListener(Event.RESIZE, topleftResizeEnterFrame);
					break;
					
				case "topright":
					StageReference.getStage().removeEventListener(Event.RESIZE, toprightResizeEnterFrame);
					break;
					
				case "bottomleft":
					StageReference.getStage().removeEventListener(Event.RESIZE, bottomleftResizeEnterFrame);
					break;
					
				case "bottomright":
					StageReference.getStage().removeEventListener(Event.RESIZE, bottomrightResizeEnterFrame);
					break;
			}
		}
		
		//// //// //// //// //// RESIZE HANDLERS
		//// //// //// //// //// RESIZE HANDLERS
		//// //// //// //// //// RESIZE HANDLERS
		
		private function centerResizeEnterFrame(e:Event):void // FALTA APLICAR SMOOTHNESS
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			var final_x:Number = 0;
			var final_y:Number = 0;
			
			if (_CUSTOM_WIDTH != 0) 
			{
				final_x = (StageReference.getStage().stageWidth / 2) - (_CUSTOM_WIDTH / 2) - zero_x;
			}
			else
			{
				final_x = (StageReference.getStage().stageWidth / 2) - (this.width / 2) - zero_x;
			}
			
			if (_CUSTOM_HEIGHT != 0) 
			{
				final_y = (StageReference.getStage().stageHeight / 2) - (_CUSTOM_HEIGHT / 2) - zero_y;
			}
			else
			{
				final_y = (StageReference.getStage().stageHeight / 2) - (this.height / 2) - zero_y;
			}
			
			
			
			if (_SMOOTH_ALIGN == true)
			{
				this.x += Math.round((final_x - this.x) / _EASING_SPEED)
				this.y += Math.round((final_y - this.y) / _EASING_SPEED)
			}
			else
			{
				this.x = final_x
				this.y = final_y
			}
		}
		
		private function stretchResizeEnterFrame(e:Event):void  // FEITO (normalmente este nao pode ser smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = -zero_x - 50
			this.y = -zero_y - 50
			this.height = StageReference.getStage().stageHeight + 100
			this.width = StageReference.getStage().stageWidth + 100
		}
		
		private function topleftResizeEnterFrame(e:Event):void    // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = -zero_x + h_padding
			this.y = -zero_y + v_padding
		}
		
		private function toprightResizeEnterFrame(e:Event):void     // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = StageReference.getStage().stageWidth - h_padding - zero_x
			this.y = -zero_y + v_padding
		}
		
		private function bottomleftResizeEnterFrame(e:Event):void     // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = -zero_x + h_padding
			this.y = StageReference.getStage().stageHeight - this.height - v_padding - zero_y
		}
		
		private function bottomrightResizeEnterFrame(e:Event):void  // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = - zero_x + StageReference.getStage().stageWidth - h_padding
			this.y = - zero_y + StageReference.getStage().stageHeight - v_padding
		}
		
		//// //// //// //// //// RESIZE PADDING SETTERS //// //// //// //// ////
		//// //// //// //// //// RESIZE PADDING SETTERS //// //// //// //// ////
		
		public function set horizontal_padding(value:int):void
		{
			h_padding = value;
		}
		
		public function set vertical_padding(value:int):void
		{
			v_padding = value;
		}
		
		//// //// //// //// //// RESOURCE MANAGEMENT
		//// //// //// //// //// RESOURCE MANAGEMENT
		//// //// //// //// //// RESOURCE MANAGEMENT
		
		public function goodbye(duration:Number=NaN):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:cleanMe } )
		}
		
		public function cleanMe():void
		{
			destroy()
		}
	}
}