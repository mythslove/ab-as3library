package com.ab.ui 
{
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*/
	
	import caurina.transitions.properties.ColorShortcuts;
	import com.ab.display.ABSprite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System
	//import com.ab.utils.DebugTF
	import com.ab.utils.Move
	import caurina.transitions.Tweener
	import org.casalib.util.StageReference
	import flash.display.Stage
	
	public class YScroller extends ABSprite
	{
		/// physical content
		private var _handle:Sprite
		private var _scrooltrack:Sprite
		/// colours
		private var _handle_colour:uint=0xCCCCCC;
		private var _scrooltrack_colour:uint=0x222222;
		/// setup vars - main
		private var _target_clip:Object;				/// target object
		private var _scrool_distance:Number;     		/// handle total work height
		private var _visible_height:Number;      		/// target object's visible height (masked area)
		
		/// setup vars - design
		private var _handle_width:Number	   = 16;	/// handle width
		private var _handle_height:Number      = 20;	/// handle height
		private var _scrooltrack_width:Number  = 20;   	/// later
		private var _scrooltrack_height:Number = 100; 	/// later
		
		/// work vars level 1
		private var _target_final_Y:Number;
		private var _percent_position:Number;
		private var _handle_minimum_y:Number = 0;
		private var _handle_maximum_y:Number;
		
		/// work vars level 2
		private var rectangle:Rectangle;
		private var _hit_root:Object = null;
		private var indent:Number;
		private var _HIT_ROOT:Object=null;
		
		//public function YScroller(target_clip:Object, scroll_distance:Number, visible_height:Number, hit_root:Object=null)
		public function YScroller()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			buildGraphics();
			
			setInteractions()
			
			start();
		}
		
		private function buildGraphics():void
		{
			_handle 	 = new Sprite();
			_scrooltrack = new Sprite();
			
			_handle.graphics.beginFill(_handle_colour)
			_handle.graphics.drawRect(0, 0, _handle_width, _handle_height);
			_handle.graphics.endFill();
			
			_scrooltrack.graphics.beginFill(_scrooltrack_colour)
			_scrooltrack.graphics.drawRect(0, 0, _scrooltrack_width, _scrooltrack_height);
			_scrooltrack.graphics.endFill();
			
			var _handle_indent:Number = (_scrooltrack_width - _handle_width) / 2;   
			
			_handle.x = _handle_indent;
			_handle.y = _handle_indent;
			
			_handle_minimum_y = _handle_indent;
			_handle_maximum_y = _scrooltrack_height - _handle_indent - _handle_height;
			
			
			
			this.addChild(_scrooltrack);
			this.addChild(_handle);
		}
		
		private function setInteractions():void
		{
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP,    releaseHandle);
			StageReference.getStage().addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
			
			_handle.buttonMode = true;
		}
		
		public function start():void
		{
			///_scrooltrack_height 	= _scrool_distance;
			
			_handle_maximum_y 		= _scrooltrack_height - this.height; // maximo y da scroll handle
			_scrooltrack_height 	= _scrooltrack_height - this.height; // altura total de movimento da scroll handle
			
			_handle_minimum_y 		= this.y;
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function mouseWheelHandler(event:MouseEvent):void 
		{
			var go:Boolean = false;
			
			if (_HIT_ROOT != null)
			{
				if (_HIT_ROOT.hitTestPoint(StageReference.getStage().mouseX, StageReference.getStage().mouseY, true));
				{
					performMouseWheel(event.delta);
				}
			}
			else
			{
				performMouseWheel(event.delta);
			}
		}
		
		private function performMouseWheel(_DELTA:Number):void
		{
			if (_DELTA < 0) 
			{
				if (this.y < _scrooltrack_height);
				{
					this.y -= (_DELTA * 2);
					
					if (this.y > _scrooltrack_height)
					{
						this.y = _scrooltrack_height;
					}
				}
			} 
			else 
			{
				if (this.y > _handle_minimum_y) 
				{
					this.y -= (_DELTA * 2);
					
					if (this.y < _handle_minimum_y) 
					{
						this.y = _handle_minimum_y;
					}
				}
			}
		}
		
		public function deActivate():void
		{
			_handle.buttonMode = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_handle.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandle);
		}
		
		public function reActivate():void
		{
			_handle.buttonMode = true;
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			_handle.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle);
		}
		
		private function clickHandle(e:MouseEvent) 
		{
			trace ("YScroller ::: clickHandle"); 
			
			rectangle = new Rectangle(this.x, _handle_minimum_y, 0, _scrooltrack_height);
			_handle.startDrag(false, rectangle	);
		}
		
		private function releaseHandle(e:MouseEvent)  	{ _handle.stopDrag();   }
		private function enterFrameHandler(e:Event) 	{ positionContent(); }
		public  function gotoZero():void 				{ Move.ToPositionY(_handle, _handle_minimum_y, 0.2) }
		
		private function positionContent():void
		{
			var downY:Number;
			var curY:Number;
			
			indent 						= _handle_maximum_y - _handle_minimum_y;
			//_percent_position			= (100 / indent) * (_handle.y - _handle_minimum_y);
			_percent_position			= ( ( _handle.y - _handle_minimum_y ) * indent) / 100;
			
			//downY 						= _target_clip.height - (_visible_height / 2);
			//_target_final_Y 			= _percent_position * ((downY - (_visible_height / 2)) / 100); 
			/*
			//trace ("YScroller ::: indent = " 			+ indent ); 
			trace ("YScroller ::: _percent_position = " + _percent_position ); 
			trace ("YScroller ::: _target_maximum_y = " + _target_maximum_y ); 
			trace ("YScroller ::: downY             = " + downY ); 
			trace ("YScroller ::: _target_clip.y    = "	+ _target_clip.y ); 
			
			var final_value:Number 		= _target_clip.y;
			
			/*
			if (_target_clip.y != _target_final_Y) 
			{
				var diff:Number = _target_final_Y - _target_clip.y;
				
				final_value += diff / 4;
			}*/
			
			//_target_clip.y = Math.floor(final_value)
		}	
		
		public function get target_clip():Object 					{ return _target_clip; 			};
		public function set target_clip(value:Object):void  		{ _target_clip = value; 		};
		
		public function get scroll_distance():Number 				{ return _scrool_distance; 		};
		public function set scroll_distance(value:Number):void  	{ _scrool_distance = value; 	};
		
		public function get visible_height():Number 				{ return _visible_height; 		};
		public function set visible_height(value:Number):void  		{ _visible_height = value; 		};
		
		public function get handle_height():Number 					{ return _handle_height; 		};
		public function set handle_height(value:Number):void  		{ _handle_height = value; 		};
		
		public function get handle_width():Number 					{ return _handle_width; 		};
		public function set handle_width(value:Number):void  		{ _handle_width = value; 		};
		
		public function get scrooltrack_height():Number 			{ return _scrooltrack_height; 	};
		public function set scrooltrack_height(value:Number):void  	{ _scrooltrack_height = value; 	};
		
		public function get handle_colour():uint 					{ return _handle_colour; 		};
		public function set handle_colour(value:uint):void  		{ _handle_colour = value; 		};
		
		public function get scrooltrack_colour():uint 				{ return _scrooltrack_colour; 	};
		public function set scrooltrack_colour(value:uint):void  	{ _scrooltrack_colour = value; 	};
	}
}