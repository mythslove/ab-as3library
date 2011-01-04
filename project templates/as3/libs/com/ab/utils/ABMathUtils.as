package com.ab.utils 
{
	/**
	 * @author ABº
	 */
	
	public class ABMathUtils
	{
		
		public function ABMathUtils() 
		{
			
		}
		
		private static function getRandomWholeNumber(min:Number, max:Number):Number 
		{ 
			return Math.round(((Math.random() * (max - min)) + min)); 
		}
		
	}

}