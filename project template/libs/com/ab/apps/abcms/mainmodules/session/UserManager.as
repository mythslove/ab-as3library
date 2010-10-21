package com.ab.apps.abcms.mainmodules.session 
{
	/**
	* @author ABº
	*/
	
	public class UserManager 
	{
		public static var __singleton:UserManager
		
		private var _user_id:int;
		private var _logged_in:Boolean = false;
		
		public function UserManager() 
		{
			setSingleton()
		}
		
		public function perform_login(user:String, pass:String) 
		{
			/// check data
			
			
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("UserManager ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function get singleton():UserManager
		{
			if (__singleton == null)
			{
				throw new Error("UserManager ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		/// /////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
}