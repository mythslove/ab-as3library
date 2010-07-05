package com.senocular.gyro {
	
	public interface IInterpolate {
		function interpolate(t:Number):void;
		function get owner():*;
		function set owner(value:*):void;
		function get property():Object;
		function set property(value:Object):void;
	}
}