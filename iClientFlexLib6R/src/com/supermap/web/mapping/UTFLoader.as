package com.supermap.web.mapping
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.ByteArray;
	/**
	 * @private 
	 * @author lwl
	 * 
	 */	
	internal class UTFLoader extends URLLoader
	{
		
		private var _id:String;
		
		public function UTFLoader()
		{
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set id(value:String):void
		{
			_id = value;
		}
	}
}