package com.ab.core
{
	/**
	* MAIN APPLICATION CLASSES
	* 
	* This class is used to add the classes in "xml/sections.xml" to the framework system
	* 
	* these classes must be imported and declared as variables.
	* 
	* @additionally if you wish to use another name other than "Main" for you application's root class:
	* the public static var "main_app_class" must be the name of the root class of your application in the form of a String.
	* it must be imported and declared as a variable like the classes defined in "xml/sections.xml"
	* 
	* @finally if you know any awesome way of bypassing this requirement drop me a message
	*/
	
	/// classes defined in "xml/sections.xml"
	//example:
	//import sections.about.About;
	
	// the value "Main" is correct as long as your main class is named "Main"
	import Main;
	import sections.about.About;
	import sections.contact.Contact;
	import sections.skills.Skills;
	import sections.portfolio.portfoliolist.PortfolioList;
	import sections.portfolio.portfolioitem.PortfolioItem;
	
	public class AppClasses 
	{
		// the value "Main" is correct as long as your main class is named "Main", no extra linking is necessary
		public static var main_app_class:String="Main";
		
		private var main:Main;
		private var about:About;
		private var contact:Contact;
		private var skills:Skills;
		private var portfoliolist:PortfolioList;
		private var portfolioitem:PortfolioItem;
	}

}