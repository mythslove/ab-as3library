package com.ab.display.special
{
	/**
	* 
	* @author ABº
	* use it screw it and sell it, no problem
	* 
	* @about
	* Use this class to apply blur trail to a Sprite at the same to,e you add it to the stage
	* 
	* @requirements
	* FIRST YOU NEED TO INITIALIZE A STAGE REFERENCE
	* THIS CLASS USES CASALIB's STAGEREFERENCE CLASS
	* WHICH IS INITIALIZED IN THE ROOT WITH "StageReference.setStage(stage)"
	* IF YOU HAVE A RESIZEABLE STAGE YOU NEED TO TWEAK THIS CLASS (line 61)
	* 
	* StageReference is required (www.casalib.org)
	* 
	* @example
	* import com.ab.display.special.MotionBlurSprite;
	* import org.casalib.util.StageReference;
	* 
	* StageReference.setStage(stage);
	* 
	* var nicevarname:MotionBlurSprite = new MotionBlurSprite(sprite_name);
	* addChild(nicevarname);
	* 
	* // then add movement behaviours
	* 
	*/
	
	//import com.ab.display.ABSprite;
	import com.edigma.display.EdigmaSprite
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import org.casalib.util.StageReference;
	
	public class MotionBlurSprite extends EdigmaSprite
	{
		private var _BITMAP:Bitmap;
		private var _BITMAPDATA:BitmapData;
		private var _BLUR_FILTER:BlurFilter;
		
		private var _BITMAP_HOLDER:Sprite;
		
		private var _CONTENT_HOLDER:Sprite;
		public var _CONTENT:Sprite;
		
		private var _SPRITE:*;
		
		public function MotionBlurSprite(sprite:Sprite)
		{
			_SPRITE = sprite;
		}
		
		public function start()
		{
			setVars();
			setInteractions();
		}
		
		private function setVars():void
		{
			_BITMAPDATA 	   = new BitmapData(StageReference.getStage().stageWidth, StageReference.getStage().stageHeight, true, 0x000000);
			_BITMAP            = new Bitmap(_BITMAPDATA);
			
			_BLUR_FILTER       = new BlurFilter(4, 4, 8);
			
			_CONTENT_HOLDER    = new Sprite();
			_BITMAP_HOLDER     = new Sprite();
			_CONTENT     	   = new Sprite();
			
			this.addChildAt(_BITMAP_HOLDER, 0)
			this.addChildAt(_CONTENT_HOLDER, 1)
			
			_BITMAP_HOLDER.addChild(_BITMAP);
			_CONTENT_HOLDER.addChild(_CONTENT);
			_CONTENT.addChild(_SPRITE);
		}
		
		private function setInteractions():void
		{
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			_BITMAPDATA.draw(_CONTENT_HOLDER);
			_BITMAPDATA.applyFilter(_BITMAPDATA, _BITMAPDATA.rect, new Point(0, 0), _BLUR_FILTER);
		}
	}
}