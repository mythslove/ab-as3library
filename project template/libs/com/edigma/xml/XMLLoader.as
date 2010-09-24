package com.edigma.xml {
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.utils.Dictionary;

	
	/**
	* @author Jesse Freeman
	* 
	* original: http://flashartofwar.com/2007/07/13/as-3-settings-utility/
	*/
	
	public class XMLLoader {
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Constructor
		 */
		public function XMLLoader(singletonEnforcer : SingletonEnforcer) 
		{
			if (singletonEnforcer == null) {
				throw new Error("XMLLoader can only be accessed through XMLLoader.instance");
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _instance : XMLLoader;
		private var _loaders : Dictionary = new Dictionary();
		private var _data : Dictionary = new Dictionary();
		private var _parsers : Dictionary = new Dictionary();
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  instance
		//----------------------------------
		
		public static function get instance() : XMLLoader {
			if (_instance == null) {
				_instance = new XMLLoader(new SingletonEnforcer());
			}
			return _instance;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
				
		/**
		 *	@private
		 *  
		 */
		public static function load(source : String, parserFunction : Function): void {	
			instance._load(source, parserFunction);
		}
		
		/**
		 *	@private
		 *  
		 */
		internal function _load(source : String, parserFunction : Function) : void {
			var xmlLoader : URLLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, xmlLoader_CompleteHandler);
			
			_loaders[xmlLoader] = xmlLoader;
			
			var xml_data : XML = new XML();
			xml_data.ignoreWhitespace = true;
			_data[xmlLoader] = xml_data;
			
			_parsers[xmlLoader] = parserFunction;

			xmlLoader.load(new URLRequest(source));
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 *	@private
		 *  
		 */
		internal function xmlLoader_CompleteHandler(e : Event) : void {
			_data[e.target] = new XML(e.target.data);
			_parsers[e.target].call(this, _data[e.target]);
		}
	}
}

class SingletonEnforcer {
}