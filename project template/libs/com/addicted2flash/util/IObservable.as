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
package com.addicted2flash.util 
{

	/**
	 * Interface for observables with only one value.
	 * 
	 * @author Tim Richter
	 */
	public interface IObservable extends IDisposable
	{
		/**
		 * Adds an observer to the set of observers for this object, provided that it is not 
		 * the same as some observer already in the set
		 * 
		 * @param o an observer to be added.
		 */
		function addObserver( o: IObserver ): void;
		
		/**
		 * Deletes the given observer from the set of observers of this observable.
		 * Passing null to this method will have no effect. 
		 * 
		 * @param o the observer to be deleted.
		 */
		function removeObserver( o: IObserver ): void;
		
		/**
		 * Clears the observer list so that this object no longer has any observers. 
		 */
		function removeObservers(): void;
		
		/**
		 * Returns the value of this observable.
		 * 
		 * @return the value of this observable
		 */
		function get value(): *;
		
		/**
		 * Sets the value of this observable.
		 * 
		 * @param value value of this observable
		 */
		function set value( value: * ): void;
		
		/**
		 * Returns true if the value is available.
		 * 
		 * @return true if the value is available
		 */
		function get isAvailable(): Boolean;
	}
}
