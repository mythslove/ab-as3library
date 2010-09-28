
/**
* @author ABº
* http://blog.antoniobrandao.com/
* 
* Handy class to detect the famous HitTest
* supports detection for individual objects or a collection of objects stored in an Array
* make sure you pass a valid stage reference - if needed use CasaLib's stagereference class http://casalib.org
* 
* 
* USAGE : 
* 
* 	  import com.ab.utils.HitTest
* 
* 	  if( MouseHitObject(object_instance_name, stage) == true)
* 	  {
* 	      createPanic();
*     }
* 
* DEPENDENCIES :
* 
* 	  none, just assure you pass a valid stage reference
*/

package com.ab.utils
{
	import flash.display.Stage;
   
	public class HitTest
	{
		public static function MouseHitObject(_object_ref:Object, _stage_ref:Stage):Boolean
		{
			if (_object_ref.hitTestPoint(_stage_ref.mouseX, _stage_ref.mouseY, true)) 
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public static function MouseHitAnyObjectFromArray(_array_ref:Object, _stage_ref:Stage):Boolean
		{
			var hit_found:Boolean = false;
			
			for (var i:int = 0; i < _array_ref.length; i++) 
			{
				if (_array_ref[i].hitTestPoint(_stage_ref.mouseX, _stage_ref.mouseY, true)) 
				{
					hit_found = true;
				}
			}
			
			return hit_found;
		}
	}
}