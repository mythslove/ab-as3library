﻿package com.noponies.flashpress.vo {	/**	 *	WpCategoryVO Value Object.	 *	 *	@langversion ActionScript 3.0	 *	@playerversion Flash 9.0	 *	 *	@author Dale Sattler	 *	@since  26.02.2009	 */ 	 [Bindable]  [RemoteClass(alias="flashpress.vo.WpCategoryVO")]   public class WpCategoryVO {    // CLASS VARIABLES   public var category_count:int;  public var category_description:String;  public var category_nicename:String;  public var category_parent:int;  public var cat_ID:int;  public var cat_name:String;  public var count:int;  public var description:String;  public var name:String;  public var parent:int;    public var slug:String;  public var taxonomy:String;  public var term_id:int;  public var term_group:int;  public var term_taxonomy_id:int;    // CONSTRUCTOR     public function WpCategoryVO():void {;}  }}