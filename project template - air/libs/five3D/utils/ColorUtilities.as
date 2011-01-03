/*//////////////////////////////////////////////////////////////////////////////////////////////////////////

  FIVe3D v2.1.2  -  2008-10-12
  Flash Interactive Vector-based 3D
  Mathieu Badimon  |  five3d.mathieu-badimon.com  |  www.mathieu-badimon.com  |  contact@mathieu-badimon.com

/*//////////////////////////////////////////////////////////////////////////////////////////////////////////

package five3D.utils {

	import flash.geom.ColorTransform;

	public class ColorUtilities {

		static public function setBrightness(colortransform:ColorTransform, value:Number):void {
			if (value > 1) value = 1;
			else if (value < -1) value = -1;
			var percent:Number = 1 - Math.abs(value);
			var offset:Number = 0;
			if (value > 0) offset = value * 255;
			colortransform.redMultiplier = colortransform.greenMultiplier = colortransform.blueMultiplier = percent;
			colortransform.redOffset = colortransform.greenOffset = colortransform.blueOffset = offset;
		}

	}

}