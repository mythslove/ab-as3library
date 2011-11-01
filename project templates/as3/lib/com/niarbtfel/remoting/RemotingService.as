package com.niarbtfel.remoting
{
	
	import flash.events.*;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy; 
	
	import com.niarbtfel.remoting.events.*;
	import com.niarbtfel.remoting.limiting.RemotingCallLimiter;
	import com.niarbtfel.remoting.cache.IRemotingCacheStore;
	
	/**
	 * Dispatched a remoting call retries. apply
	 */
	[Event(name=CallEvent.RETRY,type="com.niarbtfel.remoting.events.CallEvent")];
	
	/**
	 * Dispatched when a remoting call times out.
	 */
	[Event(name=CallEvent.TIMEOUT,type="com.niarbtfel.remoting.events.CallEvent")];
	
	/**
	 * Dispatched when a remoting call sent the request.
	 */
	[Event(name=CallEvent.REQUEST_SENT,type="com.niarbtfel.remoting.events.CallEvent")];
	
	/**
	 * Dispatched when RemotingService is haulted, and no requests further will be sent.
	 */
	[Event(name=CallEvent.SERVICE_HALTED,type="com.niarbtfel.remoting.events.CallEvent")];
	
	/**
	 * Remoting service class wraps all remoting functionality so
	 * you can make one remoting service instance and do remoting 
	 * through it.
	 */
	public dynamic class RemotingService extends Proxy implements IEventDispatcher
	{	
		
		/**
		 * Maxiumum timeouts that can happen before every service
		 * is haulted.
		 */
		public static var MaxTimeoutsBeforeHault:Number = 0;
		
		/**
		 * The number of timeouts that have happened.
		 */
		public static var NumTimeouts:int = -1;
		
		/**
		 * A flag variable for use when max timeouts 
		 * have been reached.
		 */
		public static var Halted:Boolean = false;
		
		/**
		 * The remoting connection instance.
		 */
		public var remotingConnection:RemotingConnection;
		
		/**
		 * The service to make remote calls on.
		 */
		public var service:String;
		
		/**
		 * An event dispatcher instance used in 
		 * proxy methods.
		 */
		protected var eventDispatcher:EventDispatcher;
		
		/**
		 * A calls limiter so that numerous calls that keep
		 * timing out won't get recalled.
		 */
		private var remotingLimiter:RemotingCallLimiter;
		
		/**
		 * Flag to use the RemotingCallLimiter or not.
		 */
		private var useLimiter:Boolean;
		
		/**
		 * A memory cache object for this service.
		 */
		public var remotingCache:IRemotingCacheStore;
		
		/**
		 * Maximum retries per call.
		 */
		private var maxRetriesPerCall:int;
		
		/**
		 * Call timeout
		 */
		private var callTimeout:int;
		
		/**
		 * New RemotingService
		 * 
		 * @param		RemotingConnection		The RemotingConnection to send calls to.
		 * @param 		String					The remote service target.
		 * @param		int						The time one call waits before timeint it out, and retrying.
		 * @param		int						The maximum amount of retries.
		 * @param		Boolean					Whether or not to use RemotingCall limiting.
		 * @throws		Error
		 */
		public function RemotingService(remotingConnection:RemotingConnection, service:String, callTimeout:int, maxRetriesPerCall:int, useLimiter:Boolean = true)
		{
			if(!remotingConnection)
				throw new Error("No remoting connection was supplied.");
				
			if(service == '')
				throw(new Error("Service path cannot be null"));
			
			eventDispatcher = new EventDispatcher();
			this.remotingConnection = remotingConnection;
			this.service = service;
			this.maxRetriesPerCall = maxRetriesPerCall;
			this.callTimeout = callTimeout;
			this.useLimiter = useLimiter;
			
			if(useLimiter)
				remotingLimiter = new RemotingCallLimiter();
		}
		
		/**
		 * Call
		 */
		protected function call(methodName:String,arguments:Array,onResult:Function,onFault:Function,returnArgs:Boolean):void
		{	
			if(RemotingService.NumTimeouts >= RemotingService.MaxTimeoutsBeforeHault)
			{
				if(!RemotingService.Halted)
					dispatchEvent(new CallEvent(CallEvent.SERVICE_HALTED,false,false));
				RemotingService.Halted = true;
				return;
			}
			
			RemotingService.Halted = false;
			if(useLimiter)
			{
				var unique:String = (remotingConnection.gateway + service + methodName + arguments.toString()) as String;
				if(!remotingLimiter.canExecute(unique))
				{
					return;
				}
			}
			
			try
			{
				var rcall:RemotingCall = new RemotingCall(this,methodName,onResult,onFault,arguments,returnArgs,callTimeout,maxRetriesPerCall);
			}
			catch(e:*)
			{
				dispatchEvent(new CallEvent(CallEvent.SERVICE_HALTED,false,false));
				return;
			}
			
			if(remotingCache)
				rcall.remotingCache = remotingCache;
				
			if(useLimiter)
				rcall.remotingLimiter = remotingLimiter;
			
			rcall.addEventListener(CallEvent.RETRY, onCallRetry);
			rcall.addEventListener(CallEvent.TIMEOUT, onCallTimedOut);
			rcall.addEventListener(CallEvent.REQUEST_SENT, onCallSent);
			try
			{
				rcall.execute();
			}
			catch(e:*)
			{
				dispatchEvent(new CallEvent(CallEvent.SERVICE_HALTED,false,false));
				return;
			}
		}
		
		/**
		 * When a call has been sent
		 */
		protected function onCallSent(ce:CallEvent):void
		{
			dispatchEvent(new CallEvent(CallEvent.REQUEST_SENT));
		}
			
		/**
		 * Each remoting call's retry event
		 * get's received here.
		 */
		protected function onCallRetry(ce:CallEvent):void
		{
			var ve1:CallEvent = new CallEvent(CallEvent.RETRY,false,false);
			ve1.method = ce.method;
			ve1.args = ce.args;
			ve1.service = ce.service;
			eventDispatcher.dispatchEvent(ve1);
		}
		
		/**
		 * Each remoting call's time out event
		 * get's received here.
		 */
		protected function onCallTimedOut(ce:CallEvent):void
		{
			RemotingService.NumTimeouts++;
			var ve2:CallEvent = new CallEvent(CallEvent.TIMEOUT,false,false);
			ve2.method = ce.method;
			ve2.args = ce.args;
			ve2.service = ce.service;
			eventDispatcher.dispatchEvent(ve2);
		}
		
		/**
		 * callProperty - proxy override (__resolve)
		 */
		flash_proxy override function callProperty(methodName:*, ...args):*
		{
				
			/**
			  * If the method was 'apply', use other args for call, this is so that you can
			  * make remoting calles with string method names, not having to use eval or
			  * some other hack.
			  *	myService.apply('myMethod',args,result,fault,metaObject);  would be the same as:
			  * myService.myMethod(args,result,fault,metaObject);
			  */
			if(methodName == 'apply')
			{
				if(args[4] !== true)
					args[4] = false;
					
				try{				
					call(args[0], args[1], args[2], args[3], args[4]);//, args[5]
				}catch(error:Error) { trace(error.toString()); }
			}
			else
			{
				try {
					call(methodName.toString(), args[0], args[1], args[2], args[3]);//, args[5]
				}catch(error:Error) { trace(error.toString()); }
			}
			return null;
		}
		
		/**
		 * hasProperty - override getters to return false always
		 */
  		flash_proxy override function hasProperty(name:*):Boolean
		{
			return false;
		}
		
		/**
		 * getProperty - override getters to return null always
		 */
		flash_proxy override function getProperty(name:*):* 
		{
			return null;
		}
		
		/**
		 * addEventListener - implement EventDispatcher
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, weakRef:Boolean = false):void 
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, weakRef);
		}
		
		/**
		 * dispatchEvent - implement EventDispatcher
		 */
		public function dispatchEvent(event:Event):Boolean 
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * hasEventListener - implement EventDispatcher
		 */
		public function hasEventListener(type:String):Boolean 
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		/**
		 * removeEventListener - implement EventDispatcher
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * willTrigger - implement EventDispatcher
		 */
		public function willTrigger(type:String):Boolean 
		{
			return eventDispatcher.willTrigger(type);
		}
	}
}
