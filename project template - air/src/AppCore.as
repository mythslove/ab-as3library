package
{
	import com.ab.core.CORE;
	import com.ab.core.COREApi;
	import com.adobe.air.notification.AbstractNotification;
	import com.adobe.air.notification.Notification;
	import com.adobe.air.notification.Purr;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemTrayIcon;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowDisplayState;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowType;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.system.Capabilities;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	public class AppCore extends CORE
	{
		private var dockImage:BitmapData;
		private var mypurr:Purr = new Purr(1);
		private var testnot:Notification;
		private var total_icons_loaded:int=0;
		private var icons_bitmapdatas:Array = new Array();
		private var win:NativeWindow;
		
		public function AppCore()
		{
			/// define main application class
			APPLICATION_CLASS  = TemplateAppClass;
			
			//SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = "EDIGMA File Uploader";
			
			//var initoptions:NativeWindowInitOptions = new NativeWindowInitOptions();
			//initoptions.type = NativeWindowType.UTILITY;
			
			//win	= new NativeWindow(initoptions);
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoaded, false, 0, true);
			loader.load(new URLRequest("assets/icons/16x16.png"));
			
			if (!Capabilities.isDebugger) 
			{
				NativeApplication.nativeApplication.startAtLogin = AppVars.START_AT_LOGIN;
			}
		}
		
		private function iconLoaded(e:Event):void 
		{
			total_icons_loaded++;
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, iconLoaded, false, 0, true);
			
			icons_bitmapdatas.push(e.target.content.bitmapData);
			
			switch (total_icons_loaded) 
			{
				case 1:
					
					//Retrieve the image being used as the systray icon
					dockImage = e.target.content.bitmapData;
					
					//For windows systems we can set the systray props
					//(there's also an implementation for mac's, it's similar and you can find it on the net... ;) )
					
					if (NativeApplication.supportsSystemTrayIcon)
					{
						setSystemTrayProperties();
						
						//Set some systray menu options, so that the user can right-click and access functionality
						//without needing to open the application
						SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = createSystrayRootMenu();
					}
					
					loader4.load(new URLRequest("assets/icons/32x32.png"));
				break;
				case 2:
					loader4.load(new URLRequest("assets/icons/64x64.png"));
				break;
				case 3:
					loader4.load(new URLRequest("assets/icons/128x128.png"));
				break;
				case 4:
					trace("44444");
					NativeApplication.nativeApplication.icon.bitmaps = icons_bitmapdatas;
				break;
			}
			
		}
		
		/**
		* Check if the user wants to close the application or dock it
		*
		* @Author: S.Radovanovic
		*/
		private function closingApplication(evt:Event):void 
		{
			//Don't close, so prevent the event from happening
			dock();
			//evt.preventDefault();
			
			//Check what the user really want's to do
			//Alert.buttonWidth = 110;
			
			//Alert.yesLabel = "Close";
			//Alert.noLabel = "Minimize";
			//Alert.show("Close or minimize?", "Close?", 3, this, alertCloseHandler);
		}
		
		/**
		* Check to see if the application may be docked and set basic properties
		*
		* @Author: S.Radovanovic
		*/
		
		public function prepareForSystray(event:Event):void 
		{
			//Retrieve the image being used as the systray icon
			
			dockImage = event.target.content.bitmapData;
			
			//For windows systems we can set the systray props
			//(there's also an implementation for mac's, it's similar and you can find it on the net... ;) )
			
			if (NativeApplication.supportsSystemTrayIcon)
			{
				setSystemTrayProperties();
				
				//Set some systray menu options, so that the user can right-click and access functionality
				//without needing to open the application
				
				SystemTrayIcon(NativeApplication.nativeApplication.icon).menu = createSystrayRootMenu();
			}
		}
		
		/**
		* Create a menu that can be accessed from the systray
		*
		* @Author: S.Radovanovic
		*/
		private function createSystrayRootMenu():NativeMenu
		{
			//Add the menuitems with the corresponding actions
			
			var menu:NativeMenu = new NativeMenu();
			var openNativeMenuItem:NativeMenuItem = new NativeMenuItem("Open");
			var exitNativeMenuItem:NativeMenuItem = new NativeMenuItem("Exit");
			//var testNativeMenuItem:NativeMenuItem = new NativeMenuItem("Test");
			
			//What should happen when the user clicks on something...
			
			
			//testNativeMenuItem.addEventListener(Event.SELECT, testHandler);
			openNativeMenuItem.addEventListener(Event.SELECT, undock);
			exitNativeMenuItem.addEventListener(Event.SELECT, closeApp);
			
			//Add the menuitems to the menu
			
			//menu.addItem(testNativeMenuItem);
			menu.addItem(openNativeMenuItem);
			menu.addItem(new NativeMenuItem("",true));
			//separator
			
			menu.addItem(exitNativeMenuItem);
			
			return menu;
		}
		
		private function testHandler(e:Event):void 
		{
			//trace ("AppCore ::: stage.nativeWindow.displayState = " + stage.nativeWindow.displayState ); 
		}
		
		/**
		* To be able to dock and undock we need to set some eventlisteners
		*
		* @Author: S.Radovanovic
		*/
		private function setSystemTrayProperties():void
		{
			//Text to show when hovering of the docked application icon
			
			SystemTrayIcon(NativeApplication.nativeApplication.icon).tooltip = AppVars.APP_NAME;
			
			//We want to be able to open the application after it has been docked
			
			SystemTrayIcon(NativeApplication.nativeApplication.icon).addEventListener(MouseEvent.CLICK, undock);
			
			//Listen to the display state changing of the window, so that we can catch the minimize
			
			stage.nativeWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGING, nwMinimized); //Catch the minimize event
		}
		
		/**
		* Do the appropriate actions after the windows display state has changed.
		* E.g. dock when the user clicks on minize
		*
		* @Author: S.Radovanovic
		*/
		private function nwMinimized(displayStateEvent:NativeWindowDisplayStateEvent):void 
		{
			//Do we have an minimize action?
			//The afterDisplayState hasn't happened yet, but only describes the state the window will go to,
			//so we can prevent it!
			
			if (displayStateEvent.afterDisplayState == NativeWindowDisplayState.MINIMIZED) 
			{
				//Prevent the windowedapplication minimize action from happening and implement our own minimize
				//The reason the windowedapplication minimize action is caught, is that if active we're not able to
				//undock the application back neatly. The application doesn't become visible directly, but only after clicking
				//on the taskbars application link. (Not sure yet what happens exactly with standard minimize)
				
				displayStateEvent.preventDefault();
				
				//Dock (our own minimize)
				
				dock();
				
				COREApi.options.minimized = true;
			}
			else
			{
				COREApi.options.minimized = false;
			}
		}
		
		/**
		* Do our own 'minimize' by docking the application to the systray (showing the application icon in the systray)
		*
		* @Author: S.Radovanovic
		*/
		public function dock():void 
		{
			//Hide the applcation
			
			stage.nativeWindow.visible = false;
			
			//Setting the bitmaps array will show the application icon in the systray
			
			NativeApplication.nativeApplication.icon.bitmaps = [dockImage];
		}
		
		/**
		* Show the application again and remove the application icon from the systray
		*
		* @Author: S.Radovanovic
		*/
		public function undock(evt:Event):void 
		{
			//After setting the window to visible, make sure that the application is ordered to the front,
			//else we'll still need to click on the application on the taskbar to make it visible
			
			stage.nativeWindow.visible = true;
			stage.nativeWindow.orderToFront();
			
			//Clearing the bitmaps array also clears the applcation icon from the systray
			
			NativeApplication.nativeApplication.icon.bitmaps = [];
		}
		
		/**
		* Close the application
		*
		* @Author: S.Radovanovic
		*/
		private function closeApp(evt:Event):void 
		{
			//stage.nativeWindow.close();
			NativeApplication.nativeApplication.exit(0);
		}
		
		//public function set openAtStartup(value:Boolean):void 
		//{
			//if (!Capabilities.isDebugger) 
			//{
				//NativeApplication.nativeApplication.startAtLogin = value;
			//}
		//}
	}
}