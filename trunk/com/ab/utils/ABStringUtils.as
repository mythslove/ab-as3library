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