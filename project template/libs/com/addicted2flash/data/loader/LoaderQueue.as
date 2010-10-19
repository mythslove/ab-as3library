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
package com.addicted2flash.data.loader 
{
	import com.addicted2flash.data.ServiceState;
	import com.addicted2flash.data.loader.ILoader;
	import com.addicted2flash.data.service.IDataService;
	import com.addicted2flash.data.service.IDataServiceGroup;
	import com.addicted2flash.data.service.IDataServiceObserver;
	import com.addicted2flash.data.service.LoaderQueueService;
	import com.addicted2flash.data.service.LoaderQueueServiceGroup;
	import com.addicted2flash.event.DataServiceEvent;
	import com.addicted2flash.util.ArraySet;
	import com.addicted2flash.util.IQueue;
	import com.addicted2flash.util.ISet;
	import com.addicted2flash.util.SortedArrayQueue;
	import com.addicted2flash.util.comparator.DESCDataServicePriorityComparator;
	
	import flash.net.URLRequest;
	import flash.system.LoaderContext;		

	/**
	 * This class represents a FIFO implementation of <code>IDataService</code>s.
	 * With this class it is possible to create and process services application wide in a queue.
	 * Also it is possible to pause, stop and resume the process.
	 * 
	 * @author Tim Richter
	 */
	public class LoaderQueue implements IDataServiceObserver
	{
		private static const MAX_ACTIVE_SERVICES: int = 3;
		private static const INSTANCE: LoaderQueue = new LoaderQueue( );
		private static const SERVICE_QUEUE: IQueue = new SortedArrayQueue( new DESCDataServicePriorityComparator( ) );
		private static const ACTIVE_SERVICES: ISet = new ArraySet( );
		
		private static var _state: int = ServiceState.READY;
		
		/**
		 * Creates and returns <code>IDataService</code>.
		 * 
		 * @param loader <code>ILoader</code> for different loading procedures (f.e. bitmaps or xml)
		 * @param request <code>URLRequest</code>
		 * @param context loader context
		 * @param attachment any data (f.e. data binded to the request)
		 * @param priority priority
		 * 
		 * @return data service
		 */
		public static function create( loader: ILoader, request: URLRequest, context: LoaderContext = null, attachment: * = null, priority: int = 0 ): IDataService
		{
			var service: IDataService = new LoaderQueueService( loader, request, context, attachment, priority );
			
			SERVICE_QUEUE.add( service );
			
			processService( );
			
			return service;
		}
		
		/**
		 * Creates and returns a <code>IDataServiceGroup</code> that handles a list of <code>IDataService</code>s
		 * simultaneously.
		 * 
		 * @param services list of services
		 * @return a <code>IDataServiceGroup</code> that handles a list of <code>IDataService</code>s
		 * simultaneously
		 */
		public static function group( ... services ): IDataServiceGroup
		{
			return new LoaderQueueServiceGroup( services );
		}

		/**
		 * Removes specific <code>IDataService</code> from the queue and stop the process of the
		 * specific service that is running.
		 * 
		 * @param service queued <code>IDataService</code>
		 */
		public static function remove( service: IDataService ): void
		{
			service.dispose();
			
			if( ACTIVE_SERVICES.remove( service ) )
			{
				processService( );
			}
			else
			{
				SERVICE_QUEUE.remove( service );
			}
		}

		/**
		 * Stopps the loading progress of active services and remove all <code>IDataService</code>s from the queue.
		 */
		public static function stop(): void
		{
			for( var i: int = 0; i < MAX_ACTIVE_SERVICES; ++i )
			{
				LoaderQueueService( ACTIVE_SERVICES.getAt( i ) ).dispose();
			}
			
			ACTIVE_SERVICES.clear( );
			SERVICE_QUEUE.clear( );
			
			_state = ServiceState.READY;
		}

		/**
		 * Pauses the loading progress of active services.
		 */
		public static function pause(): void
		{
			if( _state != ServiceState.PAUSE )
			{
				for( var i: int = 0; i < MAX_ACTIVE_SERVICES; ++i )
				{
					LoaderQueueService( ACTIVE_SERVICES.getAt( i ) ).stop();
				}
				
				_state = ServiceState.PAUSE;
			}
		}

		/**
		 * Resumes the loading progress of active services.
		 */
		public static function resume(): void
		{
			if( _state != ServiceState.RUNNING )
			{
				for( var i: int = 0; i < MAX_ACTIVE_SERVICES; ++i )
				{
					LoaderQueueService( ACTIVE_SERVICES.getAt( i ) ).start();
				}
				
				_state = ServiceState.RUNNING;
			}
		}

		/**
		 * Returns the state of <code>LoaderQueue</code>.
		 * 
		 * @return the state of <code>LoaderQueue</code>
		 */
		public static function get state(): String
		{
			return ServiceState.stateToString( _state );
		}

		/**
		 * @private
		 */
		private static function processService(): void
		{
			if( ( ACTIVE_SERVICES.size() < MAX_ACTIVE_SERVICES ) && ( _state != ServiceState.PAUSE ) && ( !SERVICE_QUEUE.isEmpty( ) ) )
			{
				var len: int = Math.abs( ACTIVE_SERVICES.size( ) - MAX_ACTIVE_SERVICES );
				var size: int = SERVICE_QUEUE.size( );
				var service: LoaderQueueService;
				
				for( var i: int = 0; i < len && size != 0 ; ++i, --size )
				{
					service = LoaderQueueService( SERVICE_QUEUE.poll( ) );
					
					ACTIVE_SERVICES.add( service );
					
					service.addDataServiceObserver( INSTANCE, DataServiceEvent.COMPLETE | DataServiceEvent.IO_ERROR | DataServiceEvent.SECURITY_ERROR );
					
					service.start( );
				}
				
				_state = ServiceState.RUNNING;
			}
		}

		/**
		 * @private
		 */
		public function processDataServiceEvent( type: int, service: IDataService ): void
		{
			service.removeDataServiceObserver( INSTANCE );
			
			ACTIVE_SERVICES.remove( service );
			
			processService( );
		}
	}
}