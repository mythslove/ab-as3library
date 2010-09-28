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
	import com.addicted2flash.data.service.IDataService;
	import com.addicted2flash.data.DataProgress;
	import com.addicted2flash.util.IDisposable;	

	/**
	 * Interface every loader-strategy has to implement.
	 * 
	 * @author Tim Richter
	 */
	public interface ILoader extends IDisposable
	{
		/**
		 * Loads given <code>URLRequest</code>.
		 */
		function start(): void
		
		/**
		 * Stops given <code>URLRequest</code>.
		 */
		function stop(): void;
		
		/**
		 * Sets <code>IDataService</code>.
		 * 
		 * @param service <code>IDataService</code>
		 */
		function set dataService( service: IDataService ): void;
		
		/**
		 * Returns requested data.
		 * 
		 * @return requested data
		 */
		function get data(): Object;
		
		/**
		 * Returns <code>DataProgress</code> of this service.
		 * 
		 * @return DataProgress of this service
		 */
		function get dataProgress(): DataProgress;
		
		/**
		 * Returns state of <code>ILoader</code>.
		 * 
		 * @return state of <code>ILoader</code>
		 * @see ServiceState
		 */
		function get state(): int;
		
		/**
		 * Returns http status of <code>IDataService</code>.
		 * 
		 * @return http status of <code>IDataService</code>
		 */
		function get httpStatus(): int;
		
		/**
		 * Returns error message of <code>IDataService</code>.
		 * 
		 * @return error message of <code>IDataService</code>
		 */
		function get errorMessage(): String;
	}
}

