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
	
	/// implement activate_new_element
	
	/// implement remove_actual_element
	/// implement actual_element_removal_from_stage_listener
	///       - > add the new one 
	///             - > send him to stage
	///                      -> when he's on stage (0,0), resize & reposition window to fit size, centered (?)
	
	public class DynamicWindow extends ABSprite
	{
		//private var _align_mode:String="center";
		//private var _content_holder:Sprite;
		
		public function DynamicWindow() 
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
			//_content_holder = new Sprite();
		}
		
		private function start():void
		{
			/// uma entrada porreira
			
			/// create graphics NOT - control graphics instead
			
			//this.addChild(_content_holder)
		}
		
	}
	
}