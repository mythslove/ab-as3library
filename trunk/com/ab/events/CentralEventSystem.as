package com.ab.events
{
	import flash.events.EventDispatcher
	import flash.events.Event;
	
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	*
	* @USAGE : 
	* 
	*     - to dispatch events:
	*  
	* 	  import com.ab.events.CentralEventSystem
	* 
	* 	  CentralEventSystem.getInstance().dispatchEvent(new ExampleEvent(ExampleEvent.EVENT_TYPE, some_data));
	* 
	*     -------------------------------------
	* 
	* 	  - to receive events: import class, add event listener, create listener function
	* 
	* 	  import com.ab.events.CentralEventSystem
	* 
	* 	  CentralEventSystem.singleton.addEventListener(ExampleEvent.EVENT_TYPE, eventListenerFunction)  ( LISTENERS ARE ADDED TO THE SIGLETON ITSELF)
	* 
	* 	  public function mesaInteractiveEventListener(e:ExampleEvent):void 
	*	  { 
	*	  	  trace ("AppManager ::: SENSOR DATA RECEIVED = " + e.data ); 
	*	  }
	* 
	*     -------------------------------------
	* 
	*     example event class - see ExampleEvent.as
	*/
	
	
	public class CentralEventSystem extends EventDispatcher
	{
		private static var instance:CentralEventSystem = new CentralEventSystem();
		
		public function CentralEventSystem():void
		{
			super();
			
			if (instance)
			{
				throw new Error("Error: CentralEventSystem can only be accessed through CentralEventSystem.getInstance() ");
			}
			
			trace("::: CentralEventSystem Constructor :::")
		}
		
		public static function get singleton():CentralEventSystem
		{
			return instance;
		}
		
		override public function dispatchEvent($event:Event):Boolean
		{
			return super.dispatchEvent($event);
		}
	}
}