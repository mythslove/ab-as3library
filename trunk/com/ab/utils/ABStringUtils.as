package com.ab.utils 
{
	
	/**
	* @author ABº
	* http://blog.antoniobrandao.com/
	* Co-author Promag (http://blog.namespacepromag.com/
	* 
	*/
	import org.casalib.util.StringUtil
	

	/**
	 * ABStringUtils 
	 */
	
	public class ABStringUtils 
	{
		
		public function ABStringUtils() 
		{
			
		}
		
		/**
		 * Replace parameter in string.
		 * @param $str - string to search in.
		 * @param &string - string to search for.
		 * @param $replace - substring to replace in string.
		 * @example <listing version="1.0">
		 * 		var new_var = "cat=23"
		 * 		ABStringUtils.strReplace(new_var, "cat", "item")
		 * 		// trace(new_var) outputs "item=23"
		 * </listing>
		 * @return Object
		 */
		public static function strReplace($str:String, $search:String, $replace:String):String  
		{  
			return $str.split($search).join($replace);  
		}
		
		/**
		 * Capitalize a word (First character upper case, all others lower case)
		 * @param word - string to capitalize.
		 * @return String
		 * @example <listing version="1.0">
		 * 		var new_word = ABStringUtils.capitalizeWord("capitalized")
		 * </listing>
		 */
		public static function capitalizeWord(word:String):String
		{
			return word.charAt(0).toUpperCase() + word.slice(1, word.length);
		}
		/**
		 * Extract all values from eg. SWFAddress strings etc.
		 * @param _string - string to search in.
		 * @param _param - parameter to search in string.
		 * @return Object
		 * @example <listing version="1.0">
		 * 		var new_var = ABStringUtils.getParamValues(SWFAddress.getValue())
		 * 		var another_new_var = ABStringUtils.getParamValues(Gaia.api.getDeeplink())
		 * </listing>
		 */
		public static function getParamValues(_string:String):Object
		{
			var o = new Object();
			
			for each(var t:String in _string.substr(1).split('&'))
			{
				var a:Array = t.split('=');
				o[a[0]] = a[1];
			}
			
			return o;
		}
		
		/**
		 * Generate a random string (with letters and numbers)
		 * @param lengh - length of the random string to generate.
		 * @return String
		 * @example <listing version="1.0">
		 * 		var random_string = ABStringUtils.randomString(20)
		 * </listing>
		 */
		public static function randomString(length:int = 9):String
		{
			var chars:String  = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
			var result:String = '';
			
			for (var i:int = 0; i < length; i++)
					result += chars.substr(Math.floor(Math.random() * chars.length), 1);
			return result;
		}
		/**
		 * Extract specific values from eg. SWFAddress strings etc.
		 * @param _string - string to search in.
		 * @param _param - parameter to search in string.
		 * @return String with value or empty string on failure
		 * @example <listing version="1.0">
		 * 		var new_var = ABStringUtils.getParamFromString(SWFAddress.getValue(), "item")
		 * 		var another_new_var = ABStringUtils.getParamFromString(Gaia.api.getDeeplink(), "cat")
		 * </listing>
		 */
		public static function getParamFromString(_string:String, _param:String):String
		{
			_string = StringUtil.remove(_string, "/")
			
			var o = new Object();
			
			var found:String = ""
			
			for each(var t:String in _string.substr(0).split('&'))
			{
				var a:Array = t.split('=');
				o[a[0]] = a[1];
				
				if (a[0] == _param) 
				{
					found = a[1];
				}
				
			}
			
			return found;
		}
	}
	
}