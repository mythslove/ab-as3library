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
package com.addicted2flash.data 
{

	/**
	 * This class represents the numeric progress of data.
	 * 
	 * @author Tim Richter
	 */
	public class DataProgress 
	{
		protected var _loaded: int;
		protected var _total: int;
		
		/**
		 * Create a new <code>DataProgress</code>.
		 * 
		 * @param bytesLoaded bytes loaded
		 * @param bytesTotal bytes total
		 */
		public function DataProgress( bytesLoaded: int, bytesTotal: int ) 
		{
			_loaded = bytesLoaded;
			_total = bytesTotal;
		}
		
		/**
		 * return bytes loaded.
		 * 
		 * @return bytes loaded
		 */
		public function get bytesLoaded(): int
		{
			return _loaded;
		}
		
		/**
		 * set bytes loaded.
		 * 
		 * @param bytesLoaded bytes loaded
		 */
		public function set bytesLoaded( bytesLoaded: int ): void
		{
			_loaded = bytesLoaded;
		}
		
		/**
		 * return bytes total.
		 * 
		 * @return bytes total
		 */
		public function get bytesTotal(): int
		{
			return _total;
		}
		
		/**
		 * set bytes total.
		 * 
		 * @param bytesTotal bytes total
		 */
		public function set bytesTotal( bytesTotal: int ): void
		{
			_total = bytesTotal;
		}
		
		/**
		 * return bytes still receivable ( bytesTotal - bytesLoaded ).
		 * 
		 * @return bytes still receivable
		 */
		public function get bytesReceivable(): int
		{
			return _total - _loaded;
		}
		
		/**
		 * return percentage of data progress ( between 0-100 ).
		 * 
		 * @return percentage of data progress
		 */
		public function get percentage(): Number
		{
			return _total > 0 ? _loaded / _total * 100 : 0;
		}
		
		/**
		 * return normalized value of data progress ( between 0-1 ).
		 * 
		 * @return normalized value of data progress
		 */
		public function get norm(): Number
		{
			return _total > 0 ? _loaded / _total : 0;
		}
		
		/**
		 * String representation of <code>DataProgress</code>.
		 * 
		 * @return String representation of <code>DataProgress</code>
		 */
		public function toString(): String
		{
			return "[ DataProgress bytesLoaded=" + _loaded + " bytesTotal=" + _total + " ]";
		}
	}
}
