package com.ab.video
{
	/**
	* @author ABº
	*/
	
	//import com.ab.apps.appgenerics.core.COREApi;
	//import com.ab.log.ABLogger;
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.utils.Make;
	import com.ab.utils.Move;
	import com.edigma.web.EdigmaCore;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.casalib.display.CasaSprite;
	import org.casalib.util.StageReference;
	
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
    import org.casalib.events.VideoLoadEvent;
    import org.casalib.load.VideoLoad;
	
	public class ABSimpleVideoPlayer extends CasaSprite
	{
		private var _url:String;
		public var videocontroller:ABSimpleVideoPlayerController;
		private var netstream:NetStream;
		private var _duration:Number;
		private var _autoPlay:Boolean;
		
		/// video load
		protected var _videoLoad:VideoLoad;
		private var _main_colour:uint=0xFF0000;
		
		public function ABSimpleVideoPlayer() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			
			CentralEventSystem.singleton.addEventListener(ItemEvent.CLOSE_ITEM, closeItemHandler, false, 0, true);
			
			this.alpha = 0;
		}
		
		private function closeItemHandler(e:ItemEvent):void 
		{
			if (e.data != null && e.data == "close_video") 
			{
				die();
			}
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			
			die();
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		public function close():void
		{
			CentralEventSystem.singleton.removeEventListener(ItemEvent.CLOSE_ITEM, closeItemHandler);
			
			if (this._videoLoad != null) 
			{
				this._videoLoad.netStream.close();
				this._videoLoad.destroy();
				this._videoLoad = null;
			}
			
			if (videocontroller != null ) 
			{
				videocontroller = null;
			}
			
			destroy();
		}
		
		public function start()
		{
			//trace( "ABSimpleVideoPlayer :: start");
			
			this._videoLoad 				= new VideoLoad(_url);
			//this._videoLoad.preventCache 	= true; 
			this._videoLoad.addEventListener(VideoLoadEvent.PROGRESS, this._onProgress, false, 0, true);
			this._videoLoad.addEventListener(VideoLoadEvent.BUFFERED, this._onBuffered, false, 0, true);
			
			this._videoLoad.video.width  	= StageReference.getStage().stageWidth;
			this._videoLoad.video.height 	= StageReference.getStage().stageHeight;
			
			if (_autoPlay != true) 
			{
				this._videoLoad.pauseStart 	= true;
				///videocontroller.showBigPlayButton();
			}
			else
			{
				this._videoLoad.pauseStart  = false;
				this._videoLoad.start(); 
			}
			
			this.addChild(this._videoLoad.video);
			
			videocontroller 				= new ABSimpleVideoPlayerController();
			videocontroller.netstream 		= this._videoLoad.netStream;
			videocontroller.videoload 		= this._videoLoad;
			videocontroller.videoload 		= this._videoLoad;
			videocontroller.main_colour		= _main_colour;
			videocontroller.alpha			= 0;
			//
			videocontroller.setColours();
			
			this.addChild(videocontroller);
			
			videocontroller.y = 215;
			
			videocontroller.playpause_button.visible 			= true;
			videocontroller.playpause_button.play_btn.visible 	= true;
			videocontroller.playpause_button.pause_btn.visible 	= false;
			
			Tweener.addTween(this, { alpha:1, time:1} );
		}
		
		public function die():void
		{
			Tweener.addTween(this, { alpha:0, time:1, onComplete:close} );
		}
		
		protected function _onProgress(e:VideoLoadEvent):void 
		{
			//trace(e.millisecondsUntilBuffered 	+ " milliseconds until buffered");
			//trace(e.buffer.percentage 			+ "% buffered");
			//trace(e.progress.percentage 			+ "% loaded");
			
			if (videocontroller != null) 
			{
				videocontroller.setLoadedByPercent(e.progress.percentage);
				
				if (e.progress.percentage == 100) 
				{
					videocontroller.duration = this._videoLoad.duration;
					
					setTimeRead();
				}
			}
		}
		
		private function setTimeRead():void
		{
			this.addEventListener(Event.ENTER_FRAME, timeReadEnterFrame, false, 0, true);
		}
		
		private function timeReadEnterFrame(e:Event):void 
		{
			var seconds:Number = Math.round(this._videoLoad.netStream.time);
			
			if (seconds < 60) 
			{
				if (seconds >= 10) 
				{
					videocontroller.time_tf.text = "00:" + seconds;
				}
				else
				{
					videocontroller.time_tf.text = "00:0" + seconds;
				}
			}
			else
			{
				var minutes:Number 		= Math.floor(seconds / 60);
				
				var secondsleft:Number 	= seconds - (minutes * 60);
				
				if (secondsleft >= 10) 
				{
					if (minutes >= 10) 
					{
						videocontroller.time_tf.text = minutes + ":" + secondsleft;
					}
					else
					{
						videocontroller.time_tf.text = "0" + minutes + ":" + secondsleft;
					}
				}
				else
				{
					if (minutes >= 10) 
					{
						videocontroller.time_tf.text = minutes + ":0" + secondsleft;
					}
					else
					{
						videocontroller.time_tf.text = "0" + minutes + ":0" + secondsleft;
					}
				}
			}
		}
		
		protected function _onBuffered(e:VideoLoadEvent):void 
		{
			e.target.netStream.resume();
		}
		
		/*
		private function resizeHandler(e:Event):void 
		{
			if (StageReference.getStage().displayState == StageDisplayState.FULL_SCREEN) 
			{
				videocontroller.visible = false;
			}
			else
			{
				videocontroller.visible = true;
			}
			
			//this._videoLoad.video.width  = StageReference.getStage().stageWidth;
			//this._videoLoad.video.height = StageReference.getStage().stageHeight - videocontroller.height;
		}*/
		
		public function get url():String 					{ return _url;  };
		public function set url(value:String):void  		{ _url = value; };
		
		public function get autoPlay():Boolean 				{ return _autoPlay;  };
		public function set autoPlay(value:Boolean):void  	{ _autoPlay = value; };
		
		public function set main_colour(value:uint):void  	{ _main_colour = value; }
		
	}
	
}