package com.ab.services
{
	/**
	* @author ABº
	* @version 1.0
	*/
	
	import com.niarbtfel.remoting.*
	import com.niarbtfel.remoting.cache.RemotingCache;
	import com.niarbtfel.remoting.events.*
	
    public class UploadServiceProxy
	{
		private static var singleton:UploadServiceProxy
        
        // Remoting Service
		private var _conn:RemotingConnection
        private var _serv:RemotingService;
		private var _PATH_AMF:String = "http://www.antoniobrandao.com/amfphp/gateway.php";
		//private var _PATH_AMF:String = "http://amf.edg.pt/flashservices/gateway.php";
		
		/**
		 * 
		 * @return unique instance of ApplicationInfo
		 */
		
        public static function getInstance() : UploadServiceProxy
        {
            if ( singleton == null )
                singleton = new UploadServiceProxy( arguments.callee );
            return singleton;
        }
		
		
        public function UploadServiceProxy( caller : Function = null )
        {
            if( caller != UploadServiceProxy.getInstance ){
                throw new Error ("UploadServiceProxy ::: UploadServiceProxy is a singleton class, use getInstance() instead");
			}else if ( UploadServiceProxy.singleton != null ){
				throw new Error( "UploadServiceProxy ::: Only one UploadServiceProxy instance should be instantiated" );	
			}else {
				init();
			}
        }
		
		private function init():void
		{
            // init connection  
			_conn = new RemotingConnection(_PATH_AMF, 0);
			_conn.addEventListener(ConnectionEvent.CONNECTED, onConnectHandler);
			_conn.addEventListener(ConnectionEvent.FAILED, onConnectFailedHandler);
			_conn.addEventListener(ConnectionEvent.DISCONNECT, onDisconnectHandler);
			_conn.addEventListener(ConnectionEvent.FORMAT_ERROR, onFormatErrorHandler);
			_conn.addEventListener(ConnectionEvent.SECURITY_ERROR, onSecurityHandler);
			
			//init service
			_serv = new RemotingService(_conn,"upload",10000,1,true);
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
			trace("UploadServiceProxy ::: service connected");
		}
		private function onConnectFailedHandler(e:ConnectionEvent):void
		{
			trace("UploadServiceProxy ::: service connectionFailed");
		}
		private function onDisconnectHandler(e:ConnectionEvent):void
		{
			trace("UploadServiceProxy ::: service disconnected");
		}
		private function onFormatErrorHandler(e:ConnectionEvent):void
		{
			trace("UploadServiceProxy ::: service format error");
		}
		private function onSecurityHandler(e:ConnectionEvent):void
		{
			trace("UploadServiceProxy ::: service security error");
		}
		
		//service handlers
		private function onTimeoutHandler(e:CallEvent):void
		{
			trace("UploadServiceProxy ::: service timeout" );
		}			
		private function onRetryHandler(e:CallEvent):void
		{
			trace("UploadServiceProxy ::: service retry call");
		}
		private function onRequestSentHandler(e:CallEvent):void
		{
			trace("UploadServiceProxy ::: service request sent");
		}	
		private function onServicehaltedHandler(e:CallEvent):void
		{
			trace("UploadServiceProxy ::: service halted");
		}
		
    }
	
}
