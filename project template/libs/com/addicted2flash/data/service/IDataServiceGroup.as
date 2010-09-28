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
	import com.addicted2flash.util.IDisposable;		

	/**
	 * Interface for all objects that group a list of data services and handle their events.
	 * 
	 * @author Tim Richter
	 */
	public interface IDataServiceGroup extends IDisposable
	{
		/**
		 * Returns http status of the <code>IDataService</code>.
		 * 
		 * @return http status of the <code>IDataService</code>
		 */
		function get httpStatus(): int;
		
		/**
		 * Returns error message of the <code>IDataService</code>.
		 * 
		 * @return error message of the <code>IDataService</code>
		 */
		function get errorMessage(): String;
		
		/**
		 * Returns the overall progress of the <code>IDataServiceGroup</code>.
		 * <p>NOTE: the totalbytes are just the bytes of the services being processed by the
		 * <code>LoaderQueue</code>. This means that it is possible that not all totalbytes of the added 
		 * services are included.</p>
		 * 
		 * @return overall progress of the <code>IDataServiceGroup</code>
		 */
		function get dataProgress(): DataProgress;
		
		/**
		 * Returns the currently active service that has dispatched an event (f.e error events).
		 * 
		 * @return the currently active service that has dispatched an event
		 */
		function get currentService(): IDataService;

		/**
		 * Adds a service to the list of services.
		 * 
		 * @param service service to be added
		 */
		function add( service: IDataService ): void;
		
		/**
		 * Removes a service from the list of services.
		 * 
		 * @param service service to be removed
		 */
		function remove( service: IDataService ): void;
		
		/**
		 * Removes a service from the list of services at a given index.
		 * 
		 * @param i index of service
		 */
		function removeAt( i: int ): void;
		
		/**
		 * Returns service at a given index.
		 * 
		 * @param i index of the service
		 * @return service at a given index
		 */
		function getAt( i: int ): IDataService;
		
		/**
		 * Returns the total amount of services in the list.
		 * 
		 * @return the total amount of services in the list
		 */
		function get dataServiceCount(): int;
		
		/**
		 * Adds an <code>IDataServiceGroupObserver</code> to the set of observers for this object.
		 * 
		 * @param o <code>IDataServiceGroupObserver</code> to be added.
		 * @param events events the observer is interested in
		 */
		function addDataServiceGroupObserver( o: IDataServiceGroupObserver, events: int ): void;
		
		/**
		 * Deletes an <code>IDataServiceGroupObserver</code> from the set of observers of this object. 
		 * 
		 * @param o <code>IDataServiceGroupObserver</code> to be deleted.
		 */
		function removeDataServiceGroupObserver( o: IDataServiceGroupObserver ): void;
		
		/**
		 * Clears the list of observers. 
		 */
		function removeDataServiceGroupObservers(): void;
	}
}
