package com.ab.core
{
	/**
	* @author ABº
	* 
	* Esta classe reúne todos os métodos essenciais das classes centrais numa API prática
	*/
	
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.ColorTransform;
	import org.casalib.util.StageReference;
	
	public class COREUtils
	{
		/**
		 * Center object in stage
		 * Centers a display object in the center of the stage
		 * @return	Nothing.
		 */
		public static function centerObjectInStage(object:DisplayObject, smooth:Boolean=false, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0):void
		{
			if (object) 
			{
				var new_x_pos:Number = Math.round((stage.stageWidth  / 2) - (object.width  / 2));
				var new_y_pos:Number = Math.round((stage.stageHeight / 2) - (object.height / 2));
				
				if (smooth) 
				{
					Tweener.addTween(object, { x:new_x_pos, y:new_y_pos, time:_time, transition:_transition, delay:_delay } );
				}
				else
				{
					object.x = new_x_pos;
					object.y = new_y_pos;
				}
			}
		}
		
		/**
		 * Center object in other object
		 * Centers a display object in the center of another display object.
		 * @return	Nothing.
		 */
		public static function centerObjectInOtherObject(object_a:DisplayObject, object_b:DisplayObject, smooth:Boolean=false, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0):void
		{
			var new_x_pos:Number = Math.round((object_b.width  / 2) - (object_a.width  / 2));
			var new_y_pos:Number = Math.round((object_b.height / 2) - (object_a.height / 2));
			
			if (smooth) 
			{
				Tweener.addTween(object_a, { x:new_x_pos, y:new_y_pos, time:_time, transition:_transition, delay:_delay } );
			}
			else
			{
				object_a.x = new_x_pos;
				object_a.y = new_y_pos;
			}
		}
		
		/**
		 * Center object in stage X
		 * @return	Nothing.
		 */
		public static function centerObjectInStageX(object:DisplayObject, smooth:Boolean=false, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0):void
		{
			var new_x_pos:Number = Math.round((stage.stageWidth / 2) - (object.width / 2));
			
			if (smooth) 
			{
				Tweener.addTween(object, { x:new_x_pos, time:_time, transition:_transition, delay:_delay } );
			}
			else { object.x = new_x_pos; }
		}
		
		/**
		 * Center object in stage Y
		 * @return	Nothing.
		 */
		public static function centerObjectInStageY(object:DisplayObject, smooth:Boolean=false, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0):void
		{
			var new_y_pos:Number = Math.round((stage.stageHeight / 2) - (object.height / 2));
			
			if (smooth) 
			{
				Tweener.addTween(object, { y:new_y_pos, time:_time, transition:_transition, delay:_delay } );
			}
			else { object.y = new_y_pos; }
		}
		
		/**
		 * Sets the alpha value of an object
		 * @return	Nothing.
		 */
		public static function setAlpha(object:DisplayObject, alpha_value:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			Tweener.addTween(object, { alpha:alpha_value, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
		}
		
		/**
		 * Makes an object visible
		 * @return	Nothing.
		 */
		public static function makeVisible(object:DisplayObject, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			Tweener.addTween(object, { alpha:1, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
		}
		
		/**
		 * Makes an object invisible
		 * @return	Nothing.
		 */
		public static function makeInvisible(object:DisplayObject, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0):void
		{
			Tweener.addTween(object, { alpha:0, time:_time, transition:_transition, delay:_delay, onComplete:function():void { object.visible = false } } );
		}
		
		/**
		 * Colorize Object
		 * This method changes the color of an object
		 * The colour parameter may come as uint or String
		 * @return	nothing.
		 */
		public static function colorizeObject(object:*, colour:*, _time:Number=0.5, _transition:String = "EaseOutSine" ):void
		{
			trace("colour : " + colour);
			if (_time != 0)
			{
				Tweener.addTween(object, { _color:colour, time:_time, transition:_transition } );
			}
			else
			{
				if (object.transform) 
				{
					var newColorTransform:ColorTransform 	= object.transform.colorTransform;
					newColorTransform.color 				= colour;
					object.transform.colorTransform 		= newColorTransform;	
				}
				else
				{
					trace("COREUtils: Colorize() ::: Cannot paint - Provided object has no transform property.");
				}
				
			}
		}
		
		/**
		 * Moves an Object in X and Y coordinates
		 * @return	Nothing.
		 */
		public static function moveObject(object:DisplayObject, new_x:Number, new_y:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			if (_time != 0) 
			{
				Tweener.addTween(object, { x:new_x, y:new_y, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
			}
			else
			{
				object.x = new_x;
				object.y = new_y;
				
				if (onCompleteFunc != null) 
				{
					onCompleteFunc();
				}
			}
		}
		
		/**
		 * Moves an Object in X coordinates
		 * @return	Nothing.
		 */
		public static function moveObjectX(object:DisplayObject, new_x:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			if (_time != 0) 
			{
				Tweener.addTween(object, { x:new_x, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
			}
			else
			{
				object.x = new_x;
				
				if (onCompleteFunc != null) 
				{
					onCompleteFunc();
				}
			}
		}
		
		/**
		 * Moves an Object in Y coordinates
		 * @return	Nothing.
		 */
		public static function moveObjectY(object:DisplayObject, new_y:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			if (_time != 0) 
			{
				Tweener.addTween(object, { y:new_y, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
			}
			else
			{
				object.y = new_y;
				
				if (onCompleteFunc != null) 
				{
					onCompleteFunc();
				}
			}
		}
		
		/**
		 * Moves an Object in X and Y coordinates
		 * @return	Nothing.
		 */
		public static function moveObjectXY(object:DisplayObject, new_x:Number, new_y:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			Tweener.addTween(object, { x:new_x, y:new_y, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
		}
		
		/**
		 * Resizes the Width of an object
		 * @return	Nothing.
		 */
		public static function resizeObjectWidth(object:DisplayObject, new_width:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			Tweener.addTween(object, { width:new_width, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
		}
		
		/**
		 * Resizes the Height of an object
		 * @return	Nothing.
		 */
		public static function resizeObjectHeight(object:DisplayObject, new_height:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			Tweener.addTween(object, { height:new_height, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
		}
		
		/**
		 * Resizes the Width and Height of an object
		 * @return	Nothing.
		 */
		public static function resizeObjectWidthAndHeight(object:DisplayObject, new_width:Number, new_height:Number, _time:Number=0.5, _transition:String="EaseOutSine", _delay:Number=0, onCompleteFunc:Function=null):void
		{
			object.visible = true;
			
			Tweener.addTween(object, { width:new_width, height:new_height, time:_time, transition:_transition, delay:_delay, onComplete:onCompleteFunc } );
		}
		
		/**
		 * Stage acess
		 * This method provides direct access to the stage
		 * @return	stage.
		 */
		public static function get stage():Stage
		{
			return StageReference.getStage();
		}
	}
	
}
