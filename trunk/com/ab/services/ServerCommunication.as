
package com.ab.services
{
	/**
	* @author
	* ABº
	* 
	* IF YOU USE AMFPHP YOU KNOW HOW TO USE THIS CLASS
	*/
	
	import flash.display.MovieClip;
	
	import com.edigma.services.ServiceProxy
	
	import com.niarbtfel.remoting.events.ResultEvent
	import com.niarbtfel.remoting.events.FaultEvent
	
	import com.edigma.web.EdigmaCore
	
	public class ServerCommunication 
	{
		///////////////////////////////////////// VARS
		
		public static var __singleton:ServerCommunication
		
		private var _LISTAR_CALLER:MovieClip;
		private var _HIERARQUIA_CALLER:MovieClip;
		private var _INSERIR_CALLER:MovieClip;
		
		private var _LISTAR_BUSY:Boolean;
		private var _INSERIR_BUSY:Boolean;
		private var _HIERARQUIA_BUSY:Boolean;
		
		public var _ID_CLIENTE:Number = 117;
		
		///////////////////////////////////////// CONSTRUCTOR
		
		public function ServerCommunication()
		{
			setSingleton()
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		//////////////////////////////////////////////////////////////////////////////// SINGLETON START
		
		private function setSingleton():void
		{
			if (__singleton != null) 
			{
				throw new Error("ServerCommunication ::: SINGLETON REPLICATION ATTEMPTED")
			}
			
			__singleton = this
		}
		
		public static function getSingleton():ServerCommunication
		{
			if (__singleton == null)
			{
				throw new Error("ServerCommunication ::: SINGLETON DOES NOT EXIST (CORE FAILED TO INITIALIZE?)")
			}
			
			return __singleton;
		}
		
		//////////////////////////////////////////////////////////////////////////////// SINGLETON END
		//////////////////////////////////////////////////////////////////////////////// SINGLETON END
		
		
		//////////////////////////////////////////////////////////////////////////////// SERVER REQUESTS
		//////////////////////////////////////////////////////////////////////////////// SERVER REQUESTS
		
		public function listarRequest(resultFunction:Function, id_categoria:*, lang:Number=NaN):void
		{
			_LISTAR_BUSY = true
			
			var a:Array = new Array();
			
			
			a['id_cliente'] = EdigmaCore.getSingleton()._ID_CLIENTE;
			//a['id_cliente'] = _ID_CLIENTE;
			a['id_categoria'] = id_categoria
			
			if (!isNaN(lang))
			{
				a['id_lingua'] = lang
			}
			
			ServiceProxy.getInstance().callRemoteMethod("listar", [a], resultFunction, listarFaultHandler);
		}
		
		public function hierarquiaRequest(resultFunction:Function, referencia_hierarquia:String, lang:Number=NaN):void
		{
			_HIERARQUIA_BUSY = true
			
			var a:Array = new Array();
			
			//a['id_cliente'] = _ID_CLIENTE;
			a['id_cliente'] = EdigmaCore.getSingleton()._ID_CLIENTE;
			a['referencia'] = referencia_hierarquia
			
			if (!isNaN(lang))
			{
				a['id_lingua'] = lang
			}
			
			ServiceProxy.getInstance().callRemoteMethod("hierarquiasArvore", [a], resultFunction, hierarquiaFaultHandler);
		}
		
		public function inserir_item(resultFunction:Function, referencia_hierarquia:String, campos:Array, np_grupo:String, np_utilizador:String, categorias:Array, activo:Boolean, lang:Number=NaN):void
		{
			_INSERIR_BUSY = true
			
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.getSingleton()._ID_CLIENTE;
			//a['id_cliente'] = _ID_CLIENTE;
			a['np_grupo'] = np_grupo;
			a['np_utilizador'] = np_utilizador
			a['categorias'] = categorias		
			a['campos'] = campos;
			
			if (!isNaN(lang))
			{
				a['id_lingua'] = lang
			}
			
			if (activo == true) { a['activo'] = "S" } else { a['activo'] = "N" }
			
			ServiceProxy.getInstance().callRemoteMethod("inserir_item", [a], resultFunction, inserirFaultHandler);
		}
		
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULTS
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULTS
		/*
		private function listarResultHandler(re:ResultEvent):void // inserir parametro
		{
			if (re.result != null)
			{
				trace("ServerCommunication ::: listarResultHandler() ::: re.result VALID")
				
				// preloader off
			}
			
			_LISTAR_BUSY = false
		}   
		
		private function hierarquiaResultHandler(re:ResultEvent):void // inserir parametro
		{
			if (re.result != null)
			{
				trace("ServerCommunication ::: hierarquiaResultHandler() ::: re.result VALID")
				
				// preloader off
			}
			
			_HIERARQUIA_BUSY = false
		}   
		
		private function inserirResultHandler(re:ResultEvent):void // inserir parametro
		{
			if (re.result != null)
			{
				trace("ServerCommunication ::: inserirResultHandler() ::: re.result VALID")
				
				// preloader off
			}
			
			_INSERIR_BUSY = false
		}
		*/
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULT FAULTS
		//////////////////////////////////////////////////////////////////////////////// SERVER RESULT FAULTS
		
		private function listarFaultHandler(e:FaultEvent):void // inserir parametro
		{
			trace("ServerCommunication ::: listarFaultHandler()")
			
			// preloader off
			
			_LISTAR_BUSY = false
		}
		
		private function hierarquiaFaultHandler(e:FaultEvent):void // inserir parametro
		{
			trace("ServerCommunication ::: hierarquiaFaultHandler()")
			
			// preloader off
			
			_HIERARQUIA_BUSY = false
		}
		
		private function inserirFaultHandler(e:FaultEvent):void // inserir parametro
		{
			trace("ServerCommunication ::: inserirFaultHandler()")
			
			// preloader off
			
			_INSERIR_BUSY = false
		}
		
	}
	
}