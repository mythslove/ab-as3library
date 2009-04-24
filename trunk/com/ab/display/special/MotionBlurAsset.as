package com.ab.display.special
{
	/**
	* 
	* @author ABº
	* use it screw it and sell it, no problem
	* 
	* @about
	* Use this class to take a symbol from your library,
	* add it to the stage, and if it moves it will have a blur trail
	* 
	* @requirements
	* FIRST YO NEED TO INITIALIZE A STAGE REFERENCE
	* THIS CLASS USES CASALIB's STAGEREFERENCE CLASS
	* WHICH IS INITIALIZED IN THE ROOT WITH "StageReference.setStage(stage)"
	* IF YOU HAVE A RESIZEABLE STAGE YOU NEDD TO TWEAK THIS CLASS (line 61)
	* 
	* @example
	* import com.ab.display.special.MotionBlurAsset;
	* import org.casalib.util.StageReference;
	* 
	* StageReference.setStage(stage);
	* 
	* var nicevarname:MotionBlurAsset = new MotionBlurAsset(library_asset_linkage_name);
	* addChild(nicevarname);
	* 
	* // then add movement behaviours
	* 
	*/
	
	import com.ab.display.ABSprite;
	import flash.display.Sprite
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	import org.casalib.util.StageReference;
	
	public class MotionBlurAsset extends Sprite
	{
		private var _BITMAP:Bitmap;
		private var _BITMAPDATA:BitmapData;
		private var _BLUR_FILTER:BlurFilter;
		
		private var _BITMAP_HOLDER:Sprite;
		
		private var _CONTENT_HOLDER:Sprite;
		public var _CONTENT:Sprite;
		
		private var _LINKAGE_NAME:*;
		
		public function MotionBlurAsset(linkage_name:*)
		{
			_LINKAGE_NAME = linkage_name;
			
			setVars();
			setInteractions();
		}
		
		private function setVars():void
		{
			_BITMAPDATA 	   = new BitmapData(StageReference.getStage().stageWidth, StageReference.getStage().stageHeight, true, 0x000000);
			_BITMAP            = new Bitmap(_BITMAPDATA);
			
			_BLUR_FILTER       = new BlurFilter(4, 4, 5);
			
			_CONTENT_HOLDER    = new Sprite();
			_BITMAP_HOLDER     = new Sprite();
			_CONTENT     	   = new Sprite();
			
			
			this.addChildAt(_BITMAP_HOLDER, 0)
			this.addChildAt(_CONTENT_HOLDER, 1)
			
			_BITMAP_HOLDER.addChild(_BITMAP);
			
			_CONTENT_HOLDER.addChild(_CONTENT);
			
			_CONTENT.addChild(new _LINKAGE_NAME());
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