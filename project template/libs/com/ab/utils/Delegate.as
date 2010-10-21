/**
* 
* @author ABº
* http://blog.antoniobrandao.com/
* 
* the classic Delegate class to execute methods in a different scope
* and pass extra parameters to the event handler
* does not work for class members
* 
* USAGE : 
* 
* 	  import com.ab.utils.Delegate
* 
* 	  Delegate.to(this, handlerFunction, arg1, arg2, etc)
* 
* DEPENDENCIES :
* 
* 	  none
*/

package com.ab.utils
{

	public class Delegate
	{
		
		static public function to(scope_obj:Object, func:Function, ... extra_arguments_array:Array):Function
		{
			var returnObject:Object = function():*
			{
				var self:Object 				= arguments.callee;
				var arguments_array:Array 		= arguments;
				var scope_obj:Object 			= self.scope_obj;
				var func:Function 				= self.func;
				var extra_arguments_array:Array = self.extra_arguments_array;
				
				return func.apply(scope_obj, arguments_array.concat(extra_arguments_array));
			}
			
			returnObject.scope_obj 				= scope_obj;
			returnObject.func 					= func;
			returnObject.extra_arguments_array 	= extra_arguments_array;
			
			var returnFunction:Function = returnObject as Function;
			return returnFunction;
		}
	}
}