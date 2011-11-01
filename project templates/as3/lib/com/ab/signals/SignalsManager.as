package com.ab.signals 
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
		
		/// done
		public function addSignal(signal_id:String, ...valueClasses):SignalsManagerItem
		{
			// create signal
			var newsignal:Signal							= new Signal(valueClasses);			
			// create signal manager item
			var newsignalsmanageritem:SignalsManagerItem 	= new SignalsManagerItem();
			// feed signal manager item
			newsignalsmanageritem.signal 					= newsignal;
			newsignalsmanageritem.signal_id 				= signal_id;
			// store signal manager item in array
			signals[signals.length] 						= newsignalsmanageritem;
			
			return newsignalsmanageritem;
		}
		
		/// done
		public function addSignalAndListener(signal_id:String, listener:Function, ...valueClasses):void
		{
			var newsignal:Signal							= new Signal(valueClasses);
			var newsignalsmanageritem:SignalsManagerItem 	= new SignalsManagerItem();
			newsignalsmanageritem.signal 					= newsignal;
			newsignalsmanageritem.signal_id 				= signal_id;
			signals[signals.length] 						= newsignalsmanageritem;
			newsignal.add(listener);
		}
		
		/// done
		public function addListenerToSignal(signal_id:String, listener:Function):void
		{
			var success:Boolean = false;
			
			for (var i:int = 0; i < signals.length; i++) 
			{
				if (SignalsManagerItem(signals[i]).signal_id == signal_id) 
				{
					SignalsManagerItem(signals[i]).signal.add(listener);
					
					success = true;
				}	
			}
			
			if (!success)  { trace("WARNING ::: couldn't add listener to signal (id = " + signal_id + " )"); }
		}
		
		/// done
		public function removeSignal(signal_id:String):void
		{
			var success:Boolean = false;
			
			for (var i:int = 0; i < signals.length; i++) 
			{
				if (signals[i].signal_id == signal_id)   
				{
					Signal(signals[i].signal).removeAll();
					
					signals[i] 				= null;
					var removed_signal:* 	= signals.splice(i, 1);
					removed_signal 			= null;
					success 				= true;
				}
			}
			
			if (!success)	{ trace("WARNING ::: failed to remove signal (id = " + signal_id + " )"); }
		}
		
		public function dispatch(signal_id:String, ...valueObjects):void
		{
			var success:Boolean = false;
			
			for (var i:int = 0; i < signals.length; i++) 
			{
				if (SignalsManagerItem(signals[i]).signal_id == signal_id) 
				{
					Signal(SignalsManagerItem(signals[i]).signal).tweakedDispatch(valueObjects);
					
					success = true;
				}	
			}
			
			if (!success)  { trace("WARNING ::: couldn't dispatch signal (id = " + signal_id + " )"); }
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void { if (__singleton == null)  { __singleton = this } }
		
		public static function get singleton():SignalsManager { if (__singleton == null) { __singleton = new SignalsManager() };  return __singleton; }
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}

}