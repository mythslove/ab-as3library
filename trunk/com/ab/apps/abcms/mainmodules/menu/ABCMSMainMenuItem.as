package com.ab.apps.abcms.mainmodules.menu 
{
	/**
	* @author ABº
	*/
	
	import com.ab.apps.appgenerics.lang.I18N;
	import com.ab.apps.appgenerics.lang.I18NEvent;
	import com.ab.menu.SideTabMenuItem;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ABCMSMainMenuItem extends SideTabMenuItem
	{
		private var title_tf:TextField;
		private var desc_tf:TextField;
		
		public var data = {
			title: { en: "Untitled", pt: "Sem titulo" },
			description: { en: "Untitled", pt: "Sem titulo" }
		};
		
		public function ABCMSMainMenuItem(data = null) 
		{
			if (data) this.data = data;
			
			initVars();
			addListeners()
		}
		
		private function initVars():void
		{
			title_tf = new TextField();
			desc_tf  = new TextField();
		}
		
		private function addListeners():void
		{
			this.addEventListener(I18NEvent.LANGUAGE_CHANGE, update, false, 0, true);
		}
		
		override protected function update():void
		{
			/// change textfield value
			//titleLabel.value = I18N.translate(this.data.title);
			
			trace("123 :" + this.data.title.pt);
			trace("1234 :" + this.data.title);
			
			title_tf.text = I18N.translate(this.data.title);
			desc_tf.text  = I18N.translate(this.data.description);
		}
		
		/// work functions
		
		override protected function onClick(e:MouseEvent):void
		{
			trace("ABCMSMainMenuItem ::: onClick()")
		}
		
		protected override function build():void
		{
			trace("ABCMSMainMenuItem ::: build")
			
			addChild(title_tf);
			addChild(desc_tf);
			
			title_tf.x = 10;
			title_tf.y = 10;
			desc_tf.x  = 10;
			desc_tf.y  = 30;
			
			trace("sssssss")
			trace(desc_tf.text)
			
			update();
			
			//title_tf
			//desc_tf.text
		}   
	}
}