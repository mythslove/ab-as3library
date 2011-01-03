package com.niarbtfel.remoting
{
	
	import flash.events.*;
	import flash.net.NetConnection;
	
	import com.niarbtfel.remoting.events.ConnectionEvent;
	
	/**
	 * Dispatched when a connection success has occured
	 */
	 [Event(name=ConnectionEvent.CONNECTED,type="com.niarbtfel.remoting.events.ConnectionEvent")];
	
	/**
	 * Dispatched when a connection fails.
	 */
	 [Event(name=ConnectionEvent.FAILED,type="com.niarbtfel.remoting.events.ConnectionEvent")];
	
	/**
	 * Dispatched when a connection disconnects.
	 */
	 [Event(name=ConnectionEvent.DISCONNECT,type="com.niarbtfel.remoting.events.ConnectionEvent")];
	
	/**
	 * Dispatched when a security error occurs.
	 */
	 [Event(name=ConnectionEvent.SECURITY_ERROR,type="com.niarbtfel.remoting.events.ConnectionEvent")];
	
	/**
	 * Dispatched when an amf format error occurs.
	 */
	 [Event(name=ConnectionEvent.FORMAT_ERROR,type="com.niarbtfel.remoting.events.ConnectionEvent")];
	
	/**
	 * Simple wrapper class that handles connecting to the
	 * gateway.
	 */
	public class RemotingConnection extends EventDispatcher
	{	
		
		/**
		 * The gateway location.
		 */
		public var gateway:String;
		
		/**
		 * The net connection.
		 */
		public var connection:NetConnection;
		
		/**
		 * New RemotingConnection
		 * 
		 * @param	String		The remoting gateway location.
		 * @param	int			The AMF Object encoding.
		 * @throws Error
		 */
		public function RemotingConnection(gateway:String, objectEncoding:int = 3)
		{
			if(gateway == '')
				throw(new Error("Gateway cannot be null"));
				
			if(objectEncoding != 0 && objectEncoding != 3)
				throw(new Error("Object encoding must be 0 or 3"));
				
			this.gateway = gateway;
			connection = new NetConnection();
			connection.objectEncoding = objectEncoding;
			connection.addEventListener(NetStatusEvent.NET_STATUS, onConnectionStatus);
			connection.addEventListener(IOErrorEvent.IO_ERROR, onConnectionError);
			connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR , onConnectionError);
			connection.connect(gateway);
		}
		
		/**
		 * onConnectionError
		 */
		private function onConnectionError(event:ErrorEvent):void
		{
			connection.close();
			connection = null;
			var ce:ConnectionEvent = new ConnectionEvent(ConnectionEvent.ERROR);
			ce.message = event.text;
			dispatchEvent(ce);
		}
		
		/**
		 * onConnectionStatus
		 */
		private function onConnectionStatus(event:NetStatusEvent):void
		{
			var ce:ConnectionEvent;
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					ce = new ConnectionEvent(ConnectionEvent.CONNECTED);
					ce.message = event.info.code;
					dispatchEvent(ce);
					break;
				case "NetConnection.Connect.Failed":
					ce = new ConnectionEvent(ConnectionEvent.FAILED);
					dispatchEvent(ce);
					break;
				case "NetConnection.Call.BadVersion":
					ce = new ConnectionEvent(ConnectionEvent.FORMAT_ERROR);
					dispatchEvent(ce);
					break;
				case "NetConnection.Call.Prohibited":
					ce = new ConnectionEvent(ConnectionEvent.SECURITY_ERROR);
					ce.message = event.info.code;
					break;
				case "NetConnection.Connect.Closed":
					ce = new ConnectionEvent(ConnectionEvent.DISCONNECT);
					ce.message = event.info.code;
					break;
			}
		}
		
		/**
		 * Whether or not the net connection is connected.
		 * @return		Boolean
		 */
		public function get connected():Boolean
		{
			return connection.connected;
		}
		
		/**
		 * Re-connect.
		 * @return		void
		 */
		public function reConnect():void
		{
			connection.connect(gateway);
		}
	}
}