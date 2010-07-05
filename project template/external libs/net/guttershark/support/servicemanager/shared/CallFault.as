package net.guttershark.support.servicemanager.shared 
{
	
	/**
	 * The CallFault class stores the fault object that
	 * was received from any service call that was considered
	 * a fault, and is passed back to the onFault callback of
	 * a service call.
	 */
	final public class CallFault
	{
		
		/**
		 * The fault object.
		 */
		public var fault:*;
		
		/**
		 * Constructor for CallFault instances.
		 * 
		 * @param fal A fault object.
		 */
		public function CallFault(fal:*)
		{
			fault = fal;
		}	}}