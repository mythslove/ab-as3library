﻿/*** Copyright 2009 __noponies__**/package com.noponies.flashpress.vo {	/**	 *	WpUserVO Value Object.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Dale Sattler	 *	@since  26.02.2009	 */   [RemoteClass(alias="flashpress.vo.WpUserVO")]    [Bindable]    public class WpUserVO {    // CLASS VARIABLES 	public var user_id:int;	public var user_login:String;	public var user_pass:String;	public var user_nicename:String;	public var user_email:String;	public var user_url:String;	public var user_registered:String;	public var user_activation_key:String;	public var user_status:int;	public var user_display_name:String;	public var description:String;	public var nickname:String;    // CONSTRUCTOR     function WpUserVO():void {}  }}