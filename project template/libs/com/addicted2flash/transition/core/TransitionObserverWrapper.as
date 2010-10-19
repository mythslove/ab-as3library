package com.addicted2flash.transition.core 
{

	/**
	 * private
	 * @author Tim Richter
	 */
	internal class TransitionObserverWrapper 
	{
		public var events: int;
		public var observer: ITransitionObserver;
		
		public function TransitionObserverWrapper( observer: ITransitionObserver, events: int )
		{
			this.observer = observer;
			this.events = events;
		}
	}
}
