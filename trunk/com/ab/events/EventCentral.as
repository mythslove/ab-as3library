package com.ab.events
{
	import flash.events.EventDispatcher
	import flash.events.Event;
	
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	*
	* @USAGE : 
	* 
	*     - to dispatch events:
	* 
	* 	  import com.ab.events.EventCentral
	* 
	* 	  EventCentral.getInstance().dispatchEvent(new ExampleEvent(ExampleEvent.EVENT_TYPE, some_data));
	* 
	*     -------------------------------------
	* 
	* 	  - to receive events: import class, add event listener, create listener function
	* 
	* 	  import com.ab.events.EventCentral
	* 
	* 	  EventCentral.getInstance().addEventListener(ExampleEvent.EVENT_TYPE, eventListenerFunction)
	* 
	* 	  public function mesaInteractiveEventListener(e:MesaInteractivaEvent):void 
	*	  { 
	*	  	  trace ("AppManager ::: SENSOR DATA RECEIVED = " + e.data ); 
	*	  }
	* 
	*     -------------------------------------
	* 
	*     example event class - see ExampleEvent.as
	*/
	
	
	public class EventCentral extends EventDispatcher
	{
		private static var instance:EventCentral = new EventCentral();
		
		public function EventCentral():void
		{
			super();
			if (instance)
			{
				throw new Error("Error: EventCentral can only be accessed through EventCentral.getInstance()");
			}
			
			trace("::: EventCentral :::")
		}
		
		public static function getInstance():EventCentral
		{
			return instance;
		}	
		
		override public function dispatchEvent($event:Event):Boolean
		{
			return super.dispatchEvent($event);
		}
	}
}