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
	import com.addicted2flash.data.loader.ILoader;
	import com.addicted2flash.data.loader.AbstractLoader;
	import com.addicted2flash.data.ServiceState;
	
	import flash.net.URLLoader;

	/**
	 * This class provides a loader-strategy for <code>URLLoader</code> specific data providing.
	 * 
	 * @author Tim Richter
	 */
	public class URLLoader extends AbstractLoader implements ILoader
	{
		private var _loader: flash.net.URLLoader;

		/**
		 * Create a new <code>URLLoaderStrategy</code>.
		 */
		public function URLLoader()
		{
			registerDispatcher( _loader = new flash.net.URLLoader() );
		}

		/**
		 * @inheritDoc
		 */
		override public function start(): void
		{
			_state = ServiceState.RUNNING;
			
			_loader.load( _service.urlRequest );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function stop(): void
		{
			_state = ServiceState.STOP;
			
			try
			{
				_loader.close();
			}
			catch( e: Error ){ }
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get data(): Object
		{
			return _loader.data;
		}

		/**
		 * @inheritDoc
		 */
		override public function dispose(): void
		{
			super.dispose();
			
			try
			{
				_loader.close();
			}
			catch( e: Error ){ }
			
			_loader = null;
		}
				
		/**
		 * String representation of <code>URLLoaderStrategy</code>.
		 * 
		 * @return String representation of <code>URLLoaderStrategy</code>
		 */
		public function toString() : String 
		{
			return "[ URLLoader state=" + _state + " ]";
		}
	}
}
