package com.ab.apps.abcms.mainmodules.configurators 
{
	/**
	* @author ABº
	*/
	
	/// MAIN CLASSES
	
	import com.ab.apps.abcms.mainmodules.menu.ContentMenu;
	import com.ab.apps.abcms.mainmodules.browsers.SectionsNavigator;
	import com.ab.apps.abcms.mainmodules.browsers.ItemsBrowser;
	import com.ab.apps.abcms.mainmodules.browsers.MediaBrowser;
	import com.ab.apps.abcms.mainmodules.editors.ItemEditor;
	import com.ab.apps.abcms.mainmodules.editors.MediaEditor;
	import com.ab.apps.abcms.mainmodules.configurators.ABCMSBasicSiteDefinitions;
	
	public class ABCMSSiteVars
	{
		/// MAIN MENU
		
		public static const MAIN_MENU = [
			{
				title: {
					pt: "DEFINIÇÕES BÁSICAS",
					en: "BASIC SITE DEFINITIONS"
				},
				description: {
					pt: "Editar definições tais como título do site, background, musica, etc.",
					en: "Edit definitions such as site title, background, music, etc."
				},
				
				module_class: ABCMSBasicSiteDefinitions,
				
				cat: 1
			},
			{
				title: {
					pt: "EDITOR DE CONTEÚDOS",
					en: "EDIT CONTENTS"
				},
				description: {
					pt: "Editar estrutura do site, secções, items e medias.",
					en: "Edit the content of sections, items, and medias."
				},
				
				module_class: ContentMenu,
				
				cat: 2
			},
			{
				title: {
					pt: "OPÇÕES DO CMS",
					en: "CMS OPTIONS"
				},
				description: {
					pt: "Gerir opções do CMS.",
					en: "Choose options of the editor, such as color scheme and language"
				}, 
				
				module_class: ABCMSOptions,
				
				cat: 3
			},
		];
		
	}
	
}