package com.ab.display.galleries.touchgallery 
{
	
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.utils.Make;
	import com.ab.utils.Size;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import org.casalib.display.CasaMovieClip;
	import org.casalib.util.StageReference;
	import com.ab.display.galleries.touchgallery.TouchGallery;
	import flash.display.MovieClip;
	import flash.display.DisplayObject
	import com.ab.utils.HitTest
	
	/// lock
	public class TouchGalleryItem extends CasaMovieClip
	{
		public var bg:MovieClip;
		public var thumbholder_mc:MovieClip;
		
		private var mx0:Number=0;
		private var mxx:Number=0;
		private var addx:Number=0;
		private var addy:Number=0;
		private var fx:Number=0;
		private var k:Number=0;
		private var kx:Number=0;
		private var ky:Number=0;
		private var mlength:Number=0;
		private var mforce:Number=0;
		private var fy:Number=0;
		private var ldx:Number=0;
		private var ldy:Number=0;
		private var dmx:Number=0;
		private var dmy:Number=0;
		private var inx:Number=0;
		private var iny:Number=0;
		private var my:Number=0;
		private var my0:Number=0;
		private var modo:Number = 2;
		private var modo_time:Number = 2;
		private var m:Number = 1;
		private var inercia:Number = 900;
		private var _rotation_var:Number;
		private var vr:Number;
		private var _friction = 1.2;
		private var torque = 0;
		private var min = 1;
		private var originx:Number;
		private var originy:Number;
		private var originr:Number;
		private var _ROOT_OBJECT:TouchGallery;
		public var _OPENED:Boolean;
		private var _imagepath:String;
		private var _RESTORE_X:Number;
		private var _RESTORE_Y:Number;
		private var _RESTORE_R:Number;
		private var vx:Number;
		private var vy:Number;
		private var timer:Number;
		private var _imageType:String;
		//private var _stage_var:Stage
		//private var vr:Number;
		
		public function TouchGalleryItem(_root:TouchGallery)
		{
			_ROOT_OBJECT = _root;
			
			initVars()
			
			//trace ("TouchGalleryItem ::: TouchGalleryItem = "); 
			
			addListeners()
			
			//_stage_var = StageReference.getStage();
		}
		
		public function get OPENED():Boolean 				{ return _OPENED; }
		public function set OPENED(value:Boolean):void  	{ _OPENED = value; }
		
		public function get imagepath():String 				{ return _imagepath; }
		public function set imagepath(value:String):void	{ _imagepath = value; }
		
		public function get imageType():String 				{ return _imageType; }
		public function set imageType(value:String):void  	{ _imageType = value; }
		
		private function initVars():void
		{
			originx = this.x;
			originy = this.y;
			originr = this.rotation;
			
			//inx = _stage_var.stageWidth / 2 + ((Math.random()*20) * -1);
			inx = _ROOT_OBJECT.HORIZONTAL_SIZE / 2 + ((Math.random()*20) * -1);
			iny = _ROOT_OBJECT.VERTICAL_SIZE / 2   + ((Math.random()*20) * -1);
			
			_rotation_var = this.rotation;
			
			//vr = (Math.random() * 40) * -1;
			//vx = 0//_ROOT_OBJECT.parent.HORIZONTAL_SIZE / 2;
			//vy = (Math.random() * 5) * -1;
			
			///vr = (Math.random() * 40) * -1;
			///vx = ((Math.random() * 50) * -1) + (Math.random() * 50)
			///vy = ((Math.random() * 30) * -1) + (Math.random() * 30)
			
			vr = (Math.random() * 40) * -1;
			vx = ((Math.random() * 50) * -1) + (Math.random() * 50)
			vy = ((Math.random() * 30) * -1) + (Math.random() * 30)
		}
		
		private function openItem() 
		{
			if (!_OPENED)
			{
				_ROOT_OBJECT._OPENED_ITEM = this;
				
				_RESTORE_X = this.x;
				_RESTORE_Y = this.y;
				_RESTORE_R = this.rotation;
				
				var r_var:Number
				var x_var:Number = _ROOT_OBJECT.HORIZONTAL_SIZE / 2 - (_ROOT_OBJECT.HORIZONTAL_SIZE / 40);
				var y_var:Number = _ROOT_OBJECT.VERTICAL_SIZE  / 2  - (_ROOT_OBJECT.VERTICAL_SIZE / 20);
				
				if (this._imageType == "vertical") 
				{
					r_var = 90;
					x_var = _ROOT_OBJECT.HORIZONTAL_SIZE / 2;// - (_ROOT_OBJECT.HORIZONTAL_SIZE / 40);
					y_var = _ROOT_OBJECT.VERTICAL_SIZE  / 2   - (_ROOT_OBJECT.VERTICAL_SIZE / 20);
				}
				else
				{
					r_var = 0;
					x_var = _ROOT_OBJECT.HORIZONTAL_SIZE / 2 - (_ROOT_OBJECT.HORIZONTAL_SIZE / 40);
					y_var = _ROOT_OBJECT.VERTICAL_SIZE  / 2   - (_ROOT_OBJECT.VERTICAL_SIZE / 20);
				}
				
				Tweener.addTween(this, { rotation:r_var, x:x_var, y:y_var, scaleX:3, scaleY:3, time:0.3, transition:"EaseOutSine" } );
				
				_ROOT_OBJECT.locked = true;
			}
		}
		
		public function closePhoto() 
		{
			Tweener.addTween(this, {
				rotation:_RESTORE_R, 
				x:_RESTORE_X, 
				y:_RESTORE_Y, 
				scaleX:1, 
				scaleY:1, 
				time:0.3, 
				transition:"EaseOutSine",
				onComplete:endClosePhoto} );
		}
		
		private function endClosePhoto()
		{
			_OPENED = false;
			_ROOT_OBJECT._OPENED_ITEM = null;
			_ROOT_OBJECT.locked = false;
		}
		
		private function addListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true)
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true)
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			
			this.addEventListener(MouseEvent.ROLL_OUT, mouseRollOutHandler, false, 0, true)
			this.addEventListener(Event.ENTER_FRAME, enterframeHandler, false, 0, true)
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler, false, 0, true)
		}
		
		private function removedFromStageHandler(e:Event):void 
		{
			timer = NaN;
			
			_ROOT_OBJECT = null;
			
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.removeEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			StageReference.getStage().removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
			this.removeEventListener(MouseEvent.ROLL_OUT, mouseRollOutHandler);
			this.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			
			destroy()
		}
		
		private function doubleClickHandler(e:MouseEvent):void 
		{
			trace ("TouchGalleryItem ::: doubleClickHandler"); 
		}
		
		private function mouseUpHandler(e:MouseEvent):void 
		{
			//this.removeEventListener(Event.ENTER_FRAME, enterframeHandler);
			
			///_ROOT_OBJECT.reactivateOtherItems(this)
			
			this.modo = 2;
			this.modo_time = 2;
			
			if (!_OPENED) 
			{
				Size.ToXYScale(this, 1);
			}
		}
		
		private function mouseRollOutHandler(e:MouseEvent):void 
		{
			if (!_OPENED) 
			{
				Size.ToXYScale(this, 1);
			}
		}
		
		private function mouseDownHandler(e:MouseEvent):void 
		{
			_ROOT_OBJECT.closeAnyOpenItem()
			
			///_ROOT_OBJECT.deactivateOtherItems(this)
			
			//this.addEventListener(Event.ENTER_FRAME, enterframeHandler, false, 0, true);
			
			if (!_OPENED)
			{
				this.modo = 1;
				this.modo_time = 1;
				
				var thisindex:uint    = _ROOT_OBJECT.getChildIndex(this);
				var highestindex:uint = _ROOT_OBJECT.numChildren - 1;
				
				if (thisindex != highestindex)
				{
					_ROOT_OBJECT.setChildIndex(this, _ROOT_OBJECT.numChildren - 1)
				}
				
				///Size.ToXYScale(this, 1.3, 0.3); // isto aumenta o tamanho da imagem quando se pega nela
				
				_ROOT_OBJECT._LAST_DRAGGED = this;
			}
			
			if (!_ROOT_OBJECT.click) 
			{		
				/// trace("first click")
				
				timer = getTimer() / 1000;
				
				_ROOT_OBJECT.click = true;
			} 
			else 
			{	
				var timer2:Number = getTimer() / 1000;
				
				if ((timer2 - timer) < .35) 
				{
					/// trace("double click")
					
					if (!_OPENED) 
					{
						openItem();
						
						_OPENED = true;
					} 
					else if (_OPENED) 
					{
						closePhoto();
						_ROOT_OBJECT.locked = false;
						_ROOT_OBJECT.click = false;
					}
				}
				else 
				{
					timer = getTimer() / 1000;
					
					_ROOT_OBJECT.click = true;
				}
			}
			
		}
		
		/// se o lock for false e o last_dragged for null -> executa
		/// se o lock for false e o last dragged = this -> executa
		
		private function enterframeHandler(e:Event):void 
		{
			//trace ("TouchGalleryItem ::: modo = " + modo ); 
			
			if (!_OPENED) 
			{
				if (_ROOT_OBJECT.locked != true && _ROOT_OBJECT._LAST_DRAGGED == this || _ROOT_OBJECT.locked != true && _ROOT_OBJECT._LAST_DRAGGED == null)
				{
					if (modo != 0) 
					{
						if (modo == 1)
						{
							//if (HitTest.MouseHitObject(this, StageReference.getStage()) == true)
							if (StageReference.getStage().mouseX < 820)
							{
								if (modo_time == 1)
								{
									modo_time = 0;
									mxx = StageReference.getStage().mouseX;
									my  = StageReference.getStage().mouseY;
									mx0 = mxx;
									my0 = my;
									dmx = mxx-mx0;
									dmy = my-my0;
								} 
								else 
								{
									mxx = (StageReference.getStage().mouseX + mxx) / 2;
									my  = (StageReference.getStage().mouseY + my)  / 2;
									dmx = mxx-mx0;
									dmy = my-my0;
									mx0 = mxx;
									my0 = my;
								}   
								
								fx  = (dmx - vx) * m;
								fy  = (dmy - vy) * m;
								ldx = mxx - inx;
								ldy = my - iny;
								
								if (fx == 0) 
								{
									mlength = ldx;
									mforce  = fy;
									torque  = mforce*mlength;
								} 
								else if (fy == 0) 
								{
									mlength = ldy;
									mforce  = fx;
									torque  = -(mforce)*mlength;
								} 
								else 
								{
									k       = fy / fx;
									kx      = ( -(k) * k * ldx + k * ldy) / ( -(k) * k - 1);
									ky      = k * (kx - ldx) + ldy;
									mlength = Math.sqrt(kx * kx + ky * ky);
									mforce  = Math.sqrt(fx * fx + fy * fy);
									
									if (fx * ky > 0) 
									{
										torque = -(mforce) * mlength;
									}
									else 
									{
										torque = mforce * mlength;
									}
								}
								
								var cos:Number;
								var sin:Number;
								
								vx   = dmx;
								vy   = dmy;
								inx  += vx;
								iny  += vy;
								vr   = vr-torque/inercia;
								ldx  = mxx-inx;
								ldy  = my-iny;
								cos  = Math.cos(vr/180*Math.PI);
								sin  = Math.sin(vr/180*Math.PI);
								addx = ldx*cos+ldy*sin-ldx;
								addy = -(ldx)*sin+ldy*cos-ldy;
								inx  += -(addx);
								iny  += -(addy);
							}
							else
							{
								mouseUpHandler(new MouseEvent(MouseEvent.MOUSE_UP))
							}
							
							
						}
						else if (modo == 2) 
						{
							if (modo_time == 1) 
							{
								modo_time = 0;
								vx = vx-(addx);
								vy = vy-(addy);
							}
							
							torque = 0;
							addx = 0;
							addy = 0;
							inx += vx;
							iny += vy;
						}
						
						_rotation_var -= vr;
						
						this.rotation = _rotation_var;
					}
					
					if (inx < 0) 
					{
						inx = 0;
					}
					if (inx > _ROOT_OBJECT.HORIZONTAL_SIZE) 
					{
						inx = _ROOT_OBJECT.HORIZONTAL_SIZE;
					}
					if (iny > _ROOT_OBJECT.VERTICAL_SIZE) 
					{
						iny = _ROOT_OBJECT.VERTICAL_SIZE;
					}
					if (iny < 0) 
					{
						iny = 0;
					}
					
					/// position
					
					this.x = inx;
					this.y = iny;
					
					vx = vx / _friction;
					vy = vy / _friction;
					vr = vr / _friction;
				}
			}
		}
	}	
}