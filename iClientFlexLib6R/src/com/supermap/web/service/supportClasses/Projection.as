package com.supermap.web.service.supportClasses
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	internal class Projection
	{
		public function Projection()
		{
		}
		
		private var _name:String;
		private var _type:String;
		
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		sm_internal static function fromJson(json:Object ) : Projection
		{
			if (json == null)
			{
				return null;
			}
			var projection:Projection = new Projection();
			projection.name = json.name;
			projection.type = json.type;
			return projection;
			
		}
	}
}