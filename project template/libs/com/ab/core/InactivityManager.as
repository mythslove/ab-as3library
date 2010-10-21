package com.ab.core
{
	/**
	* @author ABº
	* 
	* @EDIGMACOM
	*/
	
	import org.casalib.time.Inactivity;
	import org.casalib.events.InactivityEvent;
	import com.ab.core.AppManager;
	
	public class InactivityManager 
	{
		public var _inactivity:Inactivity
		private var _userActive:Boolean = true;
		
		private var _user_Active_functionCall:Function;
		private var _user_inActive_functionCall:Function;
		
		public function InactivityManager(time:int, active_function:Function, inactive_function:Function)
		{
			_user_Active_functionCall 	= active_function;
			_user_inActive_functionCall = inactive_function;
			
			_inactivity = new Inactivity(time)
			_inactivity.addEventListener(InactivityEvent.INACTIVE, onUserInactive);
			_inactivity.addEventListener(InactivityEvent.ACTIVATED, onUserActivated);
			_inactivity.start();
		}
		
		public function onUserActivated(e:InactivityEvent):void 
		{
			trace("User active after being inactive for " + e.milliseconds + " milliseconds.");
			
			_user_Active_functionCall();
			
			this.userActive = true;
		}
		public function onUserInactive(e:InactivityEvent):void 
		{
			trace("User inactive for " + e.milliseconds + " milliseconds.");
			
			_user_inActive_functionCall();
			
			this.userActive = false;
		}
		
		public function die():void 
		{
			_inactivity.stop();
			_inactivity.removeEventListener(InactivityEvent.INACTIVE, onUserInactive);
			_inactivity.removeEventListener(InactivityEvent.ACTIVATED, onUserActivated);
		}
		
		public function get userActive():Boolean 			{ return _userActive; }
		public function set userActive(value:Boolean):void  { _userActive = value; }
		
	}
	
}