package com.ab.ui.buttons
{
	/**
	* @author ABº
	*/
	
	/// flash
	import caurina.transitions.Tweener;
	import com.ab.utils.HitTest;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	
	/// ab
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.utils.Make;
	import com.ab.events.CustomMouseEvent;
	// text
	public class TwoStateSwitchButton extends MovieClip
	{
		/// config vars
		public var _state:String 				= "inactive";
		private var _FUNCTION_TO_EXECUTE_ON_CLICK:Function;
		
		/// xtra options settings
		public var transition_time:Number 	 				= 0.3;
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
		
		
		public function TwoStateSwitchButton() 
		{
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
					/// FUCKING NADA
				}
				else
				{
					if (_state == "inactive")  { getActive(); } else { getInactive(); }
					
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
		
		public function setExtraObjectColorChange(object:*, active_color:uint, inactive_color:uint):void 
		{
			_using_extraobject_colorChange = true;
			
			_extraobject_displayobject 					= object;
			_extraobject_displayobject_activecolor 		= active_color;
			_extraobject_displayobject_inactivecolor 	= inactive_color;
		}
		
		public function removeExtraObjectColorChange():void 
		{
			_using_extraobject_colorChange 				= false;
			
			_extraobject_displayobject					= null;
			_extraobject_displayobject_activecolor 		= 0x00FF00;
			_extraobject_displayobject_inactivecolor 	= 0x000000;
		}
		
		public function setOFFonClickOutside(s:Stage, d:*=null, func:Function=null):void 
		{
			//if (d == null) 
			//{
				//trace ("TwoStateSwitchButton ::: setOFFonClickOutside() ::: ERROR ::: object is null "); 
			//}
			//else
			//{
				if (s == null) 
				{
					trace ("TwoStateSwitchButton ::: setOFFonClickOutside() ::: ERROR ::: stage reference must be providede"); 
				}
				else
				{
					if (_using_OnClickOutside == false) 
					{
						_OnClickOutside_stage 	= s;
						_OnClickOutside_object  = d;
						
						_using_OnClickOutside 	= true;
						
						_OnClickOutside_stage.addEventListener(MouseEvent.CLICK, stageClickHandler);
						
						if (func != null) 
						{
							_function_to_execute_on_clickOutside = func;
						}
					}			
				}
			//}
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
			if (_standby != true)
			{
				if (_OnClickOutside_object != null) 
				{
					if (HitTest.MouseHitObject(this, _OnClickOutside_stage) != true && HitTest.MouseHitObject(_OnClickOutside_object, _OnClickOutside_stage) != true && _state == "active") 
					{
						//_OnClickOutside_object.clickOutside();
						
						_function_to_execute_on_clickOutside();
						
						clickHandler(new MouseEvent(MouseEvent.CLICK));
					}
				}
				else
				{
					if (HitTest.MouseHitObject(this, _OnClickOutside_stage) != true && _state == "active") 
					{
						clickHandler(new MouseEvent(MouseEvent.CLICK));
					}
				}
			}
		}
		
		public function startActive():void { getActive(); }
		
		public function setGroup(groupname:String=null):void
		{
			if (_group_name == null) 
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
				if (e.data.caller != this)
				{
					getInactive();
				}
				
				_standby = true;
				
				// make time and reactivate (prevent click abuse)
				aux_var  = 0;
				Tweener.addTween(this, { aux_var:1, time:_group_delay, onComplete:reactivate } );
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
					case "inactive":
						getActive();
					break;
					
					case "active":
						getInactive();
					break;
				}	
			}
		}
		
		public function getInactive():void
		{
			_state = "inactive";
			
			Make.MCInvisible(_active_state_displayobject, transition_time);
			//Make.MCVisible(_inactive_state_displayobject, 	transition_time);
			
			if (_using_extraobject_colorChange == true) 
			{
				Tweener.addTween(_extraobject_displayobject, { _color:_extraobject_displayobject_inactivecolor, time:transition_time, transition:"Linear"} );
			}
		}
		
		public function getActive():void
		{
			_state = "active";
			
			Make.MCVisible(_active_state_displayobject, 	transition_time);
			//Make.MCInvisible(_inactive_state_displayobject, 	transition_time);
			
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
		
		public function get standby():Boolean 					{ return _standby; }
		public function set standby(value:Boolean):void  		{ _standby = value; }
		
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