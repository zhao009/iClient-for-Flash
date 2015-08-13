package com.supermap.topbar.containers
{
	
	import flash.events.MouseEvent;
	
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	import spark.components.Image;
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import spark.components.TextInput;
	import spark.components.supportClasses.StyleableTextField;

	public class TopNavigator extends SkinnableContainer
	{
		[SkinPart(required="false")]
		public var query:TopNavButton;
		[SkinPart(required="false")]
		public var painter:TopNavButton;
		[SkinPart(required="false")]
		public var textInput:TextInput;
		
		private static const MAIN_PAGE:String = "mainPage";
		
		private var _topNaviState:String = MAIN_PAGE;
		
		public var currentPage:String;
		
		public function TopNavigator()
		{
		}
		
		public function get topNaviState():String
		{
			return _topNaviState;
		}

		public function set topNaviState(value:String):void
		{
			_topNaviState = value;
		}

		override protected function getCurrentSkinState():String
		{
			return this._topNaviState;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
		}
	}
}