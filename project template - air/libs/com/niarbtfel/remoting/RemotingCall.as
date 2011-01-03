package com.niarbtfel.remoting
{
	
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	import flash.utils.*;
	
	import com.niarbtfel.remoting.events.*;
	import com.niarbtfel.remoting.limiting.RemotingCallLimiter;
	import com.niarbtfel.remoting.cache.IRemotingCacheStore;
	
	/**
	 * Dispatched when any one of the remoting call requests retries.
	 */
	[Event(name=CallEvent.RETRY,type="com.niarbtfel.remoting.events.CallEvent")];
	
	/**
	 * Dispatched when a remoting call completely times out.
	 */
	[Event(name=CallEvent.TIMEOUT,type="com.niarbtfel.remoting.events.CallEvent")];
	
	/**
	 * Dispatched when a remoting call request is sent.
	 */
	[Event(name=CallEvent.REQUEST_SENT,type="com.niarbtfel.remoting.events.CallEvent")];
	
	
	public class RemotingCall extends EventDispatcher
	{
		/**
		 * The service this call came through.
		 */
		private var remotingService:RemotingService;
		
		/**
		 * The operation to call.
		 */
		private var operation:String;
		
		/**
		 * The result function callback.
		 */
		private var result:Function;
		
		/**
		 * The fault function callback.
		 */
		private var fault:Function;
		
		/**
		 * The arguments to send in the remote call.
		 */
		private var args:Array;
		
		/**
		 * How many attempts have been made.
		 */
		private var attempt:uint = 0;
		
		/**
		 * The var used for the timeout interval.
		 */
		private var timeoutInt:Number;
		
		/**
		 * Whether or not this call is complete yet.
		 */
		private var completed:Boolean = false;
		
		/**
		 * The amount of time before a call
		 * is considered timedout. This is the 
		 * timeout that used for a retry.
		 */
		private var callTimeout:int;
		
		/**
		 * Currently being called method.
		 */
		private var method:String;
		
		/**
		 * A cache object if cache is being used.
		 */
		public var remotingCache:IRemotingCacheStore;
		
		/**
		 * A limiter if being used.
		 */
		public var remotingLimiter:RemotingCallLimiter;
		
		/**
		 * How many attempts to make on the
		 * remote call.
		 */
		private var maxRetries:int;
		
		/**
		 * Whether or not to return the original
		 * arguments to the callback functions.
		 */
		private var returnArgs:Boolean;
		
		/**
		 * New remoting call. This is not meant to be used outside of a RemotingService.
		 * 
		 * @param 		RemotingService	The RemotingService used for this call.
		 * @param 		String			The operation to call on the connection.
		 * @param 		Function		The result function to call
		 * @param 		Function		The fault function to call.
		 * @param 		Array			The arguments to send to the net connection
		 * @param		Boolean			Whether or not to send the original arguments to the result or fault callback.
		 * @param 		int				The time before one of the maxAttepts calls is timed out.
		 * @param		int				The amount of max attemps.
		 * @throws		Error
		 */
		public function RemotingCall(remotingService:RemotingService, method:String, onResult:Function, onFault:Function, args:Array, returnArgs:Boolean, callTimeout:int, maxRetries:int) 
		{	
			if(!remotingService)
			{
				throw new Error("The RemotingService supplied to the remoting call was null.");
			}	
			
			this.remotingService = remotingService;
			this.method = method;
			this.args = args;
			this.result = onResult;
			this.returnArgs = returnArgs;
			this.fault = onFault;
			this.maxRetries = maxRetries;
			this.callTimeout = callTimeout;
			this.operation = remotingService.service + "." + method;
		}
		
		/**
		 * When a result has been received from the 
		 * net connection call.
		 * 
		 * @return		void
		 */
		protected function onResult(resObj:Object):void
		{			
			if(!completed)
			{
				var unique:String = getUniqueIdentifier();
				if(remotingLimiter)
					remotingLimiter.releaseCall(unique);
				
				if(remotingCache)
				{
					remotingCache.cacheObject(unique,resObj);
				}
				completed = true;
				clearIntervals();
				var re:ResultEvent = new ResultEvent(resObj, false, true);
				if(result!=null)
				(returnArgs) ? result(re,args) : result(re);
				
			}
		}
		
		/**
		 * When a fault has been received from
		 * the net connection call.
		 * 
		 * @return		void
		 */
		protected function onFault(resObj:Object):void
		{
			if(!completed)
			{
				var unique:String = getUniqueIdentifier();
				if(remotingLimiter)
					remotingLimiter.releaseCall(unique);
				
				//clear the cache so the next call doesn't return a cached fault object.
				if(remotingCache)
					remotingCache.purgeItem(unique);
				
				completed = true;
				clearIntervals();
				var fe:FaultEvent = new FaultEvent(resObj, false, true);
				(returnArgs) ? fault(fe,args) : fault(fe);
			}
		}
		
		/**
		 * Executes the remoting call and initiates
		 * timeout watching if specified
		 * 
		 * @throws		Error 
		 * @return		void
		 */
		public function execute():void
		{	
			if(!completed)
			{
				var unique:String = getUniqueIdentifier();
				if(remotingCache && remotingCache.isCached(unique))
				{
					if(remotingLimiter)
						remotingLimiter.releaseCall(unique);
					
					completed = true;
					clearIntervals();
					var re:ResultEvent = new ResultEvent(remotingCache.getCachedObject(unique), false, true);
					(returnArgs) ? result(re,args) : result(re);
					return;
				}
				var operation:String = remotingService.service + "." + method;
				var responder:Responder = new Responder(onResult, onFault);
				var callArgs:Array = new Array(operation, responder);
				if(attempt == 0)
				{
					if(maxRetries > 0)
					{
						if(callTimeout)
						{
							timeoutInt = setInterval(handleTimeout,callTimeout);
						}
					}
					else
					{
						maxRetries = 0;
					}
				}
				
				try
				{
					remotingService.remotingConnection.connection.call.apply(null, callArgs.concat(args));
					var rs:CallEvent = new CallEvent(CallEvent.REQUEST_SENT,false,false);
					rs.args = args;
					rs.connection = remotingService.remotingConnection;
					rs.service = remotingService;
					rs.method = method;
					dispatchEvent(new CallEvent(CallEvent.REQUEST_SENT,false,false));
				}
				catch(e:*)
				{
					attempt++;
					throw new Error("The NetConnection supplied to the remoting call was null.");
					return;
				}
				attempt++;
				if(remotingLimiter)
					remotingLimiter.lockCall(getUniqueIdentifier());
			}
		}
		
		/**
		 * Handles a timed out call, if the max attempts
		 * is reached, a timed out event is dispatched, 
		 * otherwise a rety event is dispatched.
		 * 
		 * @return		void
		 */
		private function handleTimeout():void
		{
			if(!completed)
			{
				var ce:CallEvent;
				if(attempt > maxRetries)
				{
					completed = true;
					clearIntervals();
					if(remotingLimiter)
						remotingLimiter.releaseCall(getUniqueIdentifier());
					ce = new CallEvent(CallEvent.TIMEOUT,true,false);
					ce.connection = remotingService.remotingConnection;
					ce.service = remotingService;
					ce.method = method;
					ce.args = args;
					ce.rawData = null;
					dispatchEvent(ce);
					execute();
				}
				else
				{
					ce = new CallEvent(CallEvent.RETRY,true,false);
					ce.connection = remotingService.remotingConnection;
					ce.service = remotingService;
					ce.method = method;
					ce.args = args;
					ce.rawData = null;
					dispatchEvent(ce);
					execute();
				}
			}
		}
		
		/**
		 * Get's the unique identifer for this call happening.
		 * 
		 * @return 		String
		 */
		private function getUniqueIdentifier():String
		{
			return (remotingService.remotingConnection.gateway + remotingService.service + method + args.toString()) as String;
		}
		
		/**
		 * Clears intervals running for retries
		 * 
		 * @return		void
		 */
		private function clearIntervals():void
		{
			clearInterval(timeoutInt);
			timeoutInt = 0;
		}
	}
}
