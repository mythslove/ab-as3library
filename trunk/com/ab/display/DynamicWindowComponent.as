package com.ab.display 
{
	/**
	* @author ABº
	* 
	* INCOMPLETE - 10%
	*/
	
	import com.ab.display.ABSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import com.ab.display.DynamicWindowComponent;
	
	/// implement activate_new_component
	
	/// implement remove_actual_component
	/// implement actual_component_removal_from_stage_listener
	///       - > add the new one 
	///             - > send him to stage
	///                      -> when he's on stage (0,0), resize & reposition window to fit size, centered (?)
	
	public class DynamicWindowComponent extends ABSprite
	{
		private var _align_mode:String="center";
		private var _content_holder:Sprite;
		
		public function DynamicWindowComponent() 
		{
			initVars()
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true)
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler)
			
			start()
		}
		
		private function initVars():void
		{
			_content_holder = new Sprite();
		}
		
		private function start():void
		{
			/// uma entrada porreira
			
			/// create graphics
			
			this.addChild(_content_holder)
		}
		
	}
	
}