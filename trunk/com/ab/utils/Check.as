package com.ab.utils 
{
	
	/**
	* @author ABº
	*/
	
	public class Check 
	{
		
		public function Check() 
		{
			
		}
		
		public static function Email(str : String) : Boolean 
		{
			var emailExpression : RegExp = /^[a-z][\w.-]+@\w[\w.-]+\.[\w.-]*[a-z][a-z]$/i;
			return emailExpression.test( str );
		}
		
	}
	
}