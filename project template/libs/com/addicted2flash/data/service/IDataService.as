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
	
	import flash.net.URLRequest;
	import flash.system.LoaderContext;		

	/**
	 * Interface for data services
	 * 
	 * @author Tim Richter
	 */
	public interface IDataService extends IDataServiceObservable
	{
		/**
		 * Returns attachment of the <code>IDataService</code>.
		 * 
		 * @return any data 
		 */
		function get attachment(): *;
		
		/**
		 * Returns priority of the <code>IDataService</code>.
		 * 
		 * @return priority of the <code>IDataService</code>
		 */
		function get priority(): int;
		
		/**
		 * Returns requested data.
		 * 
		 * @return requested data
		 */
		function get data(): Object
		
		/**
		 * Returns progress of the <code>IDataService</code>.
		 * 
		 * @return progress of the <code>IDataService</code>
		 */
		function get dataProgress(): DataProgress;
		
		/**
		 * Returns request of the <code>IDataService</code>.
		 * 
		 * @return request of the <code>IDataService</code>
		 */
		function get urlRequest(): URLRequest;
		
		/**
		 * Returns loader context of the <code>IDataService</code>.
		 * 
		 * @return loader context of the <code>IDataService</code>
		 */
		function get loaderContext(): LoaderContext;

		/**
		 * Returns state of the <code>IDataService</code>.
		 * 
		 * @return state of the <code>IDataService</code>
		 */
		function get state(): int
		
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
	}
}
