package com.supermap.web.service.supportClasses
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	internal class PrjParameter
	{
		private var _secondPointLongitude:Number;
		private var _firstPointLongitude:Number;
		private var _falseNorthing:Number;
		private var _secondStandardParallel:Number;
		private var _firstStandardParallel:Number;
		private var _centralMeridian:Number;
		private var _centralParallel:Number;
		private var _scaleFactor:Number;
		private var _azimuth:Number;
		private var _falseEasting:Number;
		
		public function PrjParameter()
		{
		}

		public function get falseEasting():Number
		{
			return _falseEasting;
		}

		public function set falseEasting(value:Number):void
		{
			_falseEasting = value;
		}

		public function get azimuth():Number
		{
			return _azimuth;
		}

		public function set azimuth(value:Number):void
		{
			_azimuth = value;
		}

		public function get scaleFactor():Number
		{
			return _scaleFactor;
		}

		public function set scaleFactor(value:Number):void
		{
			_scaleFactor = value;
		}

		public function get centralParallel():Number
		{
			return _centralParallel;
		}

		public function set centralParallel(value:Number):void
		{
			_centralParallel = value;
		}

		public function get centralMeridian():Number
		{
			return _centralMeridian;
		}

		public function set centralMeridian(value:Number):void
		{
			_centralMeridian = value;
		}

		public function get firstStandardParallel():Number
		{
			return _firstStandardParallel;
		}

		public function set firstStandardParallel(value:Number):void
		{
			_firstStandardParallel = value;
		}

		public function get secondStandardParallel():Number
		{
			return _secondStandardParallel;
		}

		public function set secondStandardParallel(value:Number):void
		{
			_secondStandardParallel = value;
		}

		public function get falseNorthing():Number
		{
			return _falseNorthing;
		}

		public function set falseNorthing(value:Number):void
		{
			_falseNorthing = value;
		}

		public function get firstPointLongitude():Number
		{
			return _firstPointLongitude;
		}

		public function set firstPointLongitude(value:Number):void
		{
			_firstPointLongitude = value;
		}

		public function get secondPointLongitude():Number
		{
			return _secondPointLongitude;
		}

		public function set secondPointLongitude(value:Number):void
		{
			_secondPointLongitude = value;
		}
		
		sm_internal static function fromJson(json:Object ) : PrjParameter
		{
			if (json == null)
			{
				return null;
			}		
			var prjParameter:PrjParameter = new PrjParameter();
			prjParameter.azimuth = json.azimuth;
			prjParameter.centralMeridian = json.centralMeridian;
			prjParameter.centralParallel = json.centralParallel;
			prjParameter.falseEasting = json.falseEasting;
			prjParameter.falseNorthing = json.falseNorthing;
			prjParameter.firstStandardParallel = json.firstStandardParallel;
			prjParameter.firstPointLongitude = json.firstPointLongitude;
			prjParameter.scaleFactor = json.scaleFactor;
			prjParameter.secondPointLongitude = json.secondPointLongitude;
			prjParameter.secondStandardParallel = json.secondStandardParallel;
			return prjParameter;
		}

	}
}