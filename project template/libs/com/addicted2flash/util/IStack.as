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
	/**
	 * The IStack interface represents a last-in-first-out (LIFO) stack of elements.
	 * 
	 * @author Tim Richter
	 */
	public interface IStack extends ICollection
	{
		/**
		 * Looks at the object at the top of this stack without removing it from the stack.
		 * 
		 * @return element at the top of this stack
		 * @throws EmptyStackException if stack is empty
		 */
		function peek(): *;
		
		/**
		 * Pushes an element onto the top of this stack.
		 * 
		 * @param o item to be pushed onto this stack
		 * @return item argument
		 */
		function push( o: * ): *;
		
		/**
		 * removes the element at the top of this stack and returns that object as the value of this function.
		 * 
		 * @return element at the top of this stack
		 * @throws EmptyStackException if stack is empty
		 */
		function pop(): *;
		
		/**
		 * return index of element in the stack.
		 * If element doesn't exist, return value is -1;
		 * 
		 * @return index of element in the stack
		 */
		function indexOf( o: * ): int;
	}
}
