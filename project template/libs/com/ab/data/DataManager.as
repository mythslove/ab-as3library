package com.ab.data
{
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* This class manages all info collected from the XML
	* and provides central data collection system
	* 
	* Dependencies: XMLManager by Greensock ( http://blog.greensock.com/ )
	*/
	
	import flash.display.Sprite;
	import gs.dataTransfer.XMLManager;
	
	public class DataManager extends Sprite
	{
		/// public
		public static var __singleton:DataManager;
		
		/// private
		private var _XML_PATH:String = "";
		private var _processing:Boolean = false;
		private var _return_function:Function;
		
		public function DataManager()
		{
			setSingleton();
		}
		
		/// getters / setters
		public function get XML_PATH():String 			{ return _XML_PATH; }
		public function set XML_PATH(s:String):void  	{ _XML_PATH = s;    }
		
		public function requestFileData(xmlfile:String, returnFunction:Function):void
		{
			if (!_processing)
			{
				_processing = true;
				
				_return_function = returnFunction;
				
				XMLManager.load(_XML_PATH + xmlfile, onObjectDataReceived);
			}
			else
			{
				trace("DATAMANAGER ::: CANNOT LOAD XML, STILL PROESSING")
			}
		}
		
		private function onObjectDataReceived($results:Object):void
		{	
			if ($results.success)
			{
				_return_function($results.parsedObject)
			}
			else
			{
				trace("DATAMANAGER ::: ERROR LOADING XML, PLEASE VERIFY PARAMETERS")
			}
			
			_processing = false;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("DataManager ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():DataManager
		{
			if (__singleton == null)
			{
				throw new Error("DataManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
	}
}