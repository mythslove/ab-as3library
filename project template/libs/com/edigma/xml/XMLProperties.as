package com.edigma.xml {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;	
	import flash.utils.Proxy;	
	import flash.utils.Dictionary;	
	
	import com.edigma.xml.XMLLoader;	
	
	import flash.events.Event;	
	import flash.events.EventDispatcher;	
	import flash.utils.flash_proxy;

	
	/**
	* @author Jesse Freeman, minor changes by Frederico Garcia
	* 
	* original: http://flashartofwar.com/2007/07/13/as-3-settings-utility/
	*/
	
	dynamic public class XMLProperties extends Proxy implements IEventDispatcher {
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
		public function XMLProperties(enforcer : SingletonEnforcer) {
			if (enforcer == null) {
				throw new Error("XMLProperties can only be accessed through Settings.properties");
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private static var _properties : XMLProperties;
		private var _eventDispatcher : EventDispatcher;
		private var _externalHandler : Function;
		protected var applicationSettings : Dictionary;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  properties
		//----------------------------------
		public static function get properties() : XMLProperties {
			if( _properties == null ) _properties = new XMLProperties(new SingletonEnforcer());
			
			_properties._eventDispatcher = new EventDispatcher();
			
			return _properties;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		//
		/**
		 *	@private
		 *  
		 * 	Settings initializer function, loads settings from XML
		 */
		public static function init(file:String, handler:Function) : void {
			properties._externalHandler = handler;
			
			properties._eventDispatcher = new EventDispatcher();
			
			//load settings
			XMLLoader.load(file, properties.settingsParser);
		}
		
		/**
		 *	@private
		 *  
		 *  This function parses the XML nodes from settings.xml into the 
		 *  applicationSettings Dictionary
		 */
		private function settingsParser(value : XML) : void {
			applicationSettings = new Dictionary();
			
			var settingsIterator : XMLList = value.setting;
			//iterate settings
			for each (var property:XML in value..property)
			{
				//retrieve setting from current XMLItem	
				var applicationSettingName:String  = property.@id;
				var applicationSettingValue:String = property.@value;
				
				applicationSettings[applicationSettingName] = applicationSettingValue;
			}
			//dispatch complete event
			dispatchEvent(new Event(Event.COMPLETE));
			
			properties._externalHandler.call();
		}
				
		//----------------------------------
		//  EVENT DISPATCHER METHODS
		//----------------------------------
		
		/**
		 *	@private
		 *  
		 */
		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, weakRef : Boolean = false) : void {
			
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, weakRef);
		}
		
		/**
		 *	@private
		 *  
		 */
		public function dispatchEvent(event : Event) : Boolean {
			
			return _eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 *	@private
		 *  
		 */
		public function hasEventListener(type : String) : Boolean {
			
			return _eventDispatcher.hasEventListener(type);
		}
		
		/**
		 *	@private
		 *  
		 */
		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 *	@private
		 *  
		 */
		public function willTrigger(type : String) : Boolean {
		
			return _eventDispatcher.willTrigger(type);
		}
		
		//----------------------------------
		//  PROXY METHODS
		//----------------------------------
		
		/**
		 *	@private
		 *  
		 */
		override flash_proxy function getProperty(name : *) : * {
			return _properties.applicationSettings[name];
		}
		
		/**
		 *	@private
		 *  
		 */
		override flash_proxy function callProperty(name : *, ... rest) : * {
			var _item : Object = new Object(); 
			
			return _item[name].apply(_item, rest);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
	}
}

class SingletonEnforcer {
}