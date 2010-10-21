package com.ab.appobjects.toplevel
{
	/**
	* @author ABº
	*/
	
	///ab
	import com.ab.events.AppEvent;
	import com.ab.events.CentralEventSystem;
	
	///libs
	import org.casalib.display.CasaSprite;
	import caurina.transitions.Tweener;
	
	/// flash
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ApplicationScreensaver extends CasaSprite
	{
		private var _fade_on_exit:Boolean = true;
		private var _closed:Boolean=false;
		
		public function ApplicationScreensaver() 
		{
			CentralEventSystem.singleton.addEventListener(AppEvent.ACTIVITY_RESUMED,  this.activityDetected);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler);
		}
		
		public function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		/// override this funciton
		public function start():void
		{
			
		}
		
		private function activityDetected(e:AppEvent):void
		{
			e.stopPropagation();
			
			CentralEventSystem.singleton.removeEventListener(AppEvent.ACTIVITY_RESUMED,  this.activityDetected);
			
			close();
		}
		
		public function close():void 
		{
			_closed = true;
			
			if (_fade_on_exit == true) { Tweener.addTween(this, { alpha:0, time:0.5, onComplete:endClose } ); };
		}
		
		public function endClose():void { destroy(); }
		
		public function get fade_on_exit():Boolean 				{ return _fade_on_exit;  }
		public function set fade_on_exit(value:Boolean):void  	{ _fade_on_exit = value; }	
		
	}
	
}
