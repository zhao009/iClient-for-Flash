package com.supermap.web.service.supportClasses
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	public class PrjCoordSys
	{
		public function PrjCoordSys()
		{
		}
		
		private var _coordUnit:String;
		private var _name:String;
		private var _projection:Projection;
		private var _coordSystem:CoordSys;
		private var _distanceUnit:String;
		private var _projectionParam:PrjParameter ;
		private var _type:String;
		private var _epsgCode:int;

		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get projectionParam():PrjParameter
		{
			return _projectionParam;
		}

		public function set projectionParam(value:PrjParameter):void
		{
			_projectionParam = value;
		}

		public function get distanceUnit():String
		{
			return _distanceUnit;
		}

		public function set distanceUnit(value:String):void
		{
			_distanceUnit = value;
		}

		public function get coordSystem():CoordSys
		{
			return _coordSystem;
		}

		public function set coordSystem(value:CoordSys):void
		{
			_coordSystem = value;
		}

		public function get projection():Projection
		{
			return _projection;
		}

		public function set projection(value:Projection):void
		{
			_projection = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get coordUnit():String
		{
			return _coordUnit;
		}

		public function set coordUnit(value:String):void
		{
			_coordUnit = value;
		}
		
		public function get epsgCode():int
		{
			return _epsgCode;
		}
		
		public function set epsgCode(value:int):void
		{
			_epsgCode = value;
		}
		

		sm_internal static function fromJson(json:Object ) : PrjCoordSys
		{
			if (json == null)
			{
				return null;
			}
			var prjCoordSys:PrjCoordSys = new PrjCoordSys();
			prjCoordSys.name = json.name;
			prjCoordSys.type = json.type;
			prjCoordSys.coordUnit = json.coordUnit;
			prjCoordSys.distanceUnit = json.distanceUnit;
			prjCoordSys.epsgCode = json.epsgCode;
			prjCoordSys.projectionParam = PrjParameter.fromJson(json.projectionParam);
			prjCoordSys.coordSystem = CoordSys.fromJson(json.coordSystem);
			prjCoordSys.projection = Projection.fromJson(json.projection);
			return prjCoordSys;
			
		}
	}
}