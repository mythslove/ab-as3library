package com.ab.utils 
{
	
	/**
	* @author ABº
	* * Co-author Promag
	*/
	import org.casalib.util.StringUtil
	
	public class ABStringUtils 
	{
		
		public function ABStringUtils() 
		{
			
		}
		
		public static function strReplace($str:String, $search:String, $replace:String):String  
		{  
			return $str.split($search).join($replace);  
		}
		
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