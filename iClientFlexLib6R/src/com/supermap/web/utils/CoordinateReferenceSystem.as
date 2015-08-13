package com.supermap.web.utils
{
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/**
	 * ${core_CoordinateReferenceSystem_Title}.
	 * <p>${core_CoordinateReferenceSystem_Description}</p> 
	 * 
	 * 
	 */	
	public class CoordinateReferenceSystem
	{
		private var _wkid:int = 0;
		private var _unit:String = Unit.DEGREE; 
		private var _datumAxis:Number = 6378137;//WGS_84 椭球半径
		
		/**
		 * ${core_CoordinateReferenceSystem_constructor_D} 
		 * @param wkid ${core_CoordinateReferenceSystem_constructor_param_wkid}
		 * @param unit ${core_CoordinateReferenceSystem_constructor_param_unit}
		 * @param datumAxis ${core_CoordinateReferenceSystem_constructor_param_datumAxis}
		 * @see Unit
		 * 
		 */		
		public function CoordinateReferenceSystem(wkid:int = 0, unit:String = "degree", datumAxis:Number = 6378137)
		{
			this.wkid = wkid;		
			this.unit = unit;
			this.datumAxis = datumAxis;
		}

		/**
		 * ${core_CoordinateReferenceSystem_attribute_datumAxis_D} 
		 * @return 
		 * 
		 */		
		public function get datumAxis():Number
		{
			return _datumAxis;
		}

		public function set datumAxis(value:Number):void
		{
			_datumAxis = value;
		}

		/**
		 * ${core_CoordinateReferenceSystem_attribute_unit_D} 
		 * 
		 */		
		public function get unit():String
		{
			return _unit;
		}
		public function set unit(value:String):void
		{
			_unit = value;
		}

		/**
		 * ${core_CoordinateReferenceSystem_attribute_wkid_D} 
		 * 
		 */		
		public function get wkid():int
		{
			return _wkid;
		}
		public function set wkid(value:int):void
		{
			_wkid = value;
		}
		
		/**
		 * ${core_CoordinateReferenceSystem_method_clone_D}.
		 * ${core_CoordinateReferenceSystem_method_clone_remarks_D}
		 * 
		 */		
		public function clone():CoordinateReferenceSystem
		{
			var cloneCRS:CoordinateReferenceSystem = new CoordinateReferenceSystem();
			cloneCRS.wkid = this.wkid;
			cloneCRS.unit = this.unit;
			return cloneCRS;
		}
		
		/**
		 * ${core_CoordinateReferenceSystem_method_equals_D} 
		 * @param other ${core_CoordinateReferenceSystem_method_equals_param_other}
		 * @return ${core_CoordinateReferenceSystem_method_equals_retrun}
		 * 
		 */		
		public function equals(other:CoordinateReferenceSystem):Boolean
		{
			return CoordinateReferenceSystem.equals(this, other, false);
		}//忽略单位
		
		/**
		 * ${core_CoordinateReferenceSystem_static_method_equals_D} 
		 * @param ignoreNull ${core_CoordinateReferenceSystem_static_method_equals_param_ignoreNull}
		 * @return ${core_CoordinateReferenceSystem_static_method_equals_retrun}
		 * 
		 */		
		public static function equals(crs1:CoordinateReferenceSystem,crs2:CoordinateReferenceSystem,ignoreNull:Boolean):Boolean
		{
			if (crs1 == null || crs2 == null)
			{
				return ignoreNull;
			}
			if (isWebMercatorWKID(crs1.wkid) && isWebMercatorWKID(crs2.wkid))
			{
				return true;
			}
			return (crs1.wkid == crs2.wkid);
		}
		
		
		private static function isWebMercatorWKID(wkid:int):Boolean
		{
			return (wkid == 3857) || (wkid == 900913) || (wkid == 102113) || (wkid == 102100);
		}
		
		sm_internal static function toCoordinateReferenceSystem(object:Object):CoordinateReferenceSystem
		{
			var CRS:CoordinateReferenceSystem;
			if (object)
			{
				CRS = new CoordinateReferenceSystem(object.pJCoordSysType);
				CRS.unit = object.coordUnits;
			}
			return CRS;
		}

		/**
		 * ${core_CoordinateReferenceSystem_method_toString_D} 
		 * @return ${core_CoordinateReferenceSystem_method_toString_return}
		 * 
		 */		
		public function toString():String
		{
			return  "( wkid:" + this._wkid + ", unit:" + this._unit + ")";
		}
	}
}