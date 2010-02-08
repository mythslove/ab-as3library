package com.ab.ui.buttons
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/// ab
	import com.ab.utils.Make;
	import com.ab.events.CustomMouseEvent;
	
	public class TwoStateSwitchButton extends Sprite
	{
		/// config vars
		private var _state:String 		= "up";
		private var _group_mode:Boolean = false;
		private var _group_name:String  = "";
		
		private var _down_state_displayobject:* = null;
		private var _up_state_displayobject:*   = null;
		
		public function TwoStateSwitchButton() 
		{
			trace ("TwoStateSwitchButton :::");
			
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
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			switchState();
		}
		
		public function setGroup(groupname:String=null):void
		{
			if (_group_name == null) 
			{
				trace("TwoStateSwitchButton ::: PLEASE DEFINE A GROUP NAME");
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
			}
		}
		
		private function switchState():void 
		{
			if (_down_state_displayobject != null && _up_state_displayobject != null) 
			{
				switch (_state) 
				{
					case "up":
						
						getDown();
						
						if (group_mode == true) 
						{
							var clickinfo:Object 	= new Object();
							clickinfo.group 		= _group_name;
							clickinfo.caller 		= this;
							
							CentralEventSystem.singleton.dispatchEvent(new CustomMouseEvent(CustomMouseEvent.CLICK, clickinfo));
						}
						
					break;
					
					case "down":
						getUp();
					break;
				}	
			}
		}
		
		private function getUp():void
		{
			_state = "up";
			
			Make.MCInvisible(_down_state_displayobject, 0.3);
			Make.MCVisible(_up_state_displayobject, 	0.3);
		}
		
		private function getDown():void
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
		
		public function get group_mode():Boolean 			{ return _group_mode;  };
		public function set group_mode(value:Boolean):void  { _group_mode = value; };
		
		/// /// sys
		
		private function removedHandler(e:Event):void 
		{
			this.removeEventListener(MouseEvent.CLICK, switchState);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedHandler);
		}
		
	}
	
}