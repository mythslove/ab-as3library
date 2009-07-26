package com.ab.services 
{
	/**
	* @author ABº
	*/
	
	import flash.display.MovieClip;
	
	import com.ab.services.ServiceProxy
	import com.ab.services.UploadServiceProxy
	
	import com.niarbtfel.remoting.events.ResultEvent
	import com.niarbtfel.remoting.events.FaultEvent
	
	
	public class ServerCommunication 
	{
		public static var __singleton:ServerCommunication
		
		public function ServerCommunication()
		{
			setSingleton();
		}
		
		/// SERVER REQUESTS
		/// SERVER REQUESTS
		
		public function uploadRequest(param:String, resultFunction:Function):void
		{
			var a:Array = new Array();
			
			a['file'] = param;
			
			UploadServiceProxy.getInstance().callRemoteMethod("uploadfile", [a], resultFunction, faultHandler);
		}
		
		public function listSections(value:Number, resultFunction:Function):void
		{
			trace("ServerCommunication ::: listSectionItemsRequest()")
			
			var a:Array = new Array();
			
			a["id"] = value;
			
			ServiceProxy.getInstance().callRemoteMethod("listSections", [a], resultFunction, faultHandler);
		}
		
		public function listSectionsRequest(cat_id:int, resultFunction:Function):void
		{
			
			trace("ServerCommunication ::: listSectionItemsRequest()")
			
			var a:Array = new Array();
			
			a["id"] = cat_id;
			
			ServiceProxy.getInstance().callRemoteMethod("listSections", [a], resultFunction, faultHandler);
		}
		
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULT FAULTS
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULT FAULTS
		
		private function faultHandler(e:FaultEvent):void // inserir parametro
		{
			trace ("ServerCommunication ::: faultHandler() ::: e.fault = " + e.fault );
		}
		
		private function inserirFaultHandler(e:FaultEvent):void // inserir parametro
		{
			trace("ServerCommunication ::: inserirFaultHandler()")
			
			// preloader off
		}
		
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		/// /////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("ServerCommunication ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function get singleton():ServerCommunication
		{
			if (__singleton == null)
			{
				throw new Error("ServerCommunication ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// ///////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// ///////////////////////////////////////////////////////////////////////////// SINGLETON END
		
	}
	
}