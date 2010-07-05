package com.senocular.gyro {
	
	public class AbstractInterpolateFilter extends Interpolate {
			
		protected var _isFilter:Boolean;
		
		override public function set owner(value:*):void {
			_owner = value;
			updateIsFilter();
		}
		
		override public function set property(value:Object):void {
			_property = value;
			updateIsFilter();
		}
			
		public function AbstractInterpolateFilter(owner:* = null, property:Object = null){			
			super(owner, property);
			updateIsFilter();
		}
		
		protected function updateIsFilter():void {
			_isFilter = Boolean("filters" in _owner && _property != null && !isNaN(Number(_property)));
		}
		
		protected function assign(target:*):void {
			if (target == null) return;
			
			if (_isFilter) {
				var filters:Array = _owner.filters;
				filters[_property] = target;
				owner.filters = filters;
			}else if (_owner && _property != null){
				_owner[_property] = target;
			}
		}
	}
}