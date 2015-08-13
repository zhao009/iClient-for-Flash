package com.supermap.web.service.supportClasses
{
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	internal class Datum
	{
		public function Datum()
		{
		}
		
		private var _name:String;
		private var _type:String;
		private var _spheroid:Spheroid;
		
		public function get spheroid():Spheroid
		{
			return _spheroid;
		}

		public function set spheroid(value:Spheroid):void
		{
			_spheroid = value;
		}

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

		sm_internal static function fromJson(json:Object ) : Datum
		{
			if (json == null)
			{
				return null;
			}
			var datum:Datum = new Datum();
			datum.name = json.name;
			datum.type = json.type;
			datum.spheroid = Spheroid.fromJson(json.spheroid);
			return datum;
			
		}
	}
}