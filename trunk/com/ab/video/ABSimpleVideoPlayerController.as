package com.ab.video
{
	/**
	* @author ABº
	*/
	
	import caurina.transitions.Tweener;
	import com.ab.apps.appgenerics.core.AppLevelsManager;
	import com.ab.apps.appgenerics.core.COREApi;
	import com.ab.apps.appgenerics.events.ItemEvent;
	import com.ab.events.CentralEventSystem;
	import com.ab.log.Logger;
	import com.ab.utils.Make;
	import com.ab.utils.Move;
	import com.ab.utils.Size;
	import com.ab.utils.Web;
	import flash.text.TextField;
	//import com.edigma.web.EdigmaCore;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NetStatusEvent;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.net.NetStream;
	import org.casalib.util.StageReference;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import org.casalib.load.VideoLoad;
	
	public class ABSimpleVideoPlayerController extends MovieClip
	{
		/// STAGE SYMBOLS
		public var playpause_button:MovieClip; /// mc com dois mcs dentro, o pause_btn, e o play_btn
		public var bar:MovieClip;              /// mc com dois mcs dentro, uma scrubberbar, e uma loadedbar
		//public var volume_mc:MovieClip;
		//public var volume_icon_mc:MovieClip;
		public var fullscreen_mc:MovieClip;
		public var time_tf:TextField;
		
		/// private
		private var _videoload:*;
		private var _netstream:NetStream;
		private var _videopaused:Boolean=false;
		private var _duration:Number;
		private var _scrubberactive:Boolean=false;
		private var _scrubbing:Boolean=false;
		private var _goOutAfterScrubbing:Boolean=false;
		private var _bars_width:Number;
		private var _volume_bar_width:Number;
		private var _videoVolumeTransform:SoundTransform;
		private var _tuning_volume:Boolean=false;
		private var _sound_on:Boolean=true;
		private var _last_active_volume:Number=0;
		private var _fullscreen:Boolean=false;
		private var _standby:Boolean=false;
		private var _autoplay:Boolean=true;
		private var _first_time:Boolean = true;
		private var _loop:Boolean = false;
		private var _start_volume:Number = 0.5;
		private var _main_colour:uint = 0xFF0000;
		
		//PlayButton2
		public function ABSimpleVideoPlayerController() 
		{
			//_bars_width 		= bar.width;
			//_volume_bar_width 	= volume_mc.volumecontrol_mc.width;
			
			//volume_icon_mc.addEventListener(MouseEvent.CLICK, soundToggleHandler);
			//fullscreen_mc.addEventListener(MouseEvent.CLICK,  fullScreenToggleHandler);
			
			//StageReference.getStage().addEventListener(MouseEvent.MOUSE_UP,   	scrubberUnpressHandler, false, 0, true);
			
			//playpause_button.addEventListener(MouseEvent.CLICK,  playPauseClickHandler,  false, 0, true);
			
			//playpause_button.buttonMode  		= true;
			//volume_icon_mc.buttonMode 			= true;
			//fullscreen_mc.buttonMode  			= true;
			//volume_mc.buttonMode  				= true;
			/*
			playpause_button.pause_btn.visible 	= false;
			playpause_button.play_btn.visible  	= false;
			
			playpause_button.play_btn.addEventListener(MouseEvent.ROLL_OUT,  buttonRollOutHandler);
			playpause_button.play_btn.addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
			*/
			//fullscreen_mc.addEventListener(MouseEvent.ROLL_OUT,  fullscreenRollOutHandler);
			//fullscreen_mc.addEventListener(MouseEvent.ROLL_OVER, fullscreenRollOverHandler);
			
			//playpause_button.pause_btn.addEventListener(MouseEvent.ROLL_OUT,  buttonRollOutHandler);
			//playpause_button.pause_btn.addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
			
			//volume_mc.volumecontrol_mc.addEventListener(MouseEvent.MOUSE_DOWN,  volumePressHandler);
			
			//this.addEventListener(Event.ENTER_FRAME, playingMode_enterFrameHandler, false, 0, true);
			//this.addEventListener(Event.ENTER_FRAME, handle_mc_enterFrameHandler);	
		}
		
		public function setColours():void
		{
			//Make.MCColour(playpause_button.pause_btn.highlight, _main_colour, 0.0);
			//Make.MCColour(playpause_button.play_btn.highlight,  _main_colour, 0.0);
			//Make.MCColour(bar.loadedbar,   _main_colour, 0.1, "Linear", 0.3);
			//Tweener.addTween(bar.scrubberbar, { _color:_main_colour, time:0.1} );
		}
		
		public function showBigPlayButton():void 
		{
			//trace( "showBigPlayButton : ");
			
			//var playbtn:MovieClip = new PlayButton2()
			
			//Make.MCColour(playbtn.highlight, _main_colour, 0.0);
			
			//fullscreen_mc.visible = false;
			//bar.visible = false;
			
			//playpause_button.visible = false;
			
			//playbtn.scaleX  = 5;
			//playbtn.scaleY  = 5;
			
			//playbtn.addEventListener(MouseEvent.ROLL_OUT,  buttonRollOutHandler);
			//playbtn.addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
			
			//var new_x:Number = (StageReference.getStage().stageWidth / 2) - (playbtn.width/2);
			//var new_y:Number = ((StageReference.getStage().stageHeight - this.height) / 2) - (playbtn.height / 2);
			
			//playbtn.addEventListener(MouseEvent.CLICK, bigPlayBtnClickHandler, false, 0, true);
			
			//playbtn.visible = true;
			
			//COREApi.createObjectinLevel(playbtn, "TOP", new Point(new_x, new_y));
		}
		/*
		private function bigPlayBtnClickHandler(e:MouseEvent):void 
		{
			//fullscreen_mc.visible = true;
			bar.visible = true;
			
			e.currentTarget.removeEventListener(MouseEvent.ROLL_OUT,  buttonRollOutHandler);
			e.currentTarget.removeEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
			
			e.currentTarget.removeEventListener(MouseEvent.CLICK, bigPlayBtnClickHandler);
			
			e.currentTarget.visible = false;
			
			playpause_button.visible = true;
			
			//var lalala:MouseEvent = new MouseEvent(MouseEvent.CLICK);
			
			playPauseClickHandler(null);
		}*/
		
		private function fullscreenRollOverHandler(e:MouseEvent):void 
		{
			//Make.MCColour(fullscreen_mc.icon, _main_colour, 0.1, "Linear", 1);
		}
		
		private function fullscreenRollOutHandler(e:MouseEvent):void 
		{
			//Make.MCColour(fullscreen_mc.icon, 0xffffff, 0.1, "Linear", 1);
		}
		
		private function fullScreenToggleHandler(e:MouseEvent):void 
		{
			COREApi.setFullscreen();
		}
		
		private function buttonRollOverHandler(e:MouseEvent):void 
		{
			Make.MCToAlpha(e.currentTarget.highlight, 0.8, 0.3);
		}
		
		private function buttonRollOutHandler(e:MouseEvent):void 
		{
			Make.MCToAlpha(e.currentTarget.highlight, 0.0, 0.5);
		}
		
		private function soundToggleHandler(e:MouseEvent):void 
		{
			if (_sound_on == true) 
			{
				_videoVolumeTransform.volume 	= 0;
				
				_netstream.soundTransform		= _videoVolumeTransform;
				
				//Make.MCToAlpha(volume_mc, 0.1);
				
				_sound_on = false;
			}
			else
			{
				_videoVolumeTransform.volume 	= _last_active_volume;
				
				_netstream.soundTransform		= _videoVolumeTransform;
				
				//Make.MCToAlpha(volume_mc, 1);
				
				_sound_on = true;
			}
		}
		/*
		private function volumePressHandler(e:MouseEvent):void 
		{
			if (_sound_on == true) 
			{
				_tuning_volume = true
				
				this.addEventListener(Event.ENTER_FRAME, adjustVolume_enterFrame, false, 0, true);
			}
		}*/
		
		private function adjustVolume_enterFrame(e:Event):void 
		{
			//trace
			//var seekpoint:Number = StageReference.getStage().mouseX - volume_mc.x;
			/*
			if (seekpoint > 0 && seekpoint <= _volume_bar_width) 
			{
				//volume_mc.mask_mc.width 			= seekpoint;
				
				var percentagepoint:Number 			= Math.ceil((volume_mc.mask_mc.width * 100) / _volume_bar_width);
				
				percentagepoint 					= percentagepoint / 100;
				
				_last_active_volume 				= percentagepoint;
				
				_videoVolumeTransform.volume 		= _last_active_volume;
				
				_netstream.soundTransform			= _videoVolumeTransform;
			}*/
		}
		
		//private function scrubberUnpressHandler(e:MouseEvent):void
		//{
			//if (_tuning_volume == true)  
			//{ 
				//_tuning_volume = false; 
				//
				//this.removeEventListener(Event.ENTER_FRAME, adjustVolume_enterFrame);
			//}
			//
			//if (_scrubbing == true) 
			//{
				//var percentagepoint:Number 	= Math.ceil((bar.scrubberbar.width * 100) / _bars_width);
				//var newplaypoint:Number 	= (percentagepoint * _duration) / 100;
				/*
				scrubbing = false;
				
				if(newplaypoint < 0.5)
				{
					netstream.seek(0);
				}
				else
				{
					netstream.seek(newplaypoint);
				}*/
			//}
		//}
		
		private function handle_mc_enterFrameHandler(e:Event):void 
		{
			//bar.handle_mc.x = bar.scrubberbar.width + 2;
		}
		
		private function scrubberPressHandler(e:MouseEvent):void
		{
			_scrubbing = true;
		}
		
		//private function loaderbar_PressHandler(e:MouseEvent):void
		//{
			//_scrubbing = true;
		//}
		
		private function playingMode_enterFrameHandler(e:Event):void 
		{
			if (scrubbing == true) 
			{
				var seekpoint:Number = bar.mouseX;
				
				if (seekpoint > 0 && seekpoint <= _bars_width) 
				{
					//bar.scrubberbar.width = seekpoint;
				}
			}
			else
			{
				var newsize:Number = (_bars_width * netstream.time) / _duration;
				
				if (newsize <= _bars_width) 
				{
					//bar.scrubberbar.width = newsize;
				}
			}
		}
		
		private function playPauseClickHandler(e:MouseEvent=null):void 
		{
			if (_autoplay == false) 
			{
				_videoload.start(); 
				
				_autoplay = true;
			}
			else
			{
				if (_videopaused == false) 
				{
					pause();
				}
				else
				{
					resume();
				}
			}
		}
		
		private function standby():void 
		{
			_standby = true;
		}
		
		private function pause():void 
		{ 
			_videopaused = true;
			
			netstream.pause();
			
			//playpause_button.pause_btn.visible = false;
			//playpause_button.play_btn.visible  = true;
			//playpause_button.pause_btn.alpha = 0;
			//playpause_button.play_btn.alpha = 1;
		}
		
		private function resume():void 
		{ 
			_videopaused = false;
			
			netstream.resume();
			
			//playpause_button.play_btn.visible  = false;
			//playpause_button.pause_btn.visible = true;
			//playpause_button.pause_btn.alpha = 1;
			//playpause_button.play_btn.alpha = 0;
		}
		
		public function setLoadedByPercent(percent:Number):void
		{
			//if (percent <= 100)
			//{
				//var loaderbarwidth:Number = (percent * _bars_width) / 100;
				
				/*
				if (loaderbarwidth <= _bars_width)
				{
					Size.ToWidth(bar.loadedbar, loaderbarwidth);
				}*/
			//}
		}
		
		private function netstat(stats:NetStatusEvent):void
		{
			if (stats.info.code == "NetStream.Play.Start")
			{
				_videopaused  = false;
				//playpause_button.play_btn.visible  = false;
				//playpause_button.pause_btn.visible = true;
				//playpause_button.pause_btn.alpha = 1;
				//playpause_button.play_btn.alpha = 0;
			}
			else
			{
				if (stats.info.code == "NetStream.Play.Stop")
				{
					if (_loop == true) 
					{
						/// restart
						netstream.seek(0);
					}
					if (_loop != true) 
					{
						//ABSimpleVideoPlayer(parent).die();
						CentralEventSystem.singleton.dispatchEvent(new ItemEvent(ItemEvent.CLOSE_ITEM, "close_video"));
						
						/*
						_videopaused = true;
						
						netstream.seek(0);
						netstream.pause();
						
						playpause_button.play_btn.visible  	= true;
						playpause_button.pause_btn.visible 	= false;
						playpause_button.pause_btn.alpha 	= 0;
						playpause_button.play_btn.alpha 	= 1;
						*/
					}
				}
			}
		}
		
		public function get netstream():NetStream 				{ return _netstream;  };
		public function set netstream(value:NetStream):void  	
		{ 
			_netstream = value; 
			_netstream.addEventListener(NetStatusEvent.NET_STATUS, netstat, false, 0, true);
			
			/// define start volume
			_videoVolumeTransform 			= new SoundTransform();
			
			_videoVolumeTransform.volume 	= _start_volume;
			
			_netstream.soundTransform		= _videoVolumeTransform;
			
			//volume_mc.mask_mc.scaleX 		= _start_volume;
			
			_last_active_volume 			= _start_volume;
		}
		
		public function get duration():Number 				{ return _duration;  }
		public function set duration(value:Number):void  	
		{
			_duration = value; 
			
			//bar.addEventListener(MouseEvent.MOUSE_DOWN, 				scrubberPressHandler);
			//bar.loadedbar.addEventListener(MouseEvent.MOUSE_DOWN, 				scrubberPressHandler);
			//bar.scrubberbar.addEventListener(MouseEvent.MOUSE_DOWN, 			scrubberPressHandler);
			//bar.handle_mc.addEventListener(MouseEvent.MOUSE_DOWN, 				scrubberPressHandler);
			
			//bar.loadedbar.buttonMode    = true;
			//bar.scrubberbar.buttonMode  = true;
			//bar.handle_mc.buttonMode  = true;
			
			_scrubberactive = true;
		}
		
		public function get scrubbing():Boolean 						{ return _scrubbing;  }
		public function set scrubbing(value:Boolean):void  				{ _scrubbing = value; }
		
		public function get goOutAfterScrubbing():Boolean 				{ return _goOutAfterScrubbing;  }
		public function set goOutAfterScrubbing(value:Boolean):void  	{ _goOutAfterScrubbing = value; }
		
		public function get videoload():* 								{ return _videoload;  }
		public function set videoload(value:*):void  					{ _videoload = value; }
		
		public function get autoplay():Boolean 							{ return _autoplay;  }
		public function set autoplay(value:Boolean):void  				{ _autoplay = value; }
		
		public function get loop():Boolean 								{ return _loop; }
		public function set loop(value:Boolean):void  					{ _loop = value; }
		
		public function set main_colour(value:uint):void  				{ _main_colour = value; }
		
	}
	
}