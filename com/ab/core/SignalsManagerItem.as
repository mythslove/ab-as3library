package com.ab.core 
{
	/**
	* @author AB
	*/
	
	import org.osflash.signals.Signal;
	
	public class SignalsManagerItem extends Object
	{
		private var _signal:Signal;
		private var _signal_id:Signal;
		
		public function SignalsManagerItem()
		{
			
		}
		
		public function get signal():Signal 				{ return _signal;  }
		public function set signal(value:Signal):void  		{ _signal = value; }
		
		public function get signal_id():Signal 				{ return _signal_id;  }
		public function set signal_id(value:Signal):void  	{ _signal_id = value; }
		
	}

}