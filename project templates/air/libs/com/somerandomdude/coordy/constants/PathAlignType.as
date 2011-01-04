 /*
The MIT License

Copyright (c) 2009 P.J. Onori (pj@somerandomdude.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

package com.somerandomdude.coordy.constants
{
	/**
	 * 
	 * @author P.J. Onori
	 * 
	 */
	public class PathAlignType
	{
		/**
		 * Nodes rotation is parallel to the layout's path 
		 */		
		public static const ALIGN_PARALLEL:String="alignParallel";
		
		/**
		 * Nodes rotation is perpendicular to the layout's path 
		 */		
		public static const ALIGN_PERPENDICULAR:String="alignPerpendicular";
		
		/**
		 * Nodes do not alter rotation to the layout's path 
		 */		
		public static const NONE:String="noAlign";
	}
}