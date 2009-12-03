﻿package com.ab.utils 
{
	/**
	* @author ABº
	* 
	* http://blog.antoniobrandao.com/
	*/
	
	public class ABArrayUtils 
	{	
		public static function shuffleArray(arr:Array):Array 
		{
			var len:int = arr.length;
			var temp:*;
			var i:int = len;
			
			while (i--) 
			{
				var rand:int = Math.floor(Math.random() * len);
				temp = arr[i];
				arr[i] = arr[rand];
				arr[rand] = temp;
			}
			
			return arr;
		}
		
	}
	
}