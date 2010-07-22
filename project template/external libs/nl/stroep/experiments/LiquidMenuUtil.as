package nl.stroep.experiments 
{
	
	/**
	 * ...
	 * @author Mark Knol - Stroep.nl - 2009 (c)
	 */
	public class LiquidMenuUtil 
	{
		
		public static function getItemWidth(textList:Array, index:int = 0, fullMenuWidth:Number = 800, mode:String = "mode_liquid_normalized"  ):Number
		{
			var normalizedList:Array = [];
			var totalTextLength:Number = 0;
			
			// precalc normalized textlengths
			for (var i:int = 0; i < textList.length; ++i) 
			{
				var textLength:Number = textList[i].length;
				var normalizedTextLength:Number = (mode == LiquidMenuModes.MODE_LIQUID_NORMALIZED) ? Math.sqrt(textLength) : textLength;
				totalTextLength += normalizedTextLength;
				normalizedList.push(normalizedTextLength);				
			}
			
			var retval:Number;
			
			switch(mode)
			{
				case LiquidMenuModes.MODE_LIQUID_NORMALIZED:
					retval = fullMenuWidth / (totalTextLength / normalizedList[index]);
					break;
					
				case LiquidMenuModes.MODE_LIQUID:
					retval = fullMenuWidth / (totalTextLength / normalizedList[index]);
					break;
					
				case LiquidMenuModes.MODE_LIQUID_FIXED:
					retval = fullMenuWidth / normalizedList.length;
					break;
					
				default :
					trace("invalid mode");
			}
			
			return retval;
		
		}
		
	}
	
}