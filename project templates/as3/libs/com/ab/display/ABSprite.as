package com.ab.display
{
	/**
	* @author
	* ABº
	*/
	
	import com.ab.display.utils.Alignment;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import org.casalib.display.CasaSprite;
	import org.casalib.display.CasaMovieClip;
	import caurina.transitions.Tweener;
	import org.casalib.util.ObjectUtil;
	import flash.events.Event;
	import org.casalib.util.StageReference;
	import flash.geom.Point;
	import caurina.transitions.properties.FilterShortcuts;
	
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
		private var _smooth_align:Boolean 	= false;
		private var _align_type:String	 	= "";
		private var _h_padding:int 		 	= 0;
		private var _v_padding:int 		 	= 0;
		private var _custom_height:Number 	= 0;
		private var _custom_width:Number  	= 0;
		
		public var registration_point:Point;
		
		private var _align_scope:String  	= "global";
		private var custom_parent:*;
		private var align_set:Boolean 	 	= false;
		
		private var _easing_speed:int 	 	= 8;
		private var _stage:Stage;
		public var using_filters:Boolean	= false;
		
		public function ABSprite() 
		{
			setRegistration();
			
			addEventListener(Event.ADDED_TO_STAGE, 		onAddedToStage, 	false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, 	onRemovedFromStage, false, 0, true);
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			if (align_set == true) { removeAlign(); }
			
			custom_parent == null;
			
			removeEventListener(Event.REMOVED_FROM_STAGE, 	onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_stage = stage;
			
			onStage();
		}
		
		public function onStage():void
		{
			/// override this function in order to get some action after this enters the stage
		}
		
		/// dynamic movie features
		/// dynamic movie features
		/// dynamic movie features
		
		public function get x2():Number
		{
			var p:Point = this.parent.globalToLocal(this.localToGlobal(registration_point));
			return p.x;
		}
		
		public function set x2(value:Number):void
		{
			var p:Point = this.parent.globalToLocal(this.localToGlobal(registration_point));
			this.x += value - p.x;
		}
		
		public function get y2():Number
		{
			var p:Point = this.parent.globalToLocal(this.localToGlobal(registration_point));
			return p.y;
		}
		
		public function set y2(value:Number):void
		{
			var p:Point = this.parent.globalToLocal(this.localToGlobal(registration_point));
			this.y += value - p.y;
		}
		
		public function setRegistration(x:Number=0, y:Number=0):void
		{
			registration_point = new Point(x, y);
		}
		
		public function get scaleX2():Number
		{
			return this.scaleX;
		}
		
		public function set scaleX2(value:Number):void
		{
			this.setProperty2("scaleX", value);
		}
		
		public function get scaleY2():Number
		{
			return this.scaleY;
		}
		
		public function set scaleY2(value:Number):void
		{
			this.setProperty2("scaleY", value);
		}
		
		public function get rotation2():Number
		{
			return this.rotation;
		}
		
		public function set rotation2(value:Number):void
		{
			this.setProperty2("rotation", value);
		}
		
		public function get mouseX2():Number
		{
			return Math.round(this.mouseX - registration_point.x);
		}
		
		public function get mouseY2():Number
		{
			return Math.round(this.mouseY - registration_point.y);
		}
		
		public function setProperty2(prop:String, n:Number):void
		{
			var a:Point = this.parent.globalToLocal(this.localToGlobal(registration_point));
			
			this[prop] 	= n;
			
			var b:Point = this.parent.globalToLocal(this.localToGlobal(registration_point));
			
			this.x -= b.x - a.x;
			this.y -= b.y - a.y;
		}
		
		/// //// //// //// //// GETTERS / SETTERS //// //// //// //// ////
		/// //// //// //// //// GETTERS / SETTERS //// //// //// //// ////
		
		public function get easing_speed():int 					{ return _easing_speed;   };
		public function set easing_speed(value:int):void  		{ _easing_speed = value;  };
		
		public function get v_padding():int 					{ return _v_padding;      };
		public function set v_padding(value:int):void 			{ _v_padding = value; 	  };
		
		public function get h_padding():int 					{ return _h_padding;      };
		public function set h_padding(value:int):void 			{ _h_padding = value;     };
		
		public function get custom_height():Number 				{ return _custom_height;  };
		public function set custom_height(value:Number):void  	{ _custom_height = value; onCustomHeightChange(); };
		
		public function get custom_width():Number 				{ return _custom_width;   };
		public function set custom_width(value:Number):void  	{ _custom_width = value;  onCustomWidthChange();  };
		
		public function get align_type():String 				{ return _align_type; 	  };
		public function set align_type(value:String):void  		{ _align_type = value; 	  };
		
		public function onCustomWidthChange():void 				{ }; /// override to use
		public function onCustomHeightChange():void 			{ }; /// override to use
		
		/// FORCE WHOLE PIXEL
		/// FORCE WHOLE PIXEL
		/// FORCE WHOLE PIXEL
		
		override public function set x( value:Number ):void 		{ super.x = Math.round( value ); }
		override public function set y( value:Number ):void 		{ super.y = Math.round( value ); }
		override public function set width( value:Number ):void 	{ super.width = Math.round( value ); }
		override public function set height( value:Number ):void 	{ super.height = Math.round( value ); }
		
		/// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		/// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		/// //// //// //// //// ALPHA METHODS //// //// //// //// ////
		
		public function GoVisible(duration:Number=0.5, onCompleteFunc:Function=null, _transition:String="EaseOutSine"):void
		{
			if (this.visible = false)  { this.alpha = 0; this.visible = true; };
			
			Tweener.addTween(this, {alpha:1, time:duration, transition:_transition, onComplete:onCompleteFunc });
		}
		
		public function GoInvisible(duration:Number=0.5, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(this, { alpha:0, time:duration, transition:_transition, onComplete:function():void { this.visible = false }} );
		}
		
		// go to alpha zero and set invisible = true - with optional onComplete Function
		public function GoInvisibleWithOnComplete(oncompletefunc:Function, duration:Number=0.5):void
		{
			Tweener.addTween(this, { alpha:0, time:duration, transition:"EaseOutSine", onComplete:function():void { this.visible = false;  oncompletefunc() }} );
		}
		
		public function GoToAlpha(alphavalue:Number, duration:Number=0.5, onCompleteFunc:Function=null):void
		{
			if (onCompleteFunc != null)
			{
				Tweener.addTween(this, {alpha:alphavalue, time:duration, transition:"EaseOutSine", onComplete:onCompleteFunc, onCompleteParams:[this]});
			}
			else
			{
				Tweener.addTween(this, {alpha:alphavalue, time:duration, transition:"EaseOutSine"});
			}
		}
		
		/// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		/// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		/// //// //// //// //// MOVE METHODS //// //// //// //// //// 
		
		/// ////////////////////// TO POSITION X
		public function GoToPositionX(xpos:Number, duration:Number=0.5, alphavalue:Number=NaN, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(this, { x:xpos, time:duration, alpha:isNaN(alphavalue) ? 0.5 : alphavalue, transition:_transition } );
		}
		
		/// /////////////////////// TO POSITION Y
		public function GoToPositionY(ypos:Number, duration:Number, alphavalue:Number=NaN, _transition:String="EaseOutSine"):void
		{
			Tweener.addTween(this, { y:ypos, time:duration, alpha:isNaN(alphavalue) ? 0.5 : alphavalue, transition:_transition } );
		}
		
		/// /////////////////////// TO POSITION X Y
		public function GoToPositionXY(xpos:Number, ypos:Number, duration:Number, alphavalue:Number=NaN, transitionstyle:String="EaseOutsine"):void
		{
			Tweener.addTween(this, { x:xpos, y:ypos, time:duration, alpha:isNaN(alphavalue) ? 0.5 : alphavalue, transition:transitionstyle } );
		}
		
		/// //// //// //// //// SIZE METHODS
		/// //// //// //// //// SIZE METHODS
		/// //// //// //// //// SIZE METHODS
		
		public function gotoSize(_width:Number=NaN, _height:Number=NaN, _duration:Number=0.5, _alpha:Number=NaN, _transitionstyle:String="EaseOutSine"):void
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
		
		public function gotoScale(_xscale:Number=NaN, _yscale:Number=NaN, _duration:Number=0.5, _alpha:Number=NaN, _transitionstyle:String="EaseOutsine"):void
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
		
		public function colorize(colour:*, _time:Number=0.5, _transition:String = "EaseOutSine" ):void
		{
			Tweener.addTween(this, { _color:colour, time:_time, transition:_transition } );
		}
		
		/// //// //// //// //// ALIGN METHODS
		/// //// //// //// //// ALIGN METHODS
		/// //// //// //// //// ALIGN METHODS
		
		public function setAlign(_type:String, _smooth:Boolean=true, __custom_height:Number=0, __custom_width:Number=0, _scope:String="global", _custom_parent:Object=null):void
		{
			if (align_set == true) { removeAlign(); }
			
			_smooth_align  = _smooth;
			_align_type    = _type;
			_align_scope   = _scope;
			
			if (_custom_parent != null) { this.custom_parent = _custom_parent; }
			
			__custom_height == 0 ? _custom_height = _custom_height : _custom_height = __custom_height;
			__custom_width  == 0 ? _custom_width  = _custom_width  : _custom_width  = __custom_width;
			
			align_set = true;
			
			switch (_type) 
			{
				case Alignment.RIGHT:
					_stage.addEventListener(Event.ENTER_FRAME, rightResizeEnterFrame, false, 0, true);
					break;
					
				case Alignment.LEFT:
					_stage.addEventListener(Event.ENTER_FRAME, leftResizeEnterFrame, false, 0, true);
					break;
					
				case Alignment.CENTER:
					_stage.addEventListener(Event.ENTER_FRAME, centerResizeEnterFrame, false, 0, true);
					break;
					
				case Alignment.STRETCH:
					_stage.addEventListener(Event.ENTER_FRAME, stretchResizeEnterFrame, false, 0, true);
					break;
					
				case Alignment.TOP_LEFT:
					_stage.addEventListener(Event.RESIZE, topleftResizeEnterFrame, false, 0, true);
					topleftResizeEnterFrame(new Event(Event.RESIZE))
					break;
					
				case Alignment.TOP_RIGHT:
					_stage.addEventListener(Event.RESIZE, toprightResizeEnterFrame, false, 0, true);
					toprightResizeEnterFrame(new Event(Event.RESIZE))
					break;
					
				case Alignment.BOTTOM:
					_stage.addEventListener(Event.ENTER_FRAME, bottomResizeEnterFrame, false, 0, true);
					break;
					
				case Alignment.BOTTOM_LEFT:
					_stage.addEventListener(Event.RESIZE, bottomleftResizeEnterFrame, false, 0, true);
					bottomleftResizeEnterFrame(new Event(Event.RESIZE))
					break;
					
				case Alignment.BOTTOM_RIGHT:
					_stage.addEventListener(Event.RESIZE, bottomrightResizeEnterFrame, false, 0, true);
					bottomrightResizeEnterFrame(new Event(Event.RESIZE))
					break;
			}
		}
		
		public function removeAlign():void
		{
			if (align_set == true) 
			{
				align_set = false;
				
				switch (_align_type) 
				{
					case Alignment.RIGHT:
						_stage.removeEventListener(Event.ENTER_FRAME, rightResizeEnterFrame);
						break;
						
					case Alignment.LEFT:
						_stage.removeEventListener(Event.ENTER_FRAME, leftResizeEnterFrame);
						break;
						
					case Alignment.CENTER:
						_stage.removeEventListener(Event.ENTER_FRAME, centerResizeEnterFrame);
						break;
						
					case Alignment.STRETCH:
						_stage.removeEventListener(Event.ENTER_FRAME, stretchResizeEnterFrame);
						break;
						
					case Alignment.TOP_LEFT:
						_stage.removeEventListener(Event.RESIZE, topleftResizeEnterFrame);
						break;
						
					case Alignment.TOP_RIGHT:
						_stage.removeEventListener(Event.RESIZE, toprightResizeEnterFrame);
						break;
						
					case Alignment.BOTTOM:
						_stage.removeEventListener(Event.ENTER_FRAME, bottomResizeEnterFrame);
						break;
						
					case Alignment.BOTTOM_LEFT:
						_stage.removeEventListener(Event.RESIZE, bottomleftResizeEnterFrame);
						break;
						
					case Alignment.BOTTOM_RIGHT:
						_stage.removeEventListener(Event.RESIZE, bottomrightResizeEnterFrame);
						break;
				}
			}
		}
		
		/// //// //// //// //// RESIZE HANDLERS
		/// //// //// //// //// RESIZE HANDLERS
		/// //// //// //// //// RESIZE HANDLERS
		
		private function centerResizeEnterFrame(e:Event):void // FALTA APLICAR SMOOTHNESS
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number;
			var zero_y:Number;
			
			var final_x:Number = 0;
			var final_y:Number = 0;
			
			if (parent != null) 
			{
				zero_x = parent.localToGlobal(zero_point).x;
				zero_y = parent.localToGlobal(zero_point).y;
			}
			else
			{
				zero_x = 0;
				zero_y = 0;
			}
			
			if (_custom_width != 0) 
			{
				final_x = (_stage.stageWidth / 2) - (_custom_width / 2) - zero_x;
			}
			else
			{
				final_x = (_stage.stageWidth / 2) - (this.width / 2) - zero_x;
			}
			
			if (_custom_height != 0) 
			{
				final_y = (_stage.stageHeight / 2) - (_custom_height / 2) - zero_y;
			}
			else
			{
				final_y = (_stage.stageHeight / 2) - (this.height / 2) - zero_y;
			}
			
			if (_smooth_align == true)
			{
				if (this.x != final_x)  { this.x += Math.round((final_x - this.x) / _easing_speed); }
				if (this.y != final_y)  { this.y += Math.round((final_y - this.y) / _easing_speed); }
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
			this.height = _stage.stageHeight + 100
			this.width = _stage.stageWidth + 100
		}
		
		private function topleftResizeEnterFrame(e:Event):void    // INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number=0;
			var zero_y:Number=0;
			
			if (parent) 
			{
				zero_x = parent.localToGlobal(zero_point).x;
				zero_y = parent.localToGlobal(zero_point).y;				
			}
			
			this.x = -zero_x + _h_padding
			this.y = -zero_y + _v_padding
		}
		
		private function leftResizeEnterFrame(e:Event):void    /// INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var finalposition:Number = 0 + _h_padding;
			//var zero_x:Number = parent.localToGlobal(zero_point).x
			//var zero_y:Number = parent.localToGlobal(zero_point).y
			
			if (this.x != finalposition) { GoToPositionX(finalposition, 0.2) }
			
			this.y = _stage.stageHeight / 2 - _custom_height / 2;// - zero_y;
		}
		
		private function rightResizeEnterFrame(e:Event):void    /// INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var finalposition:Number = _stage.stageWidth - _h_padding;
			//var zero_x:Number = parent.localToGlobal(zero_point).x
			//var zero_y:Number = parent.localToGlobal(zero_point).y
			
			if (this.x != finalposition) { GoToPositionX(finalposition, 0.2) }
			
			this.y = _stage.stageHeight / 2 - _custom_height / 2;// - zero_y;
		}
		
		private function toprightResizeEnterFrame(e:Event):void     /// INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number=0;
			var zero_y:Number=0;
			
			if (parent) 
			{
				zero_x = parent.localToGlobal(zero_point).x;
				zero_y = parent.localToGlobal(zero_point).y;				
			}
			
			this.x = _stage.stageWidth - _h_padding - zero_x
			this.y = -zero_y + _v_padding
		}
		
		private function bottomResizeEnterFrame(e:Event):void     /// INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number;
			var zero_y:Number;
			
			if (_align_scope == "global") 
			{
				if (parent != null) 
				{
					zero_x = parent.localToGlobal(zero_point).x; 
					zero_y = parent.localToGlobal(zero_point).y;
				}                                         
				else 
				{ 
					zero_x = 0; zero_y = 0; 
				}
				
				this.x = -zero_x + _h_padding;
				this.y = _stage.stageHeight - this.height - _v_padding - zero_y;
			}
			
			if (_align_scope == "parent") 
			{
				this.x = (parent.width / 2) - (this.width / 2);
				this.y = parent.height - this.height - _v_padding;
			}
			
			if (_align_scope == "customparent") 
			{
				this.x = (this.custom_parent.width / 2) - (this.width / 2);
				this.y = this.custom_parent.height - this.height - _v_padding;
			}
		}
		
		private function bottomleftResizeEnterFrame(e:Event):void     /// INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number;
			var zero_y:Number;
			
			if (parent != null) 
			{
				zero_x = parent.localToGlobal(zero_point).x;
				zero_y = parent.localToGlobal(zero_point).y;
			}                                         
			else
			{
				zero_x = 0;
				zero_y = 0;
			}
			
			this.x = -zero_x + _h_padding;
			this.y = _stage.stageHeight - this.height - _v_padding - zero_y;
		}
		
		private function bottomrightResizeEnterFrame(e:Event):void  /// INACABADO (falta opçao smooth)
		{
			var zero_point:Point = new Point(0, 0);
			var zero_x:Number    = parent.localToGlobal(zero_point).x
			var zero_y:Number    = parent.localToGlobal(zero_point).y
			
			this.x = - zero_x + _stage.stageWidth  - _h_padding;
			this.y = - zero_y + _stage.stageHeight - _v_padding;
		}
		
		public function blurOutAndExecuteFunction(_function:Function, duration:Number=NaN):void
		{
			if (!using_filters) 	{ FilterShortcuts.init(); using_filters = true; }
			
			Tweener.addTween(this, 	{ alpha:0, _Blur_blurX:40, _Blur_blurY:40, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:_function } )
		}
		
		/// //// //// //// //// MISC UTILITIES
		/// //// //// //// //// MISC UTILITIES
		/// //// //// //// //// MISC UTILITIES
		
		public function get visibleBounds():Rectangle 
		{ 
			var wrongBounds:Rectangle 	= this.getBounds(this); 
			var matrix:Matrix 			= new Matrix(); 
			matrix.translate(-wrongBounds.x, -wrongBounds.y); 
			var bitmapData:BitmapData 	= new BitmapData(this.width, this.height, true, 0x00000000); 
			bitmapData.draw(this, matrix); 
			var bounds:Rectangle 		= bitmapData.getColorBoundsRect(0xFF000000, 0, false); 
			bitmapData.dispose(); 
			return bounds; 
		}
		
		/// //// //// //// //// RESOURCE MANAGEMENT
		/// //// //// //// //// RESOURCE MANAGEMENT
		/// //// //// //// //// RESOURCE MANAGEMENT
		
		public function dieWithBlurOutElastic(duration:Number=0.5):void
		{
			Tweener.addTween(this, 	{ alpha:0, _Blur_blurX:40, _Blur_blurY:40, time:duration, scaleX:1.3, scaleY:1.3, transition:"EaseInOutBack", onComplete:cleanMe } )
		}
		
		public function dieWithBlurOut(duration:Number=0.5):void
		{
			Tweener.addTween(this, 	{ alpha:0, _Blur_blurX:40, _Blur_blurY:40, time:duration, transition:"EaseOutSine", onComplete:cleanMe } )
		}
		
		public function die(duration:Number=NaN):void
		{
			Tweener.addTween(this, { alpha:0, time:isNaN(duration) ? 0.5 : duration, transition:"EaseOutSine", onComplete:cleanMe } )
		}
		
		public function cleanMe():void
		{
			trace ("ABSprite ::: cleanMe()"); 
			
			custom_parent = null;
			
			if (align_set == true)  { removeAlign(); }
			
			destroy();
		}
	}
}