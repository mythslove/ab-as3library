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
	import com.addicted2flash.layout.strategy.GridLayout;	

	/**
	 * UIContainer with <code>StaticGridLayout</code>.
	 * 
	 * @author Tim Richter
	 * @see StaticGridLayout
	 */
	public class GridBox extends Container 
	{
		private var _layout: GridLayout;

		/**
		 * Creates a new <code>GridBox</code>.
		 * 
		 * @copy StaticGridLayout
		 */
		public function GridBox( rows: int, columns: int, hgap: Number = 0, vgap: Number = 0 )
		{
			super( _layout = new GridLayout( rows, columns, hgap, vgap ) );
		}
		
		/**
		 * @see GridLayout#horizontalGap
		 */
		public function get horizontalGap(): Number
		{
			return _layout.hGap;
		}
		
		/**
		 * @see GridLayout#horizontalGap
		 */
		public function set horizontalGap( gap: Number ): void
		{
			_layout.hGap = gap;
		}
		
		/**
		 * @see GridLayout#verticalGap
		 */
		public function get verticalGap(): Number
		{
			return _layout.vGap;
		}
		
		/**
		 * @see GridLayout#verticalGap
		 */
		public function set verticalGap( gap: Number ): void
		{
			_layout.vGap = gap;
		}
		
		/**
		 * @see GridLayout#flow
		 */
		public function get flow(): int
		{
			return _layout.flow;
		}
		
		/**
		 * @see GridLayout#flow
		 */
		public function set flow( flow: int ): void
		{
			_layout.flow = flow;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function toString(): String
		{
			return "[ GridBox ]";
		}
	}
}
