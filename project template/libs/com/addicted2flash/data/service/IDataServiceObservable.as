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
	import com.addicted2flash.util.IDisposable;	
	
	/**
	 * Interface all data service observables have to implement.
	 * 
	 * @author Tim Richter
	 */
	public interface IDataServiceObservable extends IDisposable
	{
		/**
		 * Adds an <code>IDataServiceObserver</code> to the set of observers for this object.
		 * 
		 * @param o <code>IDataServiceObserver</code> to be added.
		 * @param events events the observer is interested in
		 */
		function addDataServiceObserver( o: IDataServiceObserver, events: int ): void;
		
		/**
		 * Deletes an <code>IDataServiceObserver</code> from the set of observers of this object. 
		 * 
		 * @param o <code>IDataServiceObserver</code> to be deleted.
		 */
		function removeDataServiceObserver( o: IDataServiceObserver ): void;
		
		/**
		 * Clears the list of observers. 
		 */
		function removeDataServiceObservers(): void;
		
		/**
		 * Registered <code>IDataServiceObserver</code> will be notified.
		 * 
		 * @param type type of notification
		 * @see DataServiceEventType
		 */
		function notifyDataServiceObservers( type: int ): void;
	}
}
