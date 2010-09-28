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
	import com.addicted2flash.data.DataProgress;
	import com.addicted2flash.data.loader.ILoader;
	import com.addicted2flash.data.service.IDataService;
	import com.addicted2flash.event.DataServiceEvent;
	import com.addicted2flash.data.ServiceState;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;	

	/**
	 * This class provides a skeletal implementation of the ILoader interface to minimize 
	 * the effort required to implement this interface. 
	 * 
	 * @author Tim Richter
	 */
	public class AbstractLoader implements ILoader 
	{
		protected var _service: IDataService;
		protected var _dispatcher: EventDispatcher;
		protected var _dataProgress: DataProgress;
		protected var _httpStatus: int;
		protected var _errorMessage: String;
		protected var _state: int;

		/**
		 * Create a new <code>AbstractLoader</code>.
		 */
		public function AbstractLoader() 
		{
		}

		/**
		 * @inheritDoc
		 */
		public function start(): void
		{
			throw new IllegalOperationError( "abstract method needs to be overridden in subclasses!" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function stop(): void
		{
			throw new IllegalOperationError( "abstract method needs to be overridden in subclasses!" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get data(): Object
		{
			throw new IllegalOperationError( "abstract method needs to be overridden in subclasses!" );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get dataProgress(): DataProgress
		{
			return _dataProgress ? _dataProgress : _dataProgress = new DataProgress( 0, 0 );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get state(): int
		{
			return _state;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get httpStatus(): int
		{
			return _httpStatus;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get errorMessage(): String
		{
			return _errorMessage;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set dataService( service: IDataService ): void
		{
			_service = service;
		}

		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			removeListener();
			
			_service = null;
			_dataProgress = null;
			_dispatcher = null;
			
			_state = -1;
		}

		/**
		 * every subclass of this abstract class has to register there specific loader
		 * as an eventdispatcher (necessary for adding and removing from events).
		 * 
		 * @param dispatcher <code>EventDispatcher</code> (f.e. <code>URLLoader</code> or <code>Loader.contentLoaderInfo</code>)
		 */
		protected function registerDispatcher( dispatcher: EventDispatcher ): void
		{
			_dispatcher = dispatcher;
			
			addListener();
		}
		
		/**
		 * @private
		 */
		protected function onProgress( event: ProgressEvent ): void
		{
			if( !_dataProgress )
			{
				_dataProgress = new DataProgress( event.bytesLoaded, event.bytesTotal );
			}
			else
			{
				_dataProgress.bytesLoaded = event.bytesLoaded;
				_dataProgress.bytesTotal = event.bytesTotal;
			}
			
			_service.notifyDataServiceObservers( DataServiceEvent.PROGRESS );
		}
		
		/**
		 * @private
		 */
		protected function onComplete( event: Event ): void
		{
			removeListener();
			
			_state = ServiceState.COMPLETE;
			
			_service.notifyDataServiceObservers( DataServiceEvent.COMPLETE );
		}
		
		/**
		 * @private
		 */
		protected function onIOError( event: IOErrorEvent ): void
		{
			removeListener();
			
			_errorMessage = event.text;
			
			_state = ServiceState.ERROR;
			
			_service.notifyDataServiceObservers( DataServiceEvent.IO_ERROR );
		}
		
		/**
		 * @private
		 */
		private function onSecurityError( event: SecurityErrorEvent ): void
		{
			removeListener();
			
			_errorMessage = event.text;
			
			_state = ServiceState.ERROR;
			
			_service.notifyDataServiceObservers( DataServiceEvent.SECURITY_ERROR );
		}
		
		/**
		 * @private
		 */
		private function onHTTPStatus( event: HTTPStatusEvent ): void
		{			
			_httpStatus = event.status;
			
			_service.notifyDataServiceObservers( DataServiceEvent.HTTP_STATUS );
		}
		
		/**
		 * @private
		 */
		protected function addListener(): void
		{
			_dispatcher.addEventListener( Event.COMPLETE, onComplete, false, 0, true );
			_dispatcher.addEventListener( ProgressEvent.PROGRESS, onProgress, false, 0, true );
			_dispatcher.addEventListener( IOErrorEvent.IO_ERROR, onIOError, false, 0, true );
			_dispatcher.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHTTPStatus, false, 0, true );
			_dispatcher.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError, false, 0, true );
		}

		/**
		 * @private
		 */
		protected function removeListener(): void
		{
			_dispatcher.removeEventListener( Event.COMPLETE, onComplete );
			_dispatcher.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			_dispatcher.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			_dispatcher.removeEventListener( HTTPStatusEvent.HTTP_STATUS, onHTTPStatus );
			_dispatcher.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
		}
	}
}
