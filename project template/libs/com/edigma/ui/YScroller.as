package com.edigma.ui 
{
	/**
	* @author ABº
	*/
	
	import com.edigma.log.Logger;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	//import com.ab.utils.DebugTF
	import caurina.transitions.Tweener;
	import org.casalib.util.StageReference;
	import flash.display.Stage;
	
	public class YScroller extends Sprite
	{
		/// physical content
		private var _handle:Sprite
		private var _scrooltrack:Sprite
		
		/// colours
		private var _handle_colour:uint        = 0xCCCCCC;
		private var _scrooltrack_colour:uint   = 0x222222;
		
		/// setup vars - main
		private var _target_clip:Object;				/// target object
		private var _scrool_distance:Number;     		/// handle total work height
		private var _visible_height:Number;      		/// target object's visible height (masked area)
		private var _frame_length:Number;      			/// target object's visible height (masked area)
		
		/// setup vars - design
		private var _handle_width:Number	   = 10;
		private var _handle_height:Number      = 20;
		private var _scrooltrack_width:Number  = 20;
		private var _scrooltrack_height:Number = 100;
		private var _scrooltrack_alpha:Number  = 1;
		private var _handle_alpha:Number  	   = 1;
		
		/// work vars level 1
		private var _target_final_Y:Number;
		private var _handle_percent_position:Number;
		private var _handle_minimum_y:Number = 0;
		private var _handle_maximum_y:Number;
		
		/// work vars level 2
		private var rectangle:Rectangle;
		private var indent:Number;
		private var _hit_root:Object=null;
		private var _scrooltrack100percentPosition:Number;
		private var _target_finalY:Number;
		
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
		
		/// GETTERS / SETTERS
		
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
		
		public function get frame_length():Number 					{ return _frame_length; 		};
		public function set frame_length(value:Number):void  		{ _frame_length = value; 		};
		
		public function get scrooltrack_alpha():Number 				{ return _scrooltrack_alpha; 	};
		public function set scrooltrack_alpha(value:Number):void  	{ _scrooltrack_alpha = value; 	};
		
		public function get handle_alpha():Number 					{ return _handle_alpha; 		};
		public function set handle_alpha(value:Number):void  		{ _handle_alpha = value; 		};
		
		public function get hit_root():Object 						{ return _hit_root; 			};
		public function set hit_root(value:Object):void  			{ _hit_root = value; 			};
		
		private function buildGraphics():void
		{
			_handle 	 = new Sprite();
			_scrooltrack = new Sprite();
			
			/// handle
			_handle.graphics.beginFill(_handle_colour);
			_handle.graphics.drawRect(0, 0, _handle_width, _handle_height);
			_handle.graphics.endFill();
			
			_handle.x = _frame_length;
			_handle.y = _frame_length;
			
			/// scrooltrack
			_scrooltrack.graphics.beginFill(_scrooltrack_colour)
			_scrooltrack.graphics.drawRect(0, 0, _scrooltrack_width, _visible_height);
			_scrooltrack.graphics.endFill();			
			
			_scrooltrack.alpha 	= _scrooltrack_alpha;
			_handle.alpha 		= _handle_alpha;
			
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
			_handle_minimum_y = _frame_length;
			_handle_maximum_y = _scrool_distance - _handle_height;// - _frame_length * 2;
			
			_handle_minimum_y = _handle.y;
			
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		public function mouseWheelHandler(event:MouseEvent):void 
		{
			if (_hit_root != null)
			{
				/*
				if (_hit_root.hitTestPoint(StageReference.getStage().mouseX, StageReference.getStage().mouseY, true));
				{
					performMouseWheel(event.delta);
				}*/
			}
			else
			{
				performMouseWheel(event.delta);
			}
		}
		
		private function performMouseWheel(_DELTA:Number):void
		{
			var target_y:Number;
			
			if (_DELTA < 0) 
			{
				if (_handle.y < _handle_maximum_y + _frame_length)
				{
					target_y = _handle.y - _DELTA * 16
					
					if (target_y > _handle_maximum_y + _frame_length) 
					{
						target_y = _handle_maximum_y + _frame_length
					}
					
					Tweener.addTween(_handle, { y:target_y, time:0.2, transition:"EaseOutSine"} );	
				}
			}
			else 
			{
				if (_handle.y > _handle_minimum_y + 1)
				{
					target_y = _handle.y - _DELTA * 16
					
					if (target_y < _handle_minimum_y)
					{
						target_y = _handle_minimum_y;
					}
					
					Tweener.addTween(_handle, { y:target_y, time:0.2, transition:"EaseOutSine"} );
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
		
		private function clickHandle(e:MouseEvent):void
		{
			rectangle = new Rectangle(_frame_length, _handle_minimum_y, 0, _handle_maximum_y);
			_handle.startDrag(false, rectangle	);
		}
		
		private function releaseHandle(e:MouseEvent):void 	{ _handle.stopDrag(); };
		private function enterFrameHandler(e:Event):void 	{ positionContent();  };
		public  function gotoZero():void 				{ Tweener.addTween(_handle, { y:_handle_minimum_y, time:0.2 } ); }
		
		private function positionContent():void
		{
			var _handle_relative_pos:Number = _handle.y - _handle_minimum_y;
			var _distance:Number     = _scrool_distance - _handle.height;
			
			_handle_percent_position = Math.floor( ( _handle_relative_pos * 100) / _distance); 
			
			var work_height:Number = ( -_target_clip.height + _scrool_distance + _frame_length)
			
			var ref_num:Number = (work_height * _handle_percent_position) / 100
			
			ref_num = ref_num - _frame_length;;
			
			_target_finalY = (ref_num * _handle_percent_position) / 100;
			
			_target_finalY = _target_finalY + _frame_length;
			
			Tweener.addTween(_target_clip, { y:_target_finalY, time:0.3, transition:"EaseOutSine" } );
		}
	}
}