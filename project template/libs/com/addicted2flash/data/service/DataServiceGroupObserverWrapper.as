package com.addicted2flash.data.service 
{

	/**
	 * @private
	 * @author Tim Richter
	 */
	internal class DataServiceGroupObserverWrapper 
	{
		public var events: int;
		public var observer: IDataServiceGroupObserver;
		
		public function DataServiceGroupObserverWrapper( observer: IDataServiceGroupObserver, events: int )
		{
			this.observer = observer;
			this.events = events;
		}
	}
}
