package com.ab.core
{
	/**
	* MAIN APPLICATION CLASSES (required to use AB Framework)
	* 
	* In this class one must import the some classes and declare them as variables.
	* 
	* The classes which must be imported and declared as variables are the following:
	* 
	* - the root class of your application (eg. "Main")
	* - the classes you may have defined in the XML file "xml/sections.xml"
	* 
	* @additionally the public static var "main_app_class" must be the name of the root class of your application in the form of a String.
	*/
	
	import ABCOMV3;
	import sections.about.About;
	import sections.contact.Contact;
	import sections.skills.Skills;
	import sections.portfolio.portfoliolist.PortfolioList;
	import sections.portfolio.portfolioitem.PortfolioItem;
	
	public class AppClasses 
	{
		public static var main_app_class:String="ABCOMV3";
		
		private var abcomv3:ABCOMV3;
		private var about:About;
		private var contact:Contact;
		private var skills:Skills;
		private var portfoliolist:PortfolioList;
		private var portfolioitem:PortfolioItem;
	}

}