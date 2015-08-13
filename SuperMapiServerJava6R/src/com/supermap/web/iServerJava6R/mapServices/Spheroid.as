package com.supermap.web.iServerJava6R.mapServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	internal class Spheroid
	{
		private var _axis:Number;
		private var _flatten:Number;
		private var _name:String;
		private var _type:String;
		
		public function Spheroid()
		{
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

		public function get flatten():Number
		{
			return _flatten;
		}

		public function set flatten(value:Number):void
		{
			_flatten = value;
		}

		public function get axis():Number
		{
			return _axis;
		}

		public function set axis(value:Number):void
		{
			_axis = value;
		}
		
		sm_internal static function fromJson(json:Object ) : Spheroid
		{
			if (json == null)
			{
				return null;
			}
			var spheroid:Spheroid = new Spheroid();
			spheroid.name = json.name;
			spheroid.type = json.type;
			spheroid.axis = json.axis;
			spheroid.flatten = json.flatten;
			return spheroid;
			
		}

	}
}