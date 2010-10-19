package com.ab.utils 
{
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	* 
	* use this class to control activity / inactivity
	* 
	* @Dependencies:
	* 
	* StageReference Class by CASALIB Library ( http://casalib.org )
	*/
	
	import org.casalib.time.Inactivity;
	import org.casalib.events.InactivityEvent;
	import ecomuseu.app.PhidgetManager;
	import ecomuseu.app.AppManager;
	
	public class InactivityManager 
	{
		public var _inactivity:Inactivity
		private var _userActive:Boolean = true;
		
		public function InactivityManager(time:int)
		{
			_inactivity = new Inactivity(time)
			_inactivity.addEventListener(InactivityEvent.INACTIVE, onUserInactive);
			_inactivity.addEventListener(InactivityEvent.ACTIVATED, onUserActivated);
			//_inactivity.start();
		}
		
		public function onUserInactive(e:InactivityEvent):void 
		{
			trace("User inactive for " + e.milliseconds + " milliseconds.");
			
			/// perform some function
			
			this.userActive = false;
		}
		
		public function onUserActivated(e:InactivityEvent):void 
		{
			trace("User active after being inactive for " + e.milliseconds + " milliseconds.");
			
			/// perform some function
			
			this.userActive = true;
		}
		
		public function get userActive():Boolean 			{ return _userActive; }
		public function set userActive(value:Boolean):void  { _userActive = value; }
		
	}
	
}