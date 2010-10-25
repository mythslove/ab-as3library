package com.ab.apps.abcms.mainmodules.menu 
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.abcms.mainmodules.configurators.ABCMSSiteTextFormats;
	import com.ab.lang.I18N;
	import com.ab.lang.I18NEvent;
	import com.ab.menu.SideTabMenu;
	import com.ab.menu.SideTabMenuItem;
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import com.ab.core.AppLevelsManagement;
	
	public class ABCMSMainMenuItem extends SideTabMenuItem
	{
		public var data = {
			title: { en: "Untitled", pt: "Sem titulo" },
			description: { en: "Untitled", pt: "Sem titulo" },
			module_class: null 
		};
		
		private var title_tf:TextField;
		private var desc_tf:TextField;
		private var bg:Sprite;
		private var _menu:ABCMSMainMenu;
		private var _text_x:Number = 10;
		private var _bg_colour:uint=0xcccccc;
		private var _bg_alpha:Number=0.05;
		
		//public function ABCMSMainMenuItem(data = null, root:ABCMSMainMenu=null) 
		public function ABCMSMainMenuItem(root:ABCMSMainMenu=null) 
		{
			//if (data) this.data = data;
			
			_menu = root;
			
			initVars();
			addListeners()
		}
		
		private function initVars():void
		{
			title_tf 					= new TextField();
			desc_tf  					= new TextField();
			bg 		 					= new Sprite();
			
			title_tf.x 					= _text_x;
			title_tf.y 					= 10;
			desc_tf.x  					= _text_x;
			desc_tf.y  					= 50;
			
			title_tf.wordWrap			= true;
			desc_tf.wordWrap			= true;
			
			var textfield_width 		= _menu.custom_width - _menu.tab_area_size - _text_x - _menu.content_indent * 2 - _menu.button_spacing * 2;
			title_tf.width 				= textfield_width;
			desc_tf.width  				= textfield_width;
			
			title_tf.defaultTextFormat 	= ABCMSSiteTextFormats.H2B();
			desc_tf.defaultTextFormat  	= ABCMSSiteTextFormats.T1();
			
			title_tf.antiAliasType 		= "advanced";
			desc_tf.antiAliasType  		= "advanced";
			title_tf.embedFonts 		= true;
			desc_tf.embedFonts  		= true;
		}
		
		private function addListeners():void
		{
			this.addEventListener(I18NEvent.LANGUAGE_CHANGE, update, false, 0, true);
		}
		
		override protected function update():void
		{
			/// change textfield value
			
			title_tf.text = I18N.translate(this.data.title);
			desc_tf.text  = I18N.translate(this.data.description);
		}
		
		/// work functions
		
		override protected function onClick():void
		{
			//trace("ABCMSMainMenuItem ::: onClick()")
			
			if (_menu.status == "centered") 
			{
				_menu.setDocked();
			}
			
			AppLevelsManagement.getSingleton().addClassObjectToLevel("CONTENT_LEVEL", this.data.module_class)
		}
		
		override protected function onHover(e:MouseEvent):void
		{
			//trace("ABCMSMainMenuItem ::: onHover()")
			
			this.blendMode = BlendMode.INVERT;
		}
		
		override protected function onHoverOut(e:MouseEvent):void
		{
			//trace("ABCMSMainMenuItem ::: onHoverOut()")
			this.blendMode = BlendMode.NORMAL;
		}
		
		protected override function build():void
		{
			//trace("ABCMSMainMenuItem ::: build")
			
			addChild(bg);
			addChild(title_tf);
			addChild(desc_tf);
			
			bg.graphics.beginFill(_bg_colour);
			bg.graphics.drawRect(0, 0, _menu.custom_width - _menu.tab_area_size - 2*_menu.button_spacing, custom_height);
			bg.graphics.endFill();
			
			bg.alpha = _bg_alpha;
			
			update();
		}   
	}
}