package com.ab.apps.appgenerics
{
	/**
	* @author ABº
	* 
	*					  |//
	*			   		 (o o)
	*	+----------oOO----(_)------------------+
	*	|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
	*	|~~~~~~~~~~~~ ¤   ABº   ¤ ~~~~~~~~~~~~~|
	*	|~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~|
	*	+---------------------oOO--------------+
    * 	               |__|__|
    *                   || ||
    *                  ooO Ooo
	* 
	* This class manages all application data
	* and provides data collection methods for the objects
	*/
	
	//import com.ab.apps.appgenerics.CORE;
	import com.ab.apps.appgenerics.events.AppEvent;
	import com.ab.log.ABLogger;
	import com.edigma.services.ServerCommunication;
	import com.edigma.web.EdigmaCore;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import gs.dataTransfer.XMLManager;
	import com.ab.events.CentralEventSystem;
	import org.casalib.util.StageReference;
	
	public class DataManager extends Sprite
	{
		/// public
		public static var __singleton:DataManager;
		
		/// private
		//private var _data:Object
		private var _data:*
		private var _type:String=null;
		private var _amfresults_num:int=0;
		
		public function DataManager(type:String=null)
		{
			setSingleton();
			
			_type = type;
			
			setVars();
		}
		
		private function setVars():void
		{
			_data = new Object();
		}
		
		/// getters / setters
		public function get data():* 				{ return _data; };
		public function set data(value:*):void  	{ _data = value; };
		
		public function start() 						{ init(); };
		
		private function init():void 				
		{ 
			if (_type != null) 
			{
				switch (_type) 
				{
					case "XML":
						getXMLData();
					break;
					
					case "AMF":
						getAMFData();
					break;
				}
			}
		};
		
		private function getAMFData():void
		{
			/// insert AMF requests here
			
			var _slideshow_mode:String
			
			if (StageReference.getStage().loaderInfo.parameters.vmode != null) 
			{
				_slideshow_mode = StageReference.getStage().loaderInfo.parameters.vmode.toUpperCase();
			}
			else
			{
				_slideshow_mode = "MIXED";
			}
			
			//ABLogger.singleton.echo("DataManager SLIDESHOW MODE = " + _slideshow_mode);
			
			var _CATIMG:int;
			var _CATVID:int;
			
			if (StageReference.getStage().loaderInfo.parameters.vcatimg != null && StageReference.getStage().loaderInfo.parameters.vcatimg != "") 
			{
				_CATIMG		= StageReference.getStage().loaderInfo.parameters.vcatimg;
			}
			else
			{
				_CATIMG		= 5;
			}
			
			if (StageReference.getStage().loaderInfo.parameters.vcatvid != null && StageReference.getStage().loaderInfo.parameters.vcatvid != "") 
			{
				_CATVID		= StageReference.getStage().loaderInfo.parameters.vcatvid;
			}
			else
			{
				_CATVID		= 6;
			}
			
			if (_slideshow_mode == "MIXED") 
			{
				_amfresults_num = 2;
				
				ServerCommunication.singleton.listarRelatedFilesRequest(onAMFDataReceived, _CATIMG, 1, 1, 5);
				
				ServerCommunication.singleton.listarRequest(onAMFDataReceived, _CATVID, 1);
			}
			
			if (_slideshow_mode == "VIDEOS") 
			{
				ServerCommunication.singleton.listarRequest(onAMFVideosOnlyDataReceived, _CATVID, 1);
			}
			
			if (_slideshow_mode == "IMAGES") 
			{
				ServerCommunication.singleton.listarRequest(onAMFImagesOnlyDataReceived, _CATIMG, 1);
			}
		}
		
		private function onAMFImagesOnlyDataReceived(o:Object):void
		{
			_data.images 	= new Object();
			
			_data.images 	= o.result;
			
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
		}
		
		private function onAMFVideosOnlyDataReceived(o:Object):void
		{
			_data.videos 	= new Object();
			
			_data.videos 	= o.result;
			
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
		}
		
		private function onAMFDataReceived(o:Object):void 
		{
			//trace ("DataManager ::: onAMFDataReceived");
			
			/// AMF results handling here
			
			if (_amfresults_num == 2) 
			{
				_data.videos 	= new Object();
				_data.images 	= new Object();
			}
			
			_amfresults_num--;
			
			if (o.result.id_categoria == 6)
			{
				_data.videos = o.result;
			}
			else
			{
				_data.images = o.result;
			}
			
			if (_amfresults_num == 0) 
			{
				CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
			}
		}
		
		public function getXMLData():void
		{
			var xmlLoader:URLLoader = new URLLoader();
			var xmlData:XML = new XML();
			
			xmlLoader.addEventListener(Event.COMPLETE, onXMLDataReceived);
		}
		
		private function onXMLDataReceived(e:Event):void 
		{
			var xmlData:XML = new XML(e.target.data); /// assuming root node is named "data"
			//_data = new XML();
			_data = xmlData;
			
			CentralEventSystem.singleton.dispatchEvent(new AppEvent(AppEvent.LOADED_DATA, true));
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		private function setSingleton():void
		{
			if (__singleton != null)  { throw new Error("DataManager ::: SINGLETON REPLICATION ATTEMPTED") }; __singleton = this;
		}
		public static function get singleton():DataManager
		{
			if (__singleton == null) { throw new Error("DataManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)") }; return __singleton;
		}
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}