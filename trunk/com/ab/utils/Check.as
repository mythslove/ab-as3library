package com.ab.utils 
{
	
	/**
	* 
	* @author ABº
	* 
	* @example
	* import com.ab.utils.Check
	* 
	* var test:Boolean = Check.Email(email_string)
	* 
	* if (test == true) { be happy };
	* 
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