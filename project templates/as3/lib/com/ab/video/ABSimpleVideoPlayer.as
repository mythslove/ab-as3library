package com.ab.video
{
	/**
	* @author ABº
	*/
	
	//import com.ab.log.ABLogger;
	import caurina.transitions.Tweener;
	import com.ab.core.COREApi;
	import com.ab.events.ItemEvent;
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
		private var _customwidth:Number;
		private var _customheight:Number;
		/// video load
		protected var _videoLoad:VideoLoad;
		private var _main_colour:uint=0xFF0000;
		
		public function ABSimpleVideoPlayer() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedHandler, false, 0, true);
		}
		
		private function addedHandler(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, addedHandler);
			
			start();
		}
		
		public function start():void
		{
			this._videoLoad 				= new VideoLoad(_url);
			
			this._videoLoad.video.width  	= _customwidth;
			this._videoLoad.video.height 	= _customheight;
			
			this._videoLoad.start();
			
			this.addChild(this._videoLoad.video);
			
			this.alpha = 1;
		}
		
		public function close():void
		{
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
		
		public function die():void
		{
			//Tweener.addTween(this, { alpha:0, time:1, onComplete:close} );
			close();
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
		{/*
			var seconds:Number = Math.round(this._videoLoad.netStream.time);
			
			if (seconds < 60) 
			{
				if (seconds >= 10) 
				{
					//videocontroller.time_tf.text = "00:" + seconds;
				}
				else
				{
					//videocontroller.time_tf.text = "00:0" + seconds;
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
			}*/
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
		
		public function get customwidth():Number { return _customwidth; }
		
		public function set customwidth(value:Number):void 
		{
			_customwidth = value;
		}
		
		public function get customheight():Number { return _customheight; }
		
		public function set customheight(value:Number):void 
		{
			_customheight = value;
		}
		
	}
	
}