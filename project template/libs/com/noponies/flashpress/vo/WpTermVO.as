﻿/*** Copyright 2009 __noponies__**/package com.noponies.flashpress.vo {	/**	 *	WpTermVO Value Object.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Dale Sattler	 *	@since  26.02.2009	 */   [RemoteClass(alias="flashpress.vo.WpTermVO")]    [Bindable]    public class WpTermVO {    // CLASS VARIABLES   public var name:String;  public var slug:String;  public var count:int;  public var term_group:int;  public var term_id:int;  public var taxonomy:String;  public var term_taxonomy_id:int;  public var description:String;  public var parent:int;  // CONSTRUCTOR   function WpTermVO():void {}  }}