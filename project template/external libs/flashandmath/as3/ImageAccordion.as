/*
ActionScript 3 Tutorials by Dan Gries and Barbara Kaskosz.
www.flashandmath.com
See the tutorial at
http://www.flashandmath.com/flashcs4/leo/
for explanations how to use the class.
Last modified: March 28, 2010.
*/

package flashandmath.as3 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
	public class ImageAccordion extends Sprite 
	{
		private var numSlices:int;
		private var imgData:BitmapData;
		private var sliceWidth:Number;
		private var sliceHeight:Number;
		private var picWidth:Number;
		private var picHeight:Number;
		private var sliceBmps:Array;		
		private var container:Sprite;
		private var isMoving:Boolean;
		private var maxAng:Number;
		private var paramTween:Tween;		
		public var tweenDownDuration:Number;
		public var tweenUpDuration:Number;
		private var paramObj:Object;
		private var isClosed:Boolean;
		private var isOpen:Boolean;
		private var lightEdgeFactor:Number;
		private var darkEdgeFactor:Number;
		
		/*
		Constructor begins. The constructor takes four parameters (three are optional).
		The first parameter is the BitmapData object for your image. You can get it by importing
		an image to the Library in Flash and linking to AS3 or by embedding in Flex or
		by loading at runtime. 'df' and 'lf' will be assigned as values for 'darkEdgeFactor'
		and 'lightEdgeFactor'. Those values will determine the amount of darkening for the bottom
		edges of the accordion and the amount of lightening for the top edges. 'df' works best if it is between
		0 and 1, the larger 'df' the more darkening. Similarly 'lf' works best if it is between 0 and 2.
		Again the larger 'lf' the more lightening. The default settings work well with light images.
		The last parameter in the number of wedges in your accordion.
		*/
		
		public function ImageAccordion(bd:BitmapData, df:Number = 0.5, lf:Number = 0, sl:int = 10) 
		{
			numSlices = sl;
			
			imgData = bd.clone();
			
			picWidth = imgData.width;
			
			picHeight = imgData.height;
			
			sliceHeight = picHeight / numSlices;
			
			sliceWidth = picWidth;
			
			tweenDownDuration = 50;
			
			tweenUpDuration = 40;
			
			maxAng = 80;
			
			paramObj = { t:maxAng };
			
			container = new Sprite();
			
			this.addChild(container);
			
			container.x = -picWidth / 2;
			
			container.y = -picHeight / 2;
			
			createSlices();
			
			setUpListeners();
			
			isClosed = true;
			
			isOpen = false;
			
			isMoving = false;
			
			lightEdgeFactor = lf;
			
			darkEdgeFactor=df;
			
			foldAccordion(maxAng);  
		}
		
		private function createSlices():void 
		{
			var k:int;
			
			var slices:Array = [];
			
			sliceBmps = [];
			
			for (k = 0; k < numSlices; k++)
			{
				slices[k]=new BitmapData(sliceWidth,sliceHeight);
				
				slices[k].copyPixels(imgData,new Rectangle(0,k*sliceHeight,sliceWidth,sliceHeight),new Point(0,0));
				
				sliceBmps[k]=new Bitmap(slices[k]);
				
				container.addChild(sliceBmps[k]);
				
				sliceBmps[k].x=0;
				
				sliceBmps[k].y=sliceHeight*k;
				
				sliceBmps[k].z=0;
			}
		}
		
		private function foldAccordion(deg:Number):void 
		{
			var k:int;
			
			var evenFactor:Number;
			
			var oddFactor:Number;
			
			evenFactor=(-darkEdgeFactor/maxAng)*deg+1;
			
			oddFactor=(lightEdgeFactor/maxAng)*deg+1;
			
			var rad:Number=deg*Math.PI/180;
			
			for (k = 0; k < numSlices; k++)
			{
				sliceBmps[k].rotationX=deg*Math.pow(-1,k);
				
				if (k % 2 == 1)
				{
					
					sliceBmps[k].z=sliceHeight*Math.sin(rad);
					
					sliceBmps[k].y=sliceHeight*Math.cos(rad)*k;
					
					sliceBmps[k].transform.colorTransform=new ColorTransform(oddFactor,oddFactor,oddFactor,1,0,0,0,0);	
				} 
				else 
				{
					sliceBmps[k].z=0;
					
					sliceBmps[k].y=sliceHeight*Math.cos(rad)*k;
					
					sliceBmps[k].transform.colorTransform=new ColorTransform(evenFactor,evenFactor,evenFactor,1,0,0,0,0);	
				}
			}
		}
		
		private function setUpListeners():void 
		{
			container.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		function onClick(e:MouseEvent):void 
		{
			if (isMoving) { return; }
			
			if (isClosed) 
			{				
				isMoving=true;
				
				paramTween = new Tween(paramObj, "t", Bounce.easeOut, maxAng, 0, tweenDownDuration);
				
				paramTween.addEventListener(TweenEvent.MOTION_CHANGE, goDown);
				paramTween.addEventListener(TweenEvent.MOTION_FINISH, goDownComplete);
				
			} 
			
			if (isOpen)
			{
				isMoving=true;
				
				paramTween = new Tween(paramObj, "t", Bounce.easeOut, 0, maxAng, tweenUpDuration);
				
				paramTween.addEventListener(TweenEvent.MOTION_CHANGE, goUp);
				paramTween.addEventListener(TweenEvent.MOTION_FINISH, goUpComplete);	
			}
		}
		
		private function goDown(tevt:TweenEvent):void 
		{
			foldAccordion(paramObj.t);
		}
		
		private function goDownComplete(tevt:TweenEvent):void 
		{
			isMoving=false;
			isClosed=false;
			isOpen=true;
			
			paramTween.removeEventListener(TweenEvent.MOTION_CHANGE, goDown);
			paramTween.removeEventListener(TweenEvent.MOTION_FINISH, goDownComplete);
		}
		
		
		private function goUp(tevt:TweenEvent):void 
		{
			foldAccordion(paramObj.t);	
		}
		
		private function goUpComplete(tevt:TweenEvent):void 
		{
			isMoving=false;
			isClosed=true;
			isOpen=false;
			
			paramTween.removeEventListener(TweenEvent.MOTION_CHANGE, goUp);
			paramTween.removeEventListener(TweenEvent.MOTION_FINISH, goUpComplete);
		}
	}
}