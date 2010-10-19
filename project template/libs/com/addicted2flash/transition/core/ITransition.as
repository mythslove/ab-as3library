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
package com.addicted2flash.transition.core 
{
	import com.addicted2flash.transition.core.Property;
	import com.addicted2flash.util.IDisposable;	
	
	/**
	 * Interface of transition objects.
	 * 
	 * @author Tim Richter
	 */
	public interface ITransition extends IDisposable
	{
		/**
		 * Starts the transition.
		 */
		function start(): void;
		
		/**
		 * Stopps the transition.
		 */
		function stop(): void;
		
		/**
		 * Pause the transition.
		 */
		function pause(): void;
		
		/**
		 * Resumes the transition.
		 */
		function resume(): void;
		
		/**
		 * Starts the transition in reverse direction.
		 */
		function reverse(): void;
		
		/**
		 * Returns the state of the <code>IFlux</code>.
		 * 
		 * @return the state of the <code>IFlux</code>
		 * @see FluxState
		 */
		function get state(): int;
		
		/**
		 * Returns the duration of the transition.
		 * 
		 * @return the duration of the transition
		 */
		function get totalDuration(): int;
		
		/**
		 * Returns the specified attachment.
		 * 
		 * @return the specified attachment
		 */
		function get attachment(): *;
		
		/**
		 * Sets the specified attachment.
		 * 
		 * @param attachment the specified attachment
		 */
		function set attachment( attachment: * ): void;
		
		/**
		 * Sets first property of the flux.
		 * <p>NOTE: use <code>Property.create()</p>
		 * 
		 * @param property first property of the flux
		 */
		function set property( property: Property ): void;

		/**
		 * Adds a <code>ITransitionObserver</code>.
		 * 
		 * @param o observer to be added
		 * @param events events the observer is interested in
		 */
		function addTransitionObserver( o: ITransitionObserver, events: int ): void;
		
		/**
		 * Removes a <code>ITransitionObserver</code>.
		 * 
		 * @param o observer to be removed
		 */
		function removeTransitionObserver( o: ITransitionObserver ): void;
		
		/**
		 * Clears the list of observers.
		 */
		function removeTransitionObservers(): void;
	}
}
