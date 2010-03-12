package com.ab.ui.buttons
{
	/**
	* @author ABº
	*/
	
	/// flash
	import com.ab.utils.HitTest;
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
	
	public class TwoStateSwitchButton extends Sprite
	{
		/// config vars
		private var _state:String 			= "up";
		private var _FUNCTION_TO_EXECUTE:Function;
		
		/// xtra options settings
		private var _OCO_stage:Stage;
		private var _OCO_object:*;
		
		/// group options
		private var _group_mode:Boolean 	= false;
		private var _group_delay:Number 	= 0.8;
		private var _group_name:String  	= "";
		private var _standby:Boolean 		= false;
		
		/// visual settings
		private var _down_state_displayobject:* = null;
		private var _up_state_displayobject:*   = null;
		private var _using_OCO:Boolean = false;;
		
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
				if (group_mode == true && _state == "down") 
				{
					/// FUCKING NADA
				}
				else
				{
					if (_state == "up")  { getDown(); } else { getUp(); }
					
					if (_FUNCTION_TO_EXECUTE != null)  { _FUNCTION_TO_EXECUTE(); }
					
					if (group_mode == true) 
					{
						var clickinfo:Object 	= new Object();
						clickinfo.group 		= _group_name;
						clickinfo.caller 		= this;
						
						CentralEventSystem.singleton.dispatchEvent(new CustomMouseEvent(CustomMouseEvent.CLICK, clickinfo));
					}
					
					_standby = true;
					
					Make.TimeAndExecuteFunction(_group_delay, reactivate);
				}
				
			}
			
		}
		
		public function setClickFunction(f:Function):void { _FUNCTION_TO_EXECUTE = f; }
		
		public function setOFFonClickOutside(d:*, s:Stage):void 
		{
			if (d == null) 
			{
				trace ("TwoStateSwitchButton ::: setOFFonClickOutside() ::: ERROR ::: object is null "); 
			}
			else
			{
				if (s == null) 
				{
					trace ("TwoStateSwitchButton ::: setOFFonClickOutside() ::: ERROR ::: stage is null "); 
				}
				else
				{
					if (_using_OCO == false) 
					{
						_OCO_stage 	= s;
						_OCO_object = d
						
						_using_OCO 	= true;
						
						_OCO_stage.addEventListener(MouseEvent.CLICK, stageClickHandler);
					}			
				}
			}
		}
		
		public function removeOFFonClickOutside():void 
		{
			if (_using_OCO == true) 
			{
				_using_OCO = false;
				
				_OCO_stage.removeEventListener(MouseEvent.CLICK, stageClickHandler);
				
				_OCO_stage 	= null;
				_OCO_object = null;
			}
		}
		
		private function stageClickHandler(e:MouseEvent):void 
		{
			if (_standby != true && HitTest.MouseHitObject(this, _OCO_stage) != true && HitTest.MouseHitObject(_OCO_object, _OCO_stage) != true && _state == "down")
			{
				_OCO_object.clickOutside();
				
				switchState();
			}
		}
		
		public function startDown():void { getDown(); }
		
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
		
		public function upGroup(groupname:String=null):void
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
					getUp();
				}
				
				_standby = true;
				
				Make.TimeAndExecuteFunction(_group_delay, reactivate);
			}
		}
		
		private function reactivate():void
		{
			_standby = false;
		}
		
		private function switchState():void 
		{
			if (_down_state_displayobject != null && _up_state_displayobject != null) 
			{
				switch (_state) 
				{
					case "up":
						getDown();
					break;
					
					case "down":
						getUp();
					break;
				}	
			}
		}
		
		public function getUp():void
		{
			_state = "up";
			
			Make.MCInvisible(_down_state_displayobject, 0.3);
			Make.MCVisible(_up_state_displayobject, 	0.3);
		}
		
		public function getDown():void
		{
			_state = "down";
			
			Make.MCVisible(_down_state_displayobject, 	0.3);
			Make.MCInvisible(_up_state_displayobject, 	0.3);
		}
		
		/// getters / setters
		
		public function get state():String 				{ return _state;  }
		public function set state(value:String):void  	{ _state = value; }
		
		/// setters
		
		public function set down_state_displayobject(value:*):void  
		{
			_down_state_displayobject 			= value; 
			_down_state_displayobject.alpha 	= 0;
			_down_state_displayobject.visible 	= false;
		}
		
		public function set up_state_displayobject(value:*):void 	
		{ 
			_up_state_displayobject   			= value;  
			_up_state_displayobject.alpha 		= 1;
			_up_state_displayobject.visible 	= true;
		}
		
		public function get group_mode():Boolean 				{ return _group_mode;   };
		public function set group_mode(value:Boolean):void  	{ _group_mode = value;  };
		
		public function get group_delay():Number 				{ return _group_delay;  };
		public function set group_delay(value:Number):void  	{ _group_delay = value; };
		
		/// /// sys
		
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, switchState);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
			
			if (_using_OCO == true) 
			{
				_using_OCO = false;
				
				_OCO_stage.removeEventListener(MouseEvent.CLICK, stageClickHandler);
				
				_OCO_stage	= null;
				_OCO_object = null;
			}
		}
		
	}
	
}