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
package com.addicted2flash.layout.component 
{
	import com.addicted2flash.layout.core.Container;
	import com.addicted2flash.layout.strategy.CanvasLayout;
	import com.addicted2flash.layout.strategy.ILayout;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * Concrete implementation of a container that uses a <code>CanvasLayout</code>.
	 * 
	 * @author Tim Richter
	 * @see CanvasLayout
	 */
	public class Canvas extends Container 
	{
		/**
		 * Creates a new <code>Canvas</code>.
		 */
		public function Canvas()
		{
			super( new CanvasLayout() );
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set layout( layout: ILayout ): void
		{
			throw new IllegalOperationError( "Layout cannot be changed in Canvas" );
		}

		/**
		 * Returns the string representation of the <code>Canvas</code>.
		 * 
		 * @return the string representation of the <code>Canvas</code>
		 */
		override public function toString(): String
		{
			return '[ Canvas ]';
		}
	}
}
