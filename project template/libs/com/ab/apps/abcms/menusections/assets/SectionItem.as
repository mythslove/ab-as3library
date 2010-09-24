package abcms.menusections.assets 
{
	/**
	* @author ABº
	*/
	
	import flash.display.MovieClip;
	
	public class SectionItem extends MovieClip
	{
		public var index:uint;
		
		public var _ID:int;
		public var _ACTIVE:Boolean;
		public var _DATA:Object;
		public var _TITLE:String;
		public var _DESCRIPTION:Object;
		private var _PARENT_ID:int;
		private var _CREATED_AT:String;
		private var _POSITION:Number;
		
		//public function SectionItem(o:Object) 
		public function SectionItem() 
		{
			/*
			_DATA 			= o;
			
			_ID 			= _DATA.id
			_PARENT_ID 		= _DATA.parent_id 
			_TITLE 			= _DATA.name 
			_DESCRIPTION 	= _DATA.description 
			_CREATED_AT 	= _DATA.created_at
			_ACTIVE 		= _DATA.active
			_POSITION 		= _DATA.position
			
			trace("ElasticTreeItem _DATA = " + _DATA.id);*/
		}
		
		public function select()
		{
			trace("select")
		}
		
		public function get id():int 						{ return _ID  			};
		public function set id(value:int):void  			{ _ID = value 			};
		
		public function get active():Boolean 				{ return _ACTIVE  		};
		public function set active(value:Boolean):void  	{ _ACTIVE = value 		};
		
		public function get data():Object 					{ return _DATA  		};
		public function set data(value:Object):void  		{ _DATA = value 		};
		
		public function get title():String 					{ return _TITLE  		};
		public function set title(value:String):void  		{ _TITLE = value 		};
		
		public function get description():Object 			{ return _DESCRIPTION  	};
		public function set description(value:Object):void  { _DESCRIPTION = value 	};
		
		public function get parent_id():int 				{ return _PARENT_ID  	};
		public function set parent_id(value:int):void 		{ _PARENT_ID = value 	};
		
		public function get created_at():String 			{ return _CREATED_AT  	};
		public function set created_at(value:String):void	{ _CREATED_AT = value 	};
		
		public function get position():Number 				{ return _POSITION  	};
		public function set position(value:Number):void  	{ _POSITION = value 	};
		
	}
	
}