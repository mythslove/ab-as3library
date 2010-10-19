package com.edigma.events
{
	import flash.events.EventDispatcher
	import flash.events.Event;
	
	/**
	* @author ABº
	*
	* @USAGE : 
	* 
	*     - to dispatch events:
	* 
	* 	  import com.ab.events.CentralEventSystem
	* 
	* 	  CentralEventSystem.singleton.dispatchEvent(new ExampleEvent(ExampleEvent.EVENT_TYPE, some_data_of_any_type));
	* 
	*     -------------------------------------
	* 
	* 	  - to receive events: import class, add event listener, create listener function
	* 
	* 	  import com.ab.events.CentralEventSystem
	* 
	* 	  CentralEventSystem.singleton.addEventListener(ExampleEvent.EVENT_TYPE, someEventListener)
	* 
	* 	  LISTENERS ARE ADDED TO THE SINGLETON ITSELF, NOT IN THE CALLER CLASS
	* 
	* 	  public function someEventListener(e:ExampleEvent):void 
	*	  { 
	*	  	  trace ("SomeClass ::: event received = " + e.data ); 
	*	  }
	* 
	*     -------------------------------------
	* 
	*     example event class - see AppEvent.as
	*/
	
	public class CentralEventSystem extends EventDispatcher
	{
		private static var instance:CentralEventSystem = new CentralEventSystem();
		
		public function CentralEventSystem():void
		{
			super();
			
			if (instance)
			{
				throw new Error("Error: CentralEventSystem can only be accessed through CentralEventSystem.singleton");
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