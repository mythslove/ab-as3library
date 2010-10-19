package com.edigma.ui.buttons
{
	
	/**
	* 
	* 	@author ABº
	* 
	* 	@USAGE:
	* 
	* 	// create buttons and provide displayobjects for active and inactive states
	*   var button1:TwoStateSwitchButton = new TwoStateSwitchButton(active_display_object1, inactive_display_object1);
	*   var button2:TwoStateSwitchButton = new TwoStateSwitchButton(active_display_object2, inactive_display_object2);
	*   
	* 	// adding to stage may be done after
	*   addChild(button1);
	*   addChild(button2);
	*   
	* 	// set handler functions
	*   button1.setClickFunction(button1_clickHandler);
	*   button2.setClickFunction(button2_clickHandler);
	*   
	* 	// optional: define groups (there is also a function to remove from group)
	*   button1.setGroup("some_group");
	*   button2.setGroup("some_group");
	*   
	* 	// optional: turn off on click outside and choose optional exception displayobject (example: menu contents)
	*   button1.setOFFonClickOutside(stage_reference, exception_displayobject, outsideClickHandler)
	*   button2.setOFFonClickOutside(stage_reference, exception_displayobject, outsideClickHandler)
	*   
	*   // optional: add button extra object (example: textfield nested in a movieclip): active / inactive colors are optional
	*   button1.addExtraObject(extra_object, 0x000FF0, 0x0FF000)
	*   button2.addExtraObject(extra_object2, 0x000FF0, 0x0FF000)
	*   
	* 	// usually necessary when using the extra object - place the extra object in desired coordinates
	*   extra_object.x  = (choose coordinates);
	*   extra_object2.x = (choose coordinates);
	* 
	* 	----------------------------------------
	* 
	* 	Dependencies:
	* 
	* 	com.edigma.events.CentralEventSystem;
	* 	com.edigma.events.CustomMouseEvent;
	* 	caurina.transitions.Tweener
	*/  
	
	/// flash
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	
	/// edigma
	import com.edigma.events.CentralEventSystem;
	import com.edigma.events.CustomMouseEvent;
	
	/// other libraries
	import caurina.transitions.Tweener;
	
	public class TwoStateSwitchButton extends MovieClip
	{
		/// config vars
		private var _state:String 				= "inactive";
		private var _FUNCTION_TO_EXECUTE_ON_CLICK:Function;
		
		/// xtra options settings
		private var _transition_time:Number 	 				= 0.3;
		private var _OnClickOutside_stage:Stage				= null;
		private var _OnClickOutside_object:* 				= null;
		private var _using_OnClickOutside:Boolean 			= false;
		private var _using_extraobject_colorChange:Boolean	= false;
		private var _extraobject_displayobject_activecolor:uint;
		private var _extraobject_displayobject_inactivecolor:uint;
		private var _function_to_execute_on_clickOutside;
		
		/// group options
		private var _group_mode:Boolean 			= false;
		private var _group_delay:Number 			= 0.8;
		private var _group_name:String  			= "";
		private var _standby:Boolean 				= false;
		
		/// visual settings
		private var _extraobject_displayobject:* 	= null;
		private var _active_state_displayobject:* 	= null;
		private var _inactive_state_displayobject:* = null;
		
		/// aux var
		public var aux_var:Number = 0;
		
		
		public function TwoStateSwitchButton(active_mc:DisplayObject, inactive_mc:DisplayObject)
		{
			this.addChildAt(inactive_mc, 0);
			this.addChildAt(active_mc,   1);
			
			active_state_displayobject   = active_mc;
			inactive_state_displayobject = inactive_mc;
			
			sys();
			
			setInteractions();
		}
		
		private function sys():void
		{
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedHandler, false, 0, true);
		}
		
		private function setInteractions():void
		{
			this.addEventListener(MouseEvent.CLICK, this.clickHandler, false, 0, true);
			
			this.buttonMode 	= true;
			this.mouseChildren 	= false;
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			if (_standby != true) 
			{
				if (group_mode == true && _state == "active") 
				{
					/// NOTHING (it's already active)
				}
				else
				{
					if (_state == "inactive")  
					{ 
						getActive(); 
					} 
					else 
					{
						getInactive(); 
					}
					
					if (_FUNCTION_TO_EXECUTE_ON_CLICK != null)  { _FUNCTION_TO_EXECUTE_ON_CLICK(); }
					
					if (group_mode == true) 
					{
						var clickinfo:Object 	= new Object();
						clickinfo.group 		= _group_name;
						clickinfo.caller 		= this;
						
						CentralEventSystem.singleton.dispatchEvent(new CustomMouseEvent(CustomMouseEvent.CLICK, clickinfo));
					}
					
					_standby = true;
					
					// make time and reactivate (prevent click abuse)
					aux_var  = 0;
					Tweener.addTween(this, { aux_var:1, time:_group_delay, onComplete:reactivate} );
				}
			}
		}
		
		public function setClickFunction(f:Function):void 		{ _FUNCTION_TO_EXECUTE_ON_CLICK = f; }
		
		public function removeClickFunction():void 				{ _FUNCTION_TO_EXECUTE_ON_CLICK = null; }
		
		public function addExtraObject(object:*, active_color:uint=undefined, inactive_color:uint=undefined):void 
		{
			_extraobject_displayobject = object;
			
			this.addChildAt(object, 2);
			
			if (active_color && inactive_color)
			{
				setExtraObjectColorChange(active_color, inactive_color)
			}
		}
		
		public function setExtraObjectColorChange(active_color:uint, inactive_color:uint):void 
		{
			_using_extraobject_colorChange = true;
			
			//_extraobject_displayobject 					= object;
			_extraobject_displayobject_activecolor 		= active_color;
			_extraobject_displayobject_inactivecolor 	= inactive_color;
		}
		
		public function removeExtraObjectColorChange():void 
		{
			_using_extraobject_colorChange 				= false;
			
			//_extraobject_displayobject					= null;
			_extraobject_displayobject_activecolor 		= 0x00FF00;
			_extraobject_displayobject_inactivecolor 	= 0x000000;
		}
		
		public function setOFFonClickOutside(s:Stage, exception_displayobject:DisplayObject=null, func:Function=null):void 
		{
			if (s == null) 
			{
				trace("TwoStateSwitchButton ::: setOFFonClickOutside() ::: ERROR ::: stage reference must be providede"); 
			}
			else
			{
				if (_using_OnClickOutside == false) 
				{
					_using_OnClickOutside 	= true;
					
					_OnClickOutside_stage 	= s;
					_OnClickOutside_object  = exception_displayobject;
					
					_OnClickOutside_stage.addEventListener(MouseEvent.CLICK, stageClickHandler);
					
					if (func != null) 
					{
						_function_to_execute_on_clickOutside = func;
					}
				}			
			}
		}
		
		public function removeOFFonClickOutside():void 
		{
			if (_using_OnClickOutside == true) 
			{
				_using_OnClickOutside = false;
				
				_OnClickOutside_stage.removeEventListener(MouseEvent.CLICK, stageClickHandler);
				
				_OnClickOutside_stage  = null;
				_OnClickOutside_object = null;
			}
		}
		
		private function stageClickHandler(e:MouseEvent):void 
		{
			if (_OnClickOutside_object != null) 
			{
				if (this.hitTestPoint(_OnClickOutside_stage.mouseX, _OnClickOutside_stage.mouseY, true) == false && _OnClickOutside_object.hitTestPoint(_OnClickOutside_stage.mouseX, _OnClickOutside_stage.mouseY, true) == false && _state == "active")
				{
					//_OnClickOutside_object.clickOutside();
					
					_function_to_execute_on_clickOutside();
					
					getInactive();
				}
			}
			else
			{
				if (this.hitTestPoint(_OnClickOutside_stage.mouseX, _OnClickOutside_stage.mouseY, true) == false && _state == "active")
				{
					getInactive();
				}
			}
		}
		
		public function startActive():void { getActive(); };
		
		public function setGroup(groupname:String=null):void
		{
			if (groupname == null || groupname == "") 
			{
				trace("TwoStateSwitchButton ::: ERROR ::: PLEASE DEFINE A GROUP NAME");
			}
			else
			{
				_group_name = groupname;
				
				group_mode  = true;
				
				CentralEventSystem.singleton.addEventListener(CustomMouseEvent.CLICK, externalClickListener, false, 0, true);
			}
		}
		
		public function unGroup():void
		{
			_group_name = "";
			
			group_mode  = false;
			
			CentralEventSystem.singleton.removeEventListener(CustomMouseEvent.CLICK, externalClickListener);
		}
		
		private function externalClickListener(e:CustomMouseEvent):void 
		{
			if (e.data.group == this._group_name) 
			{
				if (e.data.caller != this && _state == "active")
				{
					getInactive();
					
					_standby = true;
					
					// make time and reactivate (prevent click abuse)
					aux_var  = 0;
					Tweener.addTween(this, { aux_var:1, time:_group_delay, onComplete:reactivate } );
				}
			}
		}
		
		private function reactivate():void
		{
			_standby = false;
		}
		
		private function switchState():void 
		{
			if (_active_state_displayobject != null && _inactive_state_displayobject != null) 
			{
				switch (_state) 
				{
					case "inactive": 	getActive(); 	break;
					
					case "active": 		getInactive(); 	break;
				}	
			}
		}
		
		public function getInactive():void
		{
			_state = "inactive";
			
			//_inactive_state_displayobject.alpha   = 0;
			//_inactive_state_displayobject.visible = true;
			
			//Tweener.addTween(_inactive_state_displayobject, { alpha:1, time:transition_time, transition:"EaseOutSine" } );
			Tweener.addTween(_active_state_displayobject,   { alpha:0, time:transition_time, transition:"EaseOutSine", onComplete:function() { _active_state_displayobject.visible = false }} );
			
			if (_using_extraobject_colorChange == true) 
			{
				Tweener.addTween(_extraobject_displayobject, { _color:_extraobject_displayobject_inactivecolor, time:transition_time, transition:"Linear"} );
			}
		}
		
		public function getActive():void
		{
			_state = "active";
			
			_active_state_displayobject.alpha 	= 0;
			_active_state_displayobject.visible = true;
			
			Tweener.addTween(_active_state_displayobject,   { alpha:1, time:transition_time, transition:"EaseOutSine" } );
			//Tweener.addTween(_inactive_state_displayobject, { alpha:0, time:transition_time, transition:"EaseOutSine", onComplete:function() { _inactive_state_displayobject.visible = false }} );
			
			if (_using_extraobject_colorChange == true) 
			{
				Tweener.addTween(_extraobject_displayobject, { _color:_extraobject_displayobject_activecolor, time:transition_time, transition:"Linear"} );
			}
		}
		
		/// getters / setters
		
		public function get state():String 				{ return _state;  }
		public function set state(value:String):void  	{ _state = value; }
		
		/// setters
		
		public function set active_state_displayobject(value:*):void  
		{
			_active_state_displayobject 			= value; 
			_active_state_displayobject.alpha 		= 0;
			_active_state_displayobject.visible 	= false;
		}
		
		public function set inactive_state_displayobject(value:*):void 	
		{ 
			_inactive_state_displayobject   		= value;  
			_inactive_state_displayobject.alpha 	= 1;
			_inactive_state_displayobject.visible 	= true;
		}
		
		public function get group_mode():Boolean 				{ return _group_mode;   };
		public function set group_mode(value:Boolean):void  	{ _group_mode = value;  };
		
		public function get group_delay():Number 				{ return _group_delay;  };
		public function set group_delay(value:Number):void  	{ _group_delay = value; };
		
		public function get standby():Boolean 					{ return _standby; 		};
		public function set standby(value:Boolean):void  		{ _standby = value; 	};
		
		public function get transition_time():Number 			{ return _transition_time;  };
		public function set transition_time(value:Number):void  { _transition_time = value; };
		
		/// /// sys
		
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, switchState);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
			
			if (_using_OnClickOutside == true) 
			{
				_using_OnClickOutside = false;
				
				_OnClickOutside_stage.removeEventListener(MouseEvent.CLICK, stageClickHandler);
				
				_OnClickOutside_stage	= null;
				_OnClickOutside_object = null;
			}
		}
		
	}
	
}