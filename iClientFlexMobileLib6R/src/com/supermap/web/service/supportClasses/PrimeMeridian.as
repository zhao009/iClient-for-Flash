package com.supermap.web.service.supportClasses
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	internal class PrimeMeridian
	{
		public function PrimeMeridian()
		{
		}
		private var _name:String;
		private var _type:String;
		private var _longitudeValue:Number;
		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get longitudeValue():Number
		{
			return _longitudeValue;
		}

		public function set longitudeValue(value:Number):void
		{
			_longitudeValue = value;
		}

		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		sm_internal static function fromJson(json:Object ) : PrimeMeridian
		{
			if (json == null)
			{
				return null;
			}
			var primeMeridian:PrimeMeridian = new PrimeMeridian();
			primeMeridian.name = json.name;
			primeMeridian.type = json.type;
			primeMeridian.longitudeValue = json.longitudeValue;
			return primeMeridian;
			
		}
	}
}