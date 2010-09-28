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
	import com.addicted2flash.data.DataProgress;
	import com.addicted2flash.data.ServiceState;
	import com.addicted2flash.data.service.IDataService;
	import com.addicted2flash.data.service.IDataServiceGroup;
	import com.addicted2flash.data.service.IDataServiceGroupObserver;
	import com.addicted2flash.data.service.IDataServiceObserver;
	import com.addicted2flash.event.DataServiceEvent;
	
	import flash.utils.Dictionary;	

	/**
	 * Concrete implementation of <code>IDataServiceGroup</code> for <code>LoaderQueueService</code>s.
	 * These services are provided by <code>LoaderQueue</code> factory method.
	 * 
	 * @author Tim Richter
	 */
	public class LoaderQueueServiceGroup implements IDataServiceGroup, IDataServiceObserver
	{
		private var _observers: Dictionary;

		private var _services: Array;
		private var _progress: DataProgress;
		private var _service: IDataService;
		private var _count: int;

		/**
		 * Creates a new <code>LoaderQueueServiceGroup</code>.
		 * 
		 * @param services services
		 */
		public function LoaderQueueServiceGroup( services: Array )
		{
			_progress = new DataProgress( 0, 0 );
			
			var n: int = services.length;
			
			for( var i: int = 0; i < n; ++i ) add( services[ i ] );
		}
		
		/**
		 * @inheritDoc
		 */
		public function get httpStatus(): int
		{
			return _service ? _service.httpStatus : -1;
		}

		/**
		 * @inheritDoc
		 */
		public function get errorMessage(): String
		{
			return _service ? _service.errorMessage : null;
		}

		/**
		 * @inheritDoc
		 */
		public function get dataProgress(): DataProgress
		{
			return _progress;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get currentService(): IDataService
		{
			return _service;
		}

		/**
		 * @inheritDoc
		 */
		public function add( service: IDataService ): void
		{
			if( !_services ) _services = [];
			else if( _services.indexOf( service ) > -1 ) return;
			
			service.addDataServiceObserver( this, DataServiceEvent.ALL );
			
			_services.push( service );
		}

		/**
		 * @inheritDoc
		 */
		public function remove( service: IDataService ): void
		{
			if( !_services ) return;
			
			var x: int = _services.indexOf( service );
			
			if( x > -1 ) removeAt( x );
		}

		/**
		 * @inheritDoc
		 */
		public function removeAt( i: int ): void
		{
			if( !_services || _services.length >= i ) return;
			
			IDataService( _services.splice( i, 1 )[ 0 ] ).removeDataServiceObserver( this );
			
			if( !_services.length ) _services = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getAt( i: int ): IDataService
		{
			return _services ? _services[ i ] : null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get dataServiceCount(): int
		{
			return _services ? _services.length : 0;
		}
		
		/**
		 * @inheritDoc
		 */
		public function addDataServiceGroupObserver( o: IDataServiceGroupObserver, events: int ): void
		{
			if( !_observers ) _observers = new Dictionary();
			else if( _observers[ o ] != null  )
			{
				DataServiceGroupObserverWrapper( _observers[ o ] ).events = events;
				
				return;
			}
			
			_observers[ o ] = new DataServiceGroupObserverWrapper( o, events );
		}

		/**
		 * @inheritDoc
		 */
		public function removeDataServiceGroupObserver( o: IDataServiceGroupObserver ): void
		{
			if( !_observers ) return;
			
			delete _observers[ o ];
		}

		/**
		 * @inheritDoc
		 */
		public function removeDataServiceGroupObservers(): void
		{
			_observers = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			if( _services )
			{
				var n: int = _services.length;
				
				while( --n > -1 ) IDataService( _services[ n ] ).dispose();
			}
			
			_services = null;
			_progress = null;
			_observers = null;
		}
		
		/**
		 * @private
		 */
		public function processDataServiceEvent( type: int, service: IDataService ): void
		{
			_service = service;
			
			switch( type )
			{
				case DataServiceEvent.COMPLETE:
					service.removeDataServiceObserver( this );
					if( ++_count == _services.length ) notifyDataServiceObservers( DataServiceEvent.COMPLETE );
					break;
					
				case DataServiceEvent.HTTP_STATUS:
					notifyDataServiceObservers( DataServiceEvent.HTTP_STATUS );
					break;
					
				case DataServiceEvent.IO_ERROR:
					++_count;
					service.removeDataServiceObserver( this );
					notifyDataServiceObservers( DataServiceEvent.IO_ERROR );
					break;
					
				case DataServiceEvent.PROGRESS:
					handleProgress();
					break;
					
				case DataServiceEvent.SECURITY_ERROR:
					++_count;
					service.removeDataServiceObserver( this );
					notifyDataServiceObservers( DataServiceEvent.SECURITY_ERROR );
					break;
			}
		}

		private function notifyDataServiceObservers( type: int ): void
		{
			if( !type || !_observers ) return;
			
			for each ( var o: DataServiceGroupObserverWrapper in _observers )
			{
				if( type & o.events ) o.observer.processDataServiceGroupEvent( type, this );
			}
		}
		
		private function handleProgress(): void
		{
			_progress.bytesLoaded = 0;
			_progress.bytesTotal = 0;
			
			var n: int = _services.length;
			var s: IDataService;
			var p: DataProgress;
			
			while( --n > -1 )
			{
				s = _services[ n ];
				
				if( s.state != ServiceState.ERROR )
				{
					p = s.dataProgress;
					
					_progress.bytesLoaded += p.bytesLoaded;
					_progress.bytesTotal += p.bytesTotal;
				}
			}
			
			notifyDataServiceObservers( DataServiceEvent.PROGRESS );
		}
	}
}
