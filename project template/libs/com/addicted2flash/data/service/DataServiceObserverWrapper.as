package com.addicted2flash.data.service 
{

	/**
	 * @private
	 * @author Tim Richter
	 */
	internal class DataServiceObserverWrapper 
	{
		public var events: int;
		public var observer: IDataServiceObserver;
		
		public function DataServiceObserverWrapper( observer: IDataServiceObserver, events: int )
		{
			this.observer = observer;
			this.events = events;
		}
	}
}
