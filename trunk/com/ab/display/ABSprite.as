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
	 * setAlign (alguns tipos falta implementar a smoothness)
	 * 
	 * SizeToXY
	 * ScaleToXY
	 * 
	 */
	
	
	public dynamic class ABSprite extends CasaSprite
	{
		private var _SMOOTH_ALIGN = false;
		private var _ALIGN_TYPE:String;
		private var _h_padding:int = 0;
		private var _v_padding:int = 0;
		
		public var _EASING_SPEED:int=8;
		public var _custom_height:Number=0;
		public var _custom_width:Number=0;
		
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
		
		/// //// //// //// //// GETTERS / SETTERS //// //// //// //// ////
		/// //// //// //// //// GETTERS / SETTERS //// //// //// //// ////
		
		public function get v_padding():int 					{ return _v_padding;      }
		public function set v_padding(value:int):void 			{ _v_padding = value; 	  }
		
		public function get h_padding():int 					{ return _h_padding;      }
		public function set h_padding(value:int):void 			{ _h_padding = value;     }
		
		public function get custom_height():Number 				{ return _custom_height;  }
		public function set custom_height(value:Number):void  	{ _custom_height = value; }
		
		public function get custom_width():Number 				{ return _custom_width;   }
		public function set custom_width(value:Number):void  	{ _custom_width = value;  }
		
		/// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		/// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		/// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		
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
		
		/// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		/// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		/// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		
		/// ////////////////////// TO POSITION X
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
		
		/// /////////////////////// TO POSITION Y
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
		
		/// /////////////////////// TO POSITION X Y
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
		
		/// //// //// //// //// SIZE METHODS
		/// //// //// //// //// SIZE METHODS
		/// //// //// //// //// SIZE METHODS
		
		public function SizeToXY(_width:Number=NaN, _height:Number=NaN, _duration:Number=0.5, _alpha:Number=NaN, _transitionstyle:String="EaseOutsine"):void
		{
			Tweener.addTween(this, { 	width:isNaN(_width) ? this.width : _width,
										height:isNaN(_height) ? this.height : _height,
										time: _duration,
										alpha:isNaN(_alpha) ? this.alpha : _alpha,
										transition: _transitionstyle } );
		}
		
		/// //// //// //// //// SCALE METHODS
		/// //// //// //// //// SCALE METHODS
		/// //// //// //// //// SCALE METHODS
		
		public function ScaleToXY(_xscale:Number=NaN, _yscale:Number=NaN, _duration:Number=0.5, _alpha:Number=NaN, _transitionstyle:String="EaseOutsine"):void
		{
			Tweener.addTween(this, { 	scaleX:isNaN(_xscale) ? this.scaleX : _xscale,
			                            scaleY:isNaN(_xscale) ? this.scaleX : _xscale,
										time: _duration,
										alpha:isNaN(_alpha) ? this.alpha : _alpha,
										transition: _transitionstyle } );
		}
		
		/// //// //// //// //// COLOUR METHODS
		/// //// //// //// //// COLOUR METHODS
		/// //// //// //// //// COLOUR METHODS
		
		public function Colorize(colour:*, _time:Number, _transition:String = "EaseOutSine" ):void
		{
			Tweener.addTween(this, { _color:colour, time:_time, transition:_transition } );
		}
		
		/// //// //// //// //// ALIGN METHODS
		/// //// //// //// //// ALIGN METHODS
		/// //// //// //// //// ALIGN METHODS
		
		public function setAlign(_type:String, _smooth:Boolean=true, __custom_height:Number=0, __custom_width:Number=0):void
		{
			_SMOOTH_ALIGN  = _smooth
			_ALIGN_TYPE    = _type
			
			_custom_height = __custom_height == 0 ? _custom_height : __custom_height;
			_custom_width  = __custom_width  == 0 ? _custom_width  : __custom_width;
			
			//_custom_height = custom_height;
			//_custom_width  = custom_width;
			
			if (this.hasEventListener(Event.ENTER_FRAME) || this.hasEventListener(Event.RESIZE)) 
			{
				removeAlign()
			}
			
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
		
		/// //// //// //// //// RESIZE HANDLERS
		/// //// //// //// //// RESIZE HANDLERS
		/// //// //// //// //// RESIZE HANDLERS
		
		private function centerResizeEnterFrame(e:Event):void // FALTA APLICAR SMOOTHNESS
		{
			var zero_point:Point = new Point(0, 0);
			//var zero_x:Number = parent.localToGlobal(zero_point).x
			//var zero_y:Number = parent.localToGlobal(zero_point).y
			
			var final_x:Number = 0;
			var final_y:Number = 0;
			
			if (_custom_width != 0) 
			{
				final_x = (StageReference.getStage().stageWidth / 2) - (_custom_width / 2)// - zero_x;
			}
			else
			{
				final_x = (StageReference.getStage().stageWidth / 2) - (this.width / 2)// - zero_x;
			}
			
			if (_custom_height != 0) 
			{
				final_y = (StageReference.getStage().stageHeight / 2) - (_custom_height / 2)// - zero_y;
			}
			else
			{
				final_y = (StageReference.getStage().stageHeight / 2) - (this.height / 2)// - zero_y;
			}
			
			if (_SMOOTH_ALIGN == true)
			{
				this.x += Math.round((final_x - this.x) / _EASING_SPEED);
				this.y += Math.round((final_y - this.y) / _EASING_SPEED);
			}
			else
			{
				this.x = final_x;
				this.y = final_y;
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
			
			this.x = -zero_x + _h_padding
			this.y = -zero_y + _v_padding
		}
		
		private function toprightResizeEnterFrame(e:Event):void     // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = StageReference.getStage().stageWidth - _h_padding - zero_x
			this.y = -zero_y + _v_padding
		}
		
		private function bottomleftResizeEnterFrame(e:Event):void     // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number = parent.localToGlobal(zero_point).x
			var zero_y:Number = parent.localToGlobal(zero_point).y
			
			this.x = -zero_x + _h_padding
			this.y = StageReference.getStage().stageHeight - this.height - _v_padding - zero_y
		}
		
		private function bottomrightResizeEnterFrame(e:Event):void  // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number    = parent.localToGlobal(zero_point).x
			var zero_y:Number    = parent.localToGlobal(zero_point).y
			
			this.x = - zero_x + StageReference.getStage().stageWidth  - _h_padding;
			this.y = - zero_y + StageReference.getStage().stageHeight - _v_padding;
		}
		
		/// //// //// //// //// RESOURCE MANAGEMENT
		/// //// //// //// //// RESOURCE MANAGEMENT
		/// //// //// //// //// RESOURCE MANAGEMENT
		
		public function goodbye(duration:Number=NaN):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:cleanMe } )
		}
		
		public function cleanMe():void
		{
			if (this.hasEventListener(Event.ENTER_FRAME) || this.hasEventListener(Event.RESIZE)) 
			{
				this.removeEventListeners();
			}
			
			destroy()
		}
	}
}