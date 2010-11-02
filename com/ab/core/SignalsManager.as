package com.ab.core 
{
	/**
	* @author AB
	*/
	
	import org.osflash.signals.Signal;
	
	public class SignalsManager 
	{
		private static var __singleton:SignalsManager 
		
		protected var signals:Array = new Array;
		
		public function SignalsManager() 
		{
			setSingleton();
		}
		
		public function addSignal(signal_id:String, ...valueClasses):Signal
		{
			/// create signal
			var newsignal 					= new Signal(valueClasses);
			
			/// create signal manager item
			var newsignalmanageritem:SignalsManagerItem = new SignalsManagerItem();
			
			/// feed signal manager item
			newsignalmanageritem.signal 	= newsignal;
			newsignalmanageritem.signal_id 	= signal_id;
			
			/// store signal manager item in array
			signals[signals.length] 		= newsignal;
			
			return newsignal;
		}
		
		public function addSignalAndListener(signal_id:String, listener:Function, ...valueClasses):void
		{
			var newsignal:Signal = addSignal(signal_id, valueClasses);
			
			newsignal.add(listener);
		}
		
		public function addListenerToSignal(signal_id:String, listener:Function)
		{
			for (var i:int = 0; i < signals.length; i++) 
			{
				if (signals[i].signal_id == signal_id) 
				{
					signals[id].signal.add(listener);
				}	
			}
			///else { trace("SIGNAL IS NULL?"); };
		}
		
		public function removeSignal(signal_id:String)
		{
			var index:int = signals.indexOf(signals[signal_id]);
			
			if (index != -1)
			{
				listeners.splice(index, 1);
				delete onceListeners[listener];
			}
		}
		
		public function addListener(listener:Function, signal:Signal, )
		{
			
		}
		
		public function dispatch(signal:Signal, ...args:*)
		{
			
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void { if (__singleton == null)  { __singleton = this } }
		
		public static function get singleton():SignalsManager { if (__singleton == null) { __singleton = new SignalsManager() };  return __singleton; }
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}

}