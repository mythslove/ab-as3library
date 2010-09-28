
/**
* @author ABº
* @version 1.0
*/

package com.edigma.services
{
	import com.niarbtfel.remoting.*
	import com.niarbtfel.remoting.cache.RemotingCache;
	import com.niarbtfel.remoting.events.*
	import com.edigma.web.EdigmaCore;
	import com.edigma.ui.AlertWindow;
	
    public class ServiceProxyForms
	{
		private static var singleton : ServiceProxyForms
        
        // Remoting Service
		private var _conn:RemotingConnection
        private var _serv:RemotingService;
		//public var _AMF_PATH:String = "http://amf.edigma.com/flashservices/gateway.php";
		//public var _AMF_FILE:String = "np_services_v1";
		
		/**
		 * @return unique instance of ApplicationInfo
		 */
		
        public static function getInstance() : ServiceProxyForms
        {
            if ( singleton == null )
                singleton = new ServiceProxyForms( arguments.callee );
            return singleton;
        }
		
		
        public function ServiceProxyForms( caller : Function = null )
        {
            if( caller != ServiceProxyForms.getInstance ){
                throw new Error ("ServiceProxyForms ::: ServiceProxyForms is a singleton class, use getInstance() instead");
			}else if ( ServiceProxyForms.singleton != null ){
				throw new Error( "ServiceProxyForms ::: Only one ServiceProxyForms instance should be instantiated" );	
			}else {
				init();
			}
        }
		
		private function init():void
		{
            // init connection  
			//_conn = new RemotingConnection(EdigmaCore.singleton._AMF_PATH, 0);
			_conn = new RemotingConnection(EdigmaCore.singleton.AMF_PATH, 0);
			_conn.addEventListener(ConnectionEvent.CONNECTED, onConnectHandler);
			_conn.addEventListener(ConnectionEvent.FAILED, onConnectFailedHandler);
			_conn.addEventListener(ConnectionEvent.DISCONNECT, onDisconnectHandler);
			_conn.addEventListener(ConnectionEvent.FORMAT_ERROR, onFormatErrorHandler);
			_conn.addEventListener(ConnectionEvent.SECURITY_ERROR, onSecurityHandler);
			
			//init service
			_serv = new RemotingService(_conn, "np_services_v1_forms", 10000, 1, true);
			//_serv = new RemotingService(_conn, _AMF_FILE, 10000, 1, true);
			_serv.addEventListener(CallEvent.TIMEOUT, onTimeoutHandler);
			_serv.addEventListener(CallEvent.RETRY, onRetryHandler);
			_serv.addEventListener(CallEvent.REQUEST_SENT, onRequestSentHandler);
			_serv.addEventListener(CallEvent.SERVICE_HALTED, onServicehaltedHandler);
			//_serv.remotingCache = new RemotingCache(-1);	
		}
		
		/**
		 * 
		 * @param	s service to call
		 * @param	a associative array of parameters
		 * @param	rf result function 
		 * @param	ff fault function
		 */
        //call remote method
		public function callRemoteMethod(s:String, a:Array, rf:Function, ff:Function):void
		{
			init()
			_serv.apply(s, a, rf, ff, false);
		}
		
		//connection handlers
		private function onConnectHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxyForms ::: service connected");
		}
		private function onConnectFailedHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxyForms ::: service connectionFailed");
		}
		private function onDisconnectHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxyForms ::: service disconnected");
		}
		private function onFormatErrorHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxyForms ::: service format error");
		}
		private function onSecurityHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxyForms ::: service security error");
		}
		
		//service handlers
		private function onTimeoutHandler(e:CallEvent):void
		{
			trace("ServiceProxyForms ::: service timeout" );
		}			
		private function onRetryHandler(e:CallEvent):void
		{
			trace("ServiceProxyForms ::: service retry call");
		}
		private function onRequestSentHandler(e:CallEvent):void
		{
			trace("ServiceProxyForms ::: service request sent");
		}	
		private function onServicehaltedHandler(e:CallEvent):void
		{
			trace("ServiceProxyForms ::: service halted");
		}
    }
}
