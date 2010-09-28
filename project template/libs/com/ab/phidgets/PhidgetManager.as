package com.ab.phidgets
{
	/**
	* @author ABº
	* http://www.antoniobrandao.com/
	* http://blog.antoniobrandao.com/
	* 
	* This class manages all info collected from the XML
	* and provides central data collection system
	* 
	* Dependencies: Phidgets API Library ( http://www.phidgets.com/programming_resources.php )
	* 
	* usage:
	* 
	* 1 - import class
	* import com.ab.phidgets.PhidgetManager
	* 
	* 2 - create a var
	* public var _phidgetManagerVar:PhidgetManager;
	* 
	* 3 - start phidget manager
	* phidgetManager = new PhidgetManager();
	* 
	* 
	* to change values
	* 
	* _phidgetManagerVar.PHIDGET_HOST = *;        (string)
	* _phidgetManagerVar.PHIDGET_PORT = *;        (int)
	* _phidgetManagerVar.PHIDGET_THRESHOLD = *;  (int)
	* 
	* *your own values
	*/
	
	import com.phidgets.*;
	import com.phidgets.events.*
	
	import flash.events.*;
	import flash.display.Sprite;
	
	public class PhidgetManager extends Sprite
	{
		public static var __singleton:PhidgetManager;
		public var _phid:PhidgetInterfaceKit;
		
		private var _PHIDGET_PORT:int = 5001;
		private var _PHIDGET_HOST:String = "localhost";
		private var _PHIDGET_THRESHOLD:int = 900;
		private var _ACTIVE_SENSOR:int = -1;
		
		private var _SENSORS_VALUES:Array;
		
		public function PhidgetManager()
		{
			initVars()
			initPhidget();
			setSingleton();
		}
		
		private function initVars():void
		{
			_SENSORS_VALUES = new Array()
			_SENSORS_VALUES[0] = 0;
			_SENSORS_VALUES[1] = 0;
			_SENSORS_VALUES[2] = 0;
			_SENSORS_VALUES[3] = 0;
			_SENSORS_VALUES[4] = 0;
			_SENSORS_VALUES[5] = 0;
			_SENSORS_VALUES[6] = 0;
			_SENSORS_VALUES[7] = 0;
		}
		
		public function get PHIDGET_HOST():String 				{ return _PHIDGET_HOST;       }
		public function set PHIDGET_HOST(value:String):void  	{ _PHIDGET_HOST = value;      }
		
		public function get ACTIVE_SENSOR():int 				{ return _ACTIVE_SENSOR;      }
		public function set ACTIVE_SENSOR(value:int):void  		{ _ACTIVE_SENSOR = value; onActiveObjectChange(); }
		
		public function get PHIDGET_PORT():int 					{ return _PHIDGET_PORT;       }
		public function set PHIDGET_PORT(value:int):void  		{ _PHIDGET_PORT = value;      }
		
		public function get PHIDGET_THRESHOLD():int 			{ return _PHIDGET_THRESHOLD;  }
		public function set PHIDGET_THRESHOLD(value:int):void 	{ _PHIDGET_THRESHOLD = value; }
		
		private function initPhidget():void
		{
			/// instanciação relativa à placa a ser usada
			_phid = new PhidgetInterfaceKit();
			
			/// all event listeners
			_phid.addEventListener(PhidgetEvent.CONNECT,			onConnect);
			_phid.addEventListener(PhidgetEvent.DISCONNECT, 		onDisconnect);
			_phid.addEventListener(PhidgetEvent.DETACH,				onDetach);
			_phid.addEventListener(PhidgetEvent.ATTACH,				onAttach);
			_phid.addEventListener(PhidgetErrorEvent.ERROR, 		onError);
			_phid.addEventListener(PhidgetDataEvent.INPUT_CHANGE, 	onInputChange);
			_phid.addEventListener(PhidgetDataEvent.OUTPUT_CHANGE, 	onOutputChange);
			_phid.addEventListener(PhidgetDataEvent.SENSOR_CHANGE, 	onSensorChange);
			
			this.addEventListener(Event.CHANGE, 					onActiveObjectChange);
			
			/// connect phidget
			_phid.open(String(_PHIDGET_HOST), uint(_PHIDGET_PORT))
		}
		
		private function onSensorChange(evt:PhidgetDataEvent):void
		{
			trace ("PhidgetManager ::: onSensorChange() ::: ACTIVE_SENSOR BEFORE: " + _ACTIVE_SENSOR + " & Data: " + evt.Data );
			
			_SENSORS_VALUES[evt.Index] = evt.Data;
			
			parseValues()
		}
		
		private function parseValues():void
		{
			var _highestValue:Number = 0;
			var _highestValueIndex:Number = 0;
			
			for (var i:int = 0; i < _SENSORS_VALUES.length; i++) 
			{
				if (_SENSORS_VALUES[i] > _highestValue)
				{
					_highestValue = _SENSORS_VALUES[i];
					_highestValueIndex = i;
				}
			}
			
			if (_highestValue > _PHIDGET_THRESHOLD)
			{
				if (_highestValueIndex != _ACTIVE_SENSOR)
				{
					/// trace("CHANGING NEW ACTIVE SENSOR");
					
					this.ACTIVE_SENSOR = _highestValueIndex;
				}
			}
			else
			{
				this.ACTIVE_SENSOR = -1;
			}
			
			trace ("PhidgetManager ::: onSensorChange() ::: ACTIVE_SENSOR AFTER: " + _ACTIVE_SENSOR);
		}
		
		private function onActiveObjectChange():void 
		{ 
			//trace ("PhidgetManager ::: dispatching event _ACTIVE_SENSOR = " + _ACTIVE_SENSOR );  
			
			/// example: dispatchEvent
		}
		
		private function onDetach(evt:PhidgetEvent):void 			
		{
			//trace ("PhidgetManager ::: onDetach evt = " + evt );  
		}
		
		private function onDisconnect(evt:PhidgetEvent):void 		
		{ 
			//trace ("PhidgetManager ::: onDisconnect evt = " + evt );
			
			/// phidgets sometimes disconnect so we should reconnect
			
			restartPhidget()
		}
		
		private function onError(evt:PhidgetErrorEvent):void  		
		{ 
			//trace ("PhidgetManager ::: onError ::: evt = " + evt);
		}
		
		private function restartPhidget():void
		{
			//trace ("PhidgetManager ::: restartPhidget()"); 
			
			/// reconnect phidget
			_phid.open(String(_PHIDGET_HOST), uint(_PHIDGET_PORT))
		}
		
		private function onConnect(evt:PhidgetEvent):void 			{ trace ("PhidgetManager ::: onConnect evt = " + evt );  				}
		private function onInputChange(evt:PhidgetDataEvent):void 	{ trace ("PhidgetManager onInputChange() ::: index = " 	+ evt.Index );  }
		private function onOutputChange(evt:PhidgetDataEvent):void 	{ trace ("PhidgetManager onOutputChange() ::: evt = " + evt.Index );  	}
		
		function onAttach(evt:PhidgetEvent):void
		{
			trace(evt);
			
			trace ("PhidgetManager ::: onAttach ::: phid.Name = " 			+ _phid.Name ); 
			trace ("PhidgetManager ::: onAttach ::: phid.serialNumber = " 	+ _phid.serialNumber ); 
			trace ("PhidgetManager ::: onAttach ::: phid.Version = " 		+ _phid.Version ); 
			trace ("PhidgetManager ::: onAttach ::: phid.OutputCount = " 	+ _phid.OutputCount ); 
			trace ("PhidgetManager ::: onAttach ::: phid.InputCount = " 	+ _phid.InputCount ); 
			trace ("PhidgetManager ::: onAttach ::: phid.SensorCount = " 	+ _phid.SensorCount );
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("PhidgetManager ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():PhidgetManager
		{
			if (__singleton == null)
			{
				throw new Error("PhidgetManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
}