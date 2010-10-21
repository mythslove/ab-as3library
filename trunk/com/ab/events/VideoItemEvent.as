package com.ab.events
{
	/**
	* @author ABº
	*/
	
	import flash.events.Event;
	
	public class VideoItemEvent extends Event
	{
		public static const LOAD_VIDEO:String		= "load_video";
		public static const STOP_PLAYBACK:String	= "stop_playback";
		
		public var data:*;
		
		public function VideoItemEvent(type:String, data:*, _bubbles:Boolean=false, _cancellable:Boolean=false) 
		{
			this.data = data;
			
			super(type, _bubbles, _cancellable);
		}
		
		public override function clone():Event 
		{
			return new VideoItemEvent(type, data);
		}
		
	}
}