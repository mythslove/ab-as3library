﻿package com.ab.apps.appgenerics.core
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
	//import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import gs.dataTransfer.XMLManager;
	import com.ab.events.CentralEventSystem;
	import org.casalib.util.StageReference;
	
	public class DataManager extends Sprite
	{
		/// public
		public static var __singleton:DataManager;
		public var xml_path:String="";
		
		/// private
		private var _data:Object
		private var _type:String=null;
		private var _amfresults_num:int = 0;
		
		
		
		public function DataManager(type:String=null)
		{
			setSingleton();
			
			_type = type;
			
			setVars();
		}
		
		private function setVars():void { _data = new Object(); }
		
		/// getters / setters
		public function get data():* 				{ return _data; };
		public function set data(value:*):void  	{ _data = value; };
		
		public function loadBaseData() 				{ init(); };
		
		private function init():void 				
		{ 
			if (_type != null) 
			{
				switch (_type) 
				{
					case "XML":		getXMLData();	break;
					case "AMF": 	getAMFData();	break;
				}
			}
		};
		
		private function getAMFData():void
		{
			/// insert AMF requests here
			
			//ServerCommunication.singleton.listarRequest(onAMFImagesOnlyDataReceived, _CATIMG, 1);}
		}
		
		private function onAMFDataReceived(o:Object):void 
		{
			//trace ("DataManager ::: onAMFDataReceived");
			
			/// AMF results handling here
		}
		
		public function getXMLData():void
		{
			if (xml_path != "") 
			{
				var xmlData:XML 		= new XML();
				var xmlLoader:URLLoader = new URLLoader();
				
				xmlLoader.load(new URLRequest(xml_path));
				
				xmlLoader.addEventListener(Event.COMPLETE, onXMLDataReceived);
			}
			else
			{
				trace("XML FILE HAS NOT BEEN SPECIFIED")
			}
		}
		
		private function onXMLDataReceived(e:Event):void 
		{
			trace ("DataManager ::: onXMLDataReceived()"); 
			
			var xmlData:XML = new XML(e.target.data); /// assuming root node is named "data"
			
			_data = xmlData;
			
			//trace ("DataManager ::: item.main = " + _data.item.length() ); 
			
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