
package com.edigma.services
{
	/**
	* @authors
	* 
	* ABº
	* ...
	*/
	
	//import com.ab.as3websystem.core.Core
	import flash.display.MovieClip;
	
	import com.edigma.services.ServiceProxy
	import com.edigma.services.ServiceProxyForms
	
	import com.niarbtfel.remoting.events.ResultEvent
	import com.niarbtfel.remoting.events.FaultEvent
	import org.casalib.util.LocationUtil
	
	import com.edigma.web.EdigmaCore
	import org.casalib.util.StageReference
	
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
		
		//public var ID_CLIENTE:Number = 117;
		private var _NOTIFICATION_BUSY:Boolean;
		
		/// ///////////////////////////////////// CONSTRUCTOR
		
		public function ServerCommunication()
		{
			setSingleton()
		}
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON START
		
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
		
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		/// //////////////////////////////////////////////////////////////////////////// SINGLETON END
		
		
		/// //////////////////////////////////////////////////////////////////////////// SERVER REQUESTS
		/// //////////////////////////////////////////////////////////////////////////// SERVER REQUESTS
		
		public function pesquisar(_kword:String, resultFunction:Function, cats:Array, _lang:int=1, faultFunction:Function=null):void
		{
			var a:Array = new Array();
			
			a['kword'] 			= _kword;
			a['id_cliente'] 	= EdigmaCore.singleton.ID_CLIENTE;
			a['id_categorias'] 	= cats;
			a['id_lingua'] 		= _lang;
			
			ServiceProxy.getInstance().callRemoteMethod("pesquisar_xtra", [a], resultFunction, faultFunction == null ? pesquisarFaultHandler : faultFunction);
		}
		
		public function listarRequest(resultFunction:Function, id_categoria:*, lang:Number=NaN):void
		{
			var a:Array = new Array();
			
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
			a['id_categoria'] = id_categoria
			
			if (!isNaN(lang))
			{
				a['id_lingua'] = lang
			}
			
			ServiceProxy.getInstance().callRemoteMethod("listar", [a], resultFunction, listarFaultHandler);
		}
		
		public function listarRelatedItemsRequest(resultFunction:Function, id_categoria:*, _id_item_rel:Number, lang:Number=NaN):void
		{
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
			a['id_categoria'] = id_categoria;
			a['id_item_rel'] = _id_item_rel;
			
			if (!isNaN(lang))
			{
				a['id_lingua'] = lang;
			}
			
			ServiceProxy.getInstance().callRemoteMethod("listar_rel", [a], resultFunction, listarFaultHandler);
		}
		
		public function listarRelatedFilesRequest(resultFunction:Function, id_categoria:*, _id_item:Number, lang:Number=1, _id_arquivo:Number=1):void
		{
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
			a['id_categoria'] = id_categoria;
			a['id_item'] = _id_item;
			a['id_arquivo'] = _id_arquivo;
			a['id_lingua'] = lang;
			
			ServiceProxy.getInstance().callRemoteMethod("list_files", [a], resultFunction, listarRelatedFilesFaultHandler);
		}
		
		public function hierarquiaRequest(resultFunction:Function, referencia_hierarquia:String, lang:Number=NaN):void
		{
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
			a['referencia'] = referencia_hierarquia
			
			if (!isNaN(lang))
			{
				a['id_lingua'] = lang
			}
			
			ServiceProxy.getInstance().callRemoteMethod("hierarquiasArvore", [a], resultFunction, hierarquiaFaultHandler);
		}
		
		public function inserirItem(resultFunction:Function, referencia_hierarquia:String, campos:Array, np_grupo:String, np_utilizador:String, categorias:Array, activo:Boolean, lang:Number=NaN):void
		{
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
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
		
		public function sendNotification(resultFunction:Function, _assunto:String, _msg:String, faultFunction:Function=null):void
		{
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
			a['fassunto'] = _assunto;
			a['fmsg'] = _msg
			a['dev'] = getDev();
			
			ServiceProxyForms.getInstance().callRemoteMethod("send_notification2", [a], resultFunction, faultFunction == null ? subscriptionFaultHandler : faultFunction);
		}
		
		public function subscribeNewsletter(resultFunction:Function, _nome:String="", _email:String="", faultFunction:Function=null):void
		{
			var b:Array = new Array();
			
			b['femail'] = _email;
			if (_nome != "") { b['fnome'] = _nome };
			
			
			var a:Array = new Array();
			
			a['id_cliente'] = EdigmaCore.singleton.ID_CLIENTE;
			a['values'] = b;
			//a['dev'] = 1;
			a['dev'] = 0;
			
			//var ff:Function = faultFunction == null ? subscriptionFaultHandler : faultFunction
			
			ServiceProxyForms.getInstance().callRemoteMethod("subscribe_newsletter2", [a], resultFunction, faultFunction == null ? subscriptionFaultHandler : faultFunction);
		}
		
		// faultFunction == null ? subscriptionFaultHandler : faultFunction
		
		/// //////////////////////////////////////////////////////////////////////////// SERVER RESULTS
		/// //////////////////////////////////////////////////////////////////////////// SERVER RESULTS
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
		
		private function listarRelatedFilesFaultHandler(e:FaultEvent):void
		{
			trace("ServerCommunication ::: listarRelatedFilesFaultHandler()")
		}
		
		private function pesquisarFaultHandler(e:FaultEvent):void
		{
			trace("ServerCommunication ::: listarFaultHandler()")
		}
		
		private function listarFaultHandler(e:FaultEvent):void
		{
			trace("ServerCommunication ::: listarFaultHandler()")
		}
		
		private function hierarquiaFaultHandler(e:FaultEvent):void
		{
			trace("ServerCommunication ::: hierarquiaFaultHandler()")
		}
		
		private function subscriptionFaultHandler(e:FaultEvent):void
		{
			trace("ServerCommunication ::: subscriptionFaultHandler()")
		}
		
		public function notificationFaultHandler(e:FaultEvent):void
		{
			trace("ServerCommunication ::: notificationFaultHandler()")
		}
		
		private function inserirFaultHandler(e:FaultEvent):void // inserir parametro
		{
			trace("ServerCommunication ::: inserirFaultHandler()")
		}
		
		private function getDev():Number
		{
			if (LocationUtil.isDomain(StageReference.getStage(), "prototipo.edigma.com") || LocationUtil.isDomain(StageReference.getStage(), "proto.edg.pt")) 
			{
				return 1;
			} 
			else 
			{ 
				return 0;
			}
		}
		
	}
	
}