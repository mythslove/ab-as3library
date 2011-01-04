package com.ab.services
{
	/**
	* @author ABº
	* 
	* This class was built to suit my own server services it might not suit your needs
	*/
	
	import flash.display.MovieClip;
	
	import com.ab.services.ServiceProxy
	import com.ab.services.UploadServiceProxy
	
	import com.niarbtfel.remoting.events.ResultEvent
	import com.niarbtfel.remoting.events.FaultEvent
	
	
	public class ABServerCommunication 
	{
		public static var __singleton:ABServerCommunication
		
		public function ABServerCommunication()
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
			trace("ABServerCommunication ::: listSectionItemsRequest()")
			
			var a:Array = new Array();
			
			a["id"] = value;
			
			ServiceProxy.getInstance().callRemoteMethod("listSections", [a], resultFunction, faultHandler);
		}
		
		public function listSectionsRequest(cat_id:int, resultFunction:Function):void
		{
			
			trace("ABServerCommunication ::: listSectionItemsRequest()")
			
			var a:Array = new Array();
			
			a["id"] = cat_id;
			
			ServiceProxy.getInstance().callRemoteMethod("listSections", [a], resultFunction, faultHandler);
		}
		
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULT FAULTS
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULT FAULTS
		
		private function faultHandler(e:FaultEvent):void // inserir parametro
		{
			trace ("ABServerCommunication ::: faultHandler() ::: e.fault = " + e.fault );
		}
		
		private function inserirFaultHandler(e:FaultEvent):void // inserir parametro
		{
			trace("ABServerCommunication ::: inserirFaultHandler()")
			
			// preloader off
		}
		
		/// SINGLETON START
		/// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("ABServerCommunication ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function get singleton():ABServerCommunication
		{
			if (__singleton == null)
			{
				throw new Error("ABServerCommunication ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		/// SINGLETON END
		/// SINGLETON END
		
	}
	
}