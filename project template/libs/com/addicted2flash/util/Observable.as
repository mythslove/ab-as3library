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
	import com.addicted2flash.util.IObservable;	

	/**
	 * This class represents an observer-pattern-based implementation with only one value in the model.
	 * Setting the value will notify all observers.
	 * 
	 * @author Tim Richter
	 */
	public class Observable implements IObservable 
	{
		private var _ref: IObservable;
		private var _observers: Array;
		private var _value: *;
		private var _hasChanged: Boolean;
		private var _allowSameValue: Boolean;

		/**
		 * Create a new <code>Observable</code>.
		 * 
		 * @param reference the referenced target of notifications (useful for aggregation)
		 * @param allowSameValue observers will be notified even when the same value is set multiple times
		 */
		public function Observable( reference: IObservable = null, allowSameValue: Boolean = false ) 
		{
			_ref = reference || this;
			_hasChanged = false;
			_allowSameValue = allowSameValue;
		}

		/**
		 * @inheritDoc
		 */
		public function addObserver( o: IObserver ): void
		{
			if( !_observers ) _observers = [];
			else if( _observers.indexOf( o ) > -1 ) return;
			
			_observers.push( o );
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeObserver( o: IObserver ): void
		{
			if( !_observers ) return;
			
			var x: int = _observers.indexOf( o );
			
			if( x > -1 ) _observers.splice( x, 1 );
		}

		/**
		 * @inheritDoc
		 */
		public function removeObservers(): void
		{
			_observers = null;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get value(): *
		{
			return _value;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set value( value: * ): void
		{
			if( _allowSameValue || _value != value )
			{
				_value = value;
				
				_hasChanged = true;
				
				notifyMicroObservers();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isAvailable(): Boolean
		{
			return _hasChanged;
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispose(): void
		{
			_value = null;
			_ref = null;
			
			_observers = null;
		}
		
		/**
		 * String representation of <code>Observable</code>.
		 * 
		 * @return String representation of <code>Observable</code>
		 */
		public function toString(): String
		{
			return "[ Observable ]";
		}
		
		/**
		 * Each registered <code>IMicroObserver</code> will be notified.
		 */
		protected function notifyMicroObservers(): void
		{
			if( isAvailable && _observers )
			{
				var a: Array = _observers.slice();
				var n: int = a.length;
				
				for( var i: int = 0; i < n; ++i )
				{
					IObserver( a[ i ] ).processUpdate( _ref );
				}
				
				_hasChanged = false;
			}
		}
	}
}
