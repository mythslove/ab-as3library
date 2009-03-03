
/**
* @author ABº
* @version 1.0
*/

package com.ab.services
{
	import com.niarbtfel.remoting.*
	import com.niarbtfel.remoting.cache.RemotingCache;
	import com.niarbtfel.remoting.events.*
	import com.edigma.web.EdigmaCore;
	import com.edigma.ui.AlertWindow;
	
    public class ServiceProxy
	{
		private static var singleton : ServiceProxy
        
        // Remoting Service
		private var _conn:RemotingConnection
        private var _serv:RemotingService;
		public var _AMF_PATH:String = "http://www.antoniobrandao.com/amfphp/gateway.php";
		public var _AMF_FILE:String = "ab_services";
		
		/**
		 * @return unique instance of ApplicationInfo
		 */
		
        public static function getInstance() : ServiceProxy
        {
            if ( singleton == null )
                singleton = new ServiceProxy( arguments.callee );
            return singleton;
        }
		
		
        public function ServiceProxy( caller : Function = null )
        {
            if( caller != ServiceProxy.getInstance ){
                throw new Error ("ServiceProxy ::: ServiceProxy is a singleton class, use getInstance() instead");
			}else if ( ServiceProxy.singleton != null ){
				throw new Error( "ServiceProxy ::: Only one ServiceProxy instance should be instantiated" );	
			}else {
				init();
			}
        }
		
		private function init():void
		{
            // init connection 
			_conn = new RemotingConnection(_AMF_PATH, 0);
			_conn.addEventListener(ConnectionEvent.CONNECTED, onConnectHandler);
			_conn.addEventListener(ConnectionEvent.FAILED, onConnectFailedHandler);
			_conn.addEventListener(ConnectionEvent.DISCONNECT, onDisconnectHandler);
			_conn.addEventListener(ConnectionEvent.FORMAT_ERROR, onFormatErrorHandler);
			_conn.addEventListener(ConnectionEvent.SECURITY_ERROR, onSecurityHandler);
			
			//init service
			_serv = new RemotingService(_conn, _AMF_FILE, 10000, 1, true);
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
			trace("ServiceProxy ::: service connected");
		}
		private function onConnectFailedHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxy ::: service connectionFailed");
		}
		private function onDisconnectHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxy ::: service disconnected");
		}
		private function onFormatErrorHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxy ::: service format error");
		}
		private function onSecurityHandler(e:ConnectionEvent):void
		{
			trace("ServiceProxy ::: service security error");
		}
		
		//service handlers
		private function onTimeoutHandler(e:CallEvent):void
		{
			trace("ServiceProxy ::: service timeout" );
		}			
		private function onRetryHandler(e:CallEvent):void
		{
			trace("ServiceProxy ::: service retry call");
		}
		private function onRequestSentHandler(e:CallEvent):void
		{
			trace("ServiceProxy ::: service request sent");
		}	
		private function onServicehaltedHandler(e:CallEvent):void
		{
			trace("ServiceProxy ::: service halted");
		}
    }
}
