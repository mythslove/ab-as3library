package com.ab.utils
{

	public class Delegate
	{
		/**
		* Allows you to execute a method in a different scope. This however does not work for class members.
		* It can also be used for event handlers to pass extra information to the handler.
		*
		* Internally creates a new function that will call the given method with the given scope, adding
		* the given arguments to the arguments passed to the method.
		*
		*/
		static public function create(scope_obj:Object, func:Function, ... userArguments_array:Array):Function
		{
			
			var returnObject:Object = function():*
			{
				var self:Object = arguments.callee;
				
				var arguments_array:Array = arguments;
				
				var scope_obj:Object = self.scope_obj;
				var func:Function = self.func;
				var userArguments_array:Array = self.userArguments_array;
				
				return func.apply(scope_obj, arguments_array.concat(userArguments_array));
			};
			
			returnObject.scope_obj = scope_obj;
			returnObject.func = func;
			returnObject.userArguments_array = userArguments_array;
			
			var returnFunction:Function = returnObject as Function;
			return returnFunction;
		};
	};
};