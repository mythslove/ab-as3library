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
	import com.addicted2flash.layout.strategy.BoxLayout;
	import com.addicted2flash.layout.strategy.ILayout;
	import com.addicted2flash.layout.util.Orientation;
	
	import flash.errors.IllegalOperationError;	

	/**
	 * This container arranges its components according to their desired size in
	 * vertical orientation.
	 * 
	 * @author Tim Richter
	 */
	public class VBox extends Container 
	{
		/**
		 * Creates a new <code>VBox</code>.
		 * 
		 * @param gap the gap between the components
		 */
		public function VBox( gap: Number = 0)
		{
			super( new BoxLayout( Orientation.VERTICAL, gap ) );
		}
		
		/**
		 * Returns the gap between the components.
		 * 
		 * @return the gap between the components
		 */
		public function get gap( ):Number
		{
			return BoxLayout( layout ).gap;
		}
		
		/**
		 * Sets the gap between the components.
		 * 
		 * @param value the gap between the components
		 */
		public function set gap( value: Number ): void
		{
			BoxLayout( layout ).gap = value;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set layout( layout: ILayout ): void
		{
			throw new IllegalOperationError( "Layout cannot be changed in VBox" );
		}
		
		/**
		 * Returns the string representation of the <code>VBox</code>.
		 * 
		 * @return the string representation of the <code>VBox</code>
		 */
		override public function toString(): String
		{
			return "[ VBox ]";
		}
	}
}
