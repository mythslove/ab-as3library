package org.bytearray.jpeg_encoder.asfiles.events

{
	
	import flash.events.Event;
	
	public class PlayerEvent extends Event 
	
	{
		
		public var time:Number;
		public var progress:Number;
		
		public static const ON_PROGRESS:String = "onProgress";
		
		public function PlayerEvent ( pEvent:String, pTime:Number, pProgress:Number )
		
		{
			
			super ( pEvent );
			
			time = pTime;
			
			progress = pProgress;
			
		}
		
	}
	
}