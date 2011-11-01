package 
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class LocalEvents extends Event
	{
		public static const EXAMPLE_EVENT:String = "exampleevent";
		
		public var data:*;
		
		public function LocalEvents(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new LocalEvents(type, data);
		}
		
	}
}