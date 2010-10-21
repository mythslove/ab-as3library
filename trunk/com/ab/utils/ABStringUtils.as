package com.ab.utils 
{
	/**
	 * ABStringUtils 
	 * @author ABº
	 * http://blog.antoniobrandao.com/
	 */
	
	import org.casalib.util.StringUtil
	
	public class ABStringUtils 
	{
		private static const POSSIBLE_CHARS:Array = ["abcdefghijklmnopqrstuvwxyz", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "0123456789", "~`!@#$%^&*()_-+=[{]}|;:'\"\\,<.>/?"];
		
		public function ABStringUtils()  {  }
		
		/**
		 * Returns a String containing the extension of a filename String.
		 * @param $str - string to process.
		 * @example <listing version="1.0">
		 * 		var new_var = "cat=23"
		 * 		ABStringUtils.extensionOfFile("filename_string.flv")
		 * 		// trace(new_var) outputs "flv"
		 * </listing>
		 * @return Object
		 */
		public static function extensionOfFile($str:String):String  
		{  
			var str2return:String;
			
			if ($str.length < 2)
			{
				trace("ABStringUtils ::: strReplace(): provided string must have at least two characters");
			}
			else
			{
				str2return = String($str).substr(String($str).lastIndexOf("."), String($str).length - 1);
			}
			
			return str2return;
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
		 * Extract all values from eg. SWFAddress strings etc. 
		 * Co-author Promag (http://blog.namespacepromag.com/
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
		 * Co-author Promag (http://blog.namespacepromag.com/
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
		
		/**
		 * Remove HTML tags from a String.
		 * @param string - string to search in.
		 * @return String without HTML tags
		 * @example <listing version="1.0">
		 * 		var plain_text = ABStringUtils.removeHTMLTags(html_text)
		 * </listing>
		 */
		public static function removeHTMLTags ( string : String ) : String
		{
			return string.replace( /<.*?>/g , "" ) ;
		}
		
		/**
		 * Replace HTML tags with a given string.
		 * @param string  - String with HTML tags.
		 * @param replace - String to use instead of any HTML tag in original string.
		 * @return String with HTML tags replaced
		 * @example <listing version="1.0">
		 * 		var new_string = ABStringUtils.replaceHTMLTags(html_string, "something")
		 * </listing>
		 */
		public static function replaceHTMLTags ( string : String , replace : String ) : String
		{
			return string.replace( /<.*?>/g , replace ) ;
		}
		
		/**
		 * Converts ActionScript line breaks to the HTML equivalent tag.
		 * @param string - string to update.
		 * @return String with HTML tags for line breaks
		 * @example <listing version="1.0">
		 * 		var html_string = ABStringUtils.convertLineBreaksToHTML(actionscript_string)
		 * </listing>
		 */
		public static function convertLineBreaksToHTML ( string : String ) : String
		{
			return string.split( String.fromCharCode( 13 ) ).join( "<br />" ) ;
		}
		
		/**
		 * Removes whitespaces from a given String.
		 * @param string - string to search in.
		 * @return String without whitespaces
		 * @example <listing version="1.0">
		 * 		var new_var = ABStringUtils.removeWhiteSpace(some_string)
		 * </listing>
		 */
		public static function removeWhiteSpace ( string : String ) : String
		{
			return string.split( " " ).join( "" ) ;
		}
		
		/**
		 * Remove extra slashes.
		 * @param string - string to search in.
		 * @return String without slashes
		 * @example <listing version="1.0">
		 * 		var new_var = ABStringUtils.stripExtraSlashes(some_string)
		 * </listing>
		 */
		public static function stripExtraSlashes ( string : String ) : String
		{
			while ( string.charAt( string.length - 1 ) == "/" )
			{
				string = string.substr( 0 , string.length - 1 ) ;
			}
			if ( string.charAt( 0 ) == "/" ) string = string.substr( 1 , string.length ) ;
			return string ;
		}
		
		/**
		 * Generate a strong password String.
		 * @param length - length of desired password.
		 * @return a strong password
		 * @example <listing version="1.0">
		 * 		var new_password = ABStringUtils.generateStrongPassword(12)
		 * </listing>
		 */
		private function generateStrongPassword(length:uint = 32):String 
		{
			if (length < 8) length = 8;
			var pw:String = new String();
			var charPos:uint = 0;
			
			while (pw.length < length)
			{
				var chars:String = POSSIBLE_CHARS[charPos];
				var char:String = chars.charAt(this.getRandomWholeNumber(0, chars.length - 1));
				var splitPos:uint = this.getRandomWholeNumber(0, pw.length);
				pw = (pw.substring(0, splitPos) + char + pw.substring(splitPos, pw.length));
				charPos = (charPos == 3) ? 0 : charPos + 1;
			}
			return pw; 
		}
		
		
	}
	
}