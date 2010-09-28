/**
 * Copyright (c) 2008 Tim Richter, www.addicted2flash.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.addicted2flash.data.service 
{
	import flash.utils.Dictionary;	
	
	import com.addicted2flash.data.DataProgress;
	import com.addicted2flash.data.ServiceState;
	import com.addicted2flash.data.loader.ILoader;
	import com.addicted2flash.data.service.IDataService;
	import com.addicted2flash.data.service.IDataServiceObserver;

	import flash.errors.IllegalOperationError;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * This class is represents a <code>ILoaderQueueService</code> created by <code>LoaderQueue</code>.
	 * <p>To handle specific <code>DataServiceEventType</code>s a listener have to add itself to the list of 
	 * observers (<code>add
	 * 
	 * The following <code>DataServiceEventType</code>s are going to be dispatched:
	 * <li><code>DataServiceEventType.COMPLETE</code></li>
	 * <li><code>DataServiceEventType.PROGRESS</code></li>
	 * <li><code>DataServiceEventType.IO_ERROR</code></li>
	 * <li><code>DataServiceEventType.SECURITY_ERROR</code></li>
	 * <li><code>DataServiceEventType.HTTP_STATUS</code></li>
	 * 
	 * @author Tim Richter
	 */
	public class LoaderQueueService implements IDataService 
	{
		private var _loader: ILoader;
		private var _urlRequest: URLRequest;
		private var _context: LoaderContext;
		private var _anchor: *;
		private var _priority: int;
		
		private var _observers: Dictionary;

		
		/**
		 * Create a new <code>LoaderQueueService</code>.
		 * 
		 * @param loader <code>ILoader</code> for different loading procedures (f.e. bitmaps or xml)
		 * @param serviceRequest <code>IServiceRequest</code>
		 * @param anchor any data (f.e. data dependent to the request)
		 * @param priority priority
		 */
		public function LoaderQueueService( loader: ILoader, urlRequest: URLRequest, context: LoaderContext = null,anchor: * = null, priority: int = 0 ) 
		{
			_loader = loader;
			_urlRequest = urlRequest;
			_context = context;
			_anchor = anchor;
			_priority = priority;
			
			_loader.dataService = this;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get attachment(): *
		{
			return _anchor;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get priority(): int
		{
			return _priority;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get urlRequest(): URLRequest
		{
			return _urlRequest;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get loaderContext(): LoaderContext
		{
			return _context;
		}

		/**
		 * @inheritDoc
		 */
		public function get data(): Object
		{
			return _loader ? _loader.data : null;
		}

		/**
		 * @inheritDoc
		 */
		public function get dataProgress(): DataProgress
		{
			return _loader ? _loader.dataProgress : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get state(): int
		{
			return _loader ? _loader.state : ServiceState.STOP;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get httpStatus(): int
		{
			return _loader ? _loader.httpStatus : -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorMessage(): String
		{
			return _loader ? _loader.errorMessage : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function start(): void
		{
			if( _loader ) _loader.start();
		}

		/**
		 * @inheritDoc
		 */
		public function stop(): void
		{
			if( _loader ) _loader.stop();
		}

		/**
		 * @inheritDoc
		 */
		public function pause(): void
		{
			throw new IllegalOperationError( "pause functionality is not provided within this service" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function addDataServiceObserver( o: IDataServiceObserver, events: int ): void
		{
			if( !_observers ) _observers = new Dictionary();
			else if( _observers[ o ] != null )
			{
				DataServiceObserverWrapper( _observers[ o ] ).events = events;
				
				return;
			}
			
			_observers[ o ] = new DataServiceObserverWrapper( o, events );
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeDataServiceObserver( o: IDataServiceObserver ): void
		{
			if( !_observers ) return;
			
			delete _observers[ o ];
		}

		/**
		 * @inheritDoc
		 */
		public function removeDataServiceObservers(): void
		{
			_observers = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function notifyDataServiceObservers( event: int ): void
		{
			if( !_observers || !event ) return;
			
			for each( var o: DataServiceObserverWrapper in _observers )
			{
				if( event & o.events ) o.observer.processDataServiceEvent( event, this );
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			_anchor = null;
			_urlRequest = null;
			_context = null;
			_observers = null;
			
			if( _loader )
			{
				_loader.dispose();
				_loader = null;
			}
		}
		
		/**
		 * String representation of this <code>LoaderQueueService</code>.
		 * 
		 * @return String representation of this <code>LoaderQueueService</code>
		 */
		public function toString() : String 
		{
			return "[ LoaderQueueService anchor=" + _anchor + " priority=" + _priority + " ]";
		}
	}
}
