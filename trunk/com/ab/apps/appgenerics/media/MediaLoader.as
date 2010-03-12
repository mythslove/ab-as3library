package com.ab.apps.appgenerics.media 
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import flash.display.Sprite;
	import com.ab.display.Image;
	import com.ab.events.CentralEventSystem;
	import objects.GalleryImage;
	import objects.GalleryVideo;
	import org.casalib.util.StageReference;
	
	
	public class MediaLoader 
	{
		private var _target:Sprite;
		private var _ACTUAL_MEDIA_URL:String;
		
		public function MediaLoader() 
		{
			setListeners();
		}
		
		private function setListeners():void
		{
			CentralEventSystem.singleton.addEventListener(ItemEvent.OPEN_ITEM, openItemEventListener);
		}
		
		/*
		*	This class listens to the event "ItemEvent.OPEN_ITEM"
		*	
		*	It expects to find the following properties inside the Event's data object: (e.data)
		*	
		*	type         = "IMAGE" or "VIDEO"
		*	instruction  = "LOAD_MEDIA" (no other defined)
		*	url			 = the asset's url for loading
		*/
		
		private function openItemEventListener(e:ItemEvent):void 
		{
			if (e.data.instruction != null) 
			{
				//trace ("MediaLoader ::: e.data.instruction = " + e.data.instruction ); 
				
				if (e.data.instruction == "LOAD_MEDIA")
				{
					switch (e.data.type) 
					{
						case "IMAGE":	
							loadImage(e.data.url);
							//if (displayingSameFile(e.data.url) == false)  { loadImage(e.data.url); };
						break;
						
						case "VIDEO":
							loadVideo(e.data.url);
							//if (displayingSameFile(e.data.url) == false)  { loadVideo(e.data.url); };
						break;
					}
				}
			}
		}
		
		private function displayingSameFile(url:String):Boolean
		{
			var result:Boolean = false;
			
			if (url == _ACTUAL_MEDIA_URL)  { result = true; }
			
			return result;
		}
		
		public function get target():Sprite 			{ return _target;  };
		public function set target(value:Sprite):void  	{ _target = value; };
		
		private function loadImage(url:String):void
		{
			//trace ("MediaLoader ::: loadImage ::: url = " + url); 
			
			_ACTUAL_MEDIA_URL = url;
			
			var newimg = new GalleryImage(url);
			
			COREApi.createObjectinLevel(newimg, "BACK");
		}
		
		private function loadVideo(url:String):void
		{
			//trace ("MediaLoader ::: loadVideo ::: url = " + url); 
			
			_ACTUAL_MEDIA_URL = url;
			
			var _video = new GalleryVideo();
			
			_video.url = url;
			
			COREApi.createObjectinLevel(_video, "BACK");
			
			_video.start();
		}
		
	}
	
}