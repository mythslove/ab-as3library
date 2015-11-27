## Introduction ##

AB Framework is my own general-purpose framework created by myself to suit my own development needs.

Anyone may use it but at this point there is no documentation to help. There is a project template in the "project template" folder to get it up and running quickly. Warning: The project template is not always up to date with the code in "Trunk".


## Description ##

Basically, this framework has a core class which creates several "managers" (like data manager / keyboard manager) to handle different functionalities. Then a handy "core API" class is used to invoke methods from all these managers. A central event system provides, among other uses, communication between the core, the "managers" and the stage instances.

The "manager" responsible for the creation of stage instances holds no references to these instances, making them independent and easily disposable. Stage instances have their own IDs and may belong to groups which also have IDs. Because the central event system can send data with it's dispatched events, it is also used to send instructions to specific objects using their IDs.



### Main Features List: ###

  * a Core API to access all the features and "managers" of the framework.
  * automatic sections system based on a XML file ("xml/sections.xml") and SWFAddress coupled with a "Application Mode" manager.
  * Several application "Levels" (layers), such as background / main / menu / top / alerts, where all stage instances are created via the core API.
  * thanks to the "Levels" feature and the core API, any stage object can be added anytime, to any level, from any object.
  * Settings System based on XML which must be loaded before the application proceeds.
  * Easy access to these XML Settings within the code via the core API - COREApi.setting("setting\_name").
  * Handy logging console accessible in debug mode by pressing the key F8. Can be activated/deactivated at runtime. Logging is done via the core API: COREApi.log("test").
  * Central Event System which centralizes Event registering and dispatching, accessible to all objects via core API.
  * Integrated Vector text-writer system using optionally loaded fonts in a SWC. Also used via core API. Developed by Guojian Miguel Wu.
  * Data Manager which stores any fetched data in "smart data objects" with IDs, easily accessible from anywhere via the core API using their IDs, preventing unwanted repetition of data requests.
  * Integrated Inactivity System - thanks to the Inactivity class by CasaLib.
  * Screensaver System which must be triggered. A compatible screensaver class must be provided when arming.

### Other Features: ###
  * The handy COREUtils class - a collection of static methods to handle common tasks such as tweening of alpha, color, coordinates, size, etc.
  * "Group Buttons" - buttons which work as groups - such as buttons of a group in which only one of them can be highlighted at once.
  * SWC assets library already linked and editable FLA.
  * Simple Keyboard manager, ready to assign keyboard actions to functions.
  * Sound Manager - In alpha state


### Requirements: ###

  * Main application class must be called "Main" and must be in the project root.
  * The sections declared in the "xml/sections.xml" (if any) must be imported and declared as variables in the class ab.core.AppClasses (because of the automatic integration with the swfaddress / sections system).