package com.ab.ui.menu
{
	/**
	* @author ABº
	*/
	
	import flash.display.Sprite;
	import com.ab.display.ABSprite;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import org.casalib.util.ArrayUtil;
	import flash.display.DisplayObject;
	import abcms.menusections.assets.SectionItem
	
	/// use ABSPRITES as MEMBERS
	
	public class DynamicStackMenu// extends Sprite
	{
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// VARS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// VARS
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// VARS
		
		private var _ITEM_SPACING:int;
		
		private var _OBJECTS_ARRAY:Array = [];
		public var _TRANSITION_STYLE:String;
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// CONSTRUCTOR
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// CONSTRUCTOR
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// CONSTRUCTOR
		
		public function DynamicStackMenu(object_array:Array, transition_style:String="EaseOutSine", item_spacing:int=5) //parent:Object, 
		{
			_OBJECTS_ARRAY    = object_array;
			_TRANSITION_STYLE = transition_style;
			_ITEM_SPACING     = item_spacing;
			//_PARENT           = _caller;
			
			buildMenu()
		}
		
		private function buildMenu():void
		{
			for (var i:int = 0; i < _OBJECTS_ARRAY.length; i++) 
			{
				_OBJECTS_ARRAY[i].y = (_OBJECTS_ARRAY[i].height + _ITEM_SPACING) * i;
				_OBJECTS_ARRAY[i].index = i;
				_OBJECTS_ARRAY[i].buttonMode = true;
				_OBJECTS_ARRAY[i].addEventListener( MouseEvent.MOUSE_DOWN, onITEMPress );
				_OBJECTS_ARRAY[i].addEventListener( MouseEvent.MOUSE_UP, onITEMRelease );
			}
			
			sortItems();
		}
		
		private function onITEMPress( event:MouseEvent ):void
		{
			event.currentTarget.parent.setChildIndex( event.currentTarget as SectionItem, event.currentTarget.parent.numChildren - 1 ); //parent.numChildren-1  
			event.currentTarget.startDrag();
		}
		
		private function onITEMRelease( event:MouseEvent ):void
		{
			event.currentTarget.stopDrag();
			sortItems();
		}
		
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PUBLIC
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PUBLIC
		/// /// /// /// /// /// /// /// /// /// /// /// /// /// /// PUBLIC
		
		public function sortItems():void
		{
			_OBJECTS_ARRAY.sortOn( 'y', Array.NUMERIC );
			
			for (var i:int = 0; i < _OBJECTS_ARRAY.length; i++) 
			{
				Tweener.addTween( _OBJECTS_ARRAY[i], { x:0, y:(_OBJECTS_ARRAY[i].height + _ITEM_SPACING) * i, time:0.5, transition:_TRANSITION_STYLE } );
			}
		}
		
		public function addItem(_object:Object):void
		{
			_OBJECTS_ARRAY.push(_object);
			
			sortItems()
		}
		
		public function removeItem(_object:Object):void
		{
			ArrayUtil.removeItem(_OBJECTS_ARRAY, _object)
			
			//_object.destroy()
			
			sortItems()
		}
		
	}
	
}