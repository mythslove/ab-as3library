package com.ab.ui 
{
	/**
	* ...
	* @author ABº
	* 
	*/
	
	import com.ab.as3websystem.core.Core
	import com.ab.as3websystem.core.system.Navigation
	
	
	import flash.display.MovieClip;
	import com.ab.utils.Make
	import com.ab.utils.Move
	import flash.display.Sprite;
	
	import flash.events.Event
	import flash.geom.Rectangle
	import flash.events.MouseEvent
	
	import com.ab.utils.DebugTF
	
	public class Slider extends MovieClip
	{
		public static var __singleton:Slider
		
		public var _OBSERVER:MovieClip
		public var mc:MovieClip
		public var init_x:Number
		
		public var _START_X:Number
		public var _MAX_X:Number
		private var rectangle:Rectangle;
		
		private var dragTarget:MovieClip;
		
		private var percent_do_slider:Number;
		private var new_x:Number;
		
		
		public function Slider() 
		{
			setSingleton()
			
			initVars()
			
			setInteraction()
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("Slider ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():Slider
		{
			if (__singleton == null)
			{
				throw new Error("Slider ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON END
		//////////////////////////////////////////////////////////////////////////////// SINGLETON END
		
		private function initVars():void
		{
			_START_X = mc.x
			_MAX_X = mc.x + 502
			
			rectangle = new Rectangle(mc.x, mc.y, 912, 0);
		}
		
		private function setInteraction():void
		{
			mc.buttonMode = true
			
			mc.addEventListener(MouseEvent.MOUSE_DOWN, drag);
			stage.addEventListener(MouseEvent.MOUSE_UP, drop);
		}
		
		private function drag(e:MouseEvent):void 
		{
			dragTarget = e.currentTarget as MovieClip;
			dragTarget.startDrag(false, rectangle);
			
			DebugTF.getSingleton().echo("MAIN MENU SLIDER PRESS")
			
			//DebugTF.getSingleton().echo(_OBSERVER.name)
		}
		
		private function drop(e:MouseEvent):void 
		{
			if (dragTarget != null) 
			{
				dragTarget.stopDrag();
			}
		}
		
		private function sliderEngine(e:Event):void 
		{
			var observer_position = _OBSERVER.x
			var observer_width = _OBSERVER.width-1024
			var operator_width = 912 - mc.width
			var operator_position = mc.x
			
			percent_do_slider = (operator_position * 100) / operator_width
			
			new_x = (percent_do_slider * observer_width) / 100
			
			_OBSERVER.x += Math.floor(( -new_x - _OBSERVER.x) / 5)
		}
		
		public function deActivateFast():void
		{
			this.removeEventListener(Event.ENTER_FRAME, sliderEngine)
			
			this.visible = false
			
			Navigation.getSingleton().hideSliderBar()
			
			_OBSERVER.x = 0
		}
		
		public function deActivate():void
		{
			Move.ToPositionX(_OBSERVER, 0, 0.3)
			
			this.removeEventListener(Event.ENTER_FRAME, sliderEngine)
		}
		
		public function reActivate():void
		{
			this.addEventListener(Event.ENTER_FRAME, sliderEngine)
			
			this.visible = true
			
			Navigation.getSingleton().applySliderBar()
		}
		
		public function registerObserver(clip:MovieClip):void
		{
			trace("registerObserver clip = " + clip)
			
			_OBSERVER = clip
			
			this.addEventListener(Event.ENTER_FRAME, sliderEngine)
		}	
	}
}