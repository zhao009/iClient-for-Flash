package com.supermap.web.service.supportClasses
{
	import com.supermap.web.utils.Unit;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */	
	internal class CoordSys
	{
		private var _unit:String;
		private var _spatialRefType:String;
		private var _primeMeridian:PrimeMeridian;
		private var _name:String;
		private var _type:String;
		private var _datum:Datum;
			
		public function CoordSys(){}
		
		public function get datum():Datum
		{
			return _datum;
		}

		public function set datum(value:Datum):void
		{
			_datum = value;
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

		public function get primeMeridian():PrimeMeridian
		{
			return _primeMeridian;
		}

		public function set primeMeridian(value:PrimeMeridian):void
		{
			_primeMeridian = value;
		}

		public function get spatialRefType():String
		{
			return _spatialRefType;
		}

		public function set spatialRefType(value:String):void
		{
			_spatialRefType = value;
		}

		public function get unit():String
		{
			return _unit;
		}

		public function set unit(value:String):void
		{
			_unit = value;
		}
	
		sm_internal static function fromJson(json:Object) : CoordSys
		{
			if (json == null)
			{
				return null;
			}
			var coordSys:CoordSys = new CoordSys();
			coordSys.unit = json.unit;
			coordSys.spatialRefType = json.spatialRefType;
			coordSys.primeMeridian = PrimeMeridian.fromJson(json.primeMeridian);
			coordSys.name = json.name;
			coordSys.datum = Datum.fromJson(json.datum);
			coordSys.type = json.type;
			return coordSys;
		}
	}
}