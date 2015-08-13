package com.supermap.web.mapping
{
	internal class OGCParams
	{
		private var _service:String;
		private var _version:String;
		private var _request:String;
		private var _crs:String;
		private var _bbox:String;
			
		public function OGCParams(service:String, version:String, request:String) 
		{
			this._service = service;
			this._version = version;
			this._request = request;

		}
		
		public function get bbox():String
		{
			return _bbox;
		}

		public function set bbox(value:String):void
		{
			_bbox = value;
		}
	
		//Getters and setters
		public function get service():String 
		{
			return _service;
		}
		
		public function set service(service:String):void 
		{
			_service = service;
		}
		
		public function get version():String 
		{
			return _version;
		}
		
		public function set version(version:String):void 
		{
			_version = version;
		}
		
		public function get request():String 
		{
			return _request;
		}
		
		public function set request(request:String):void 
		{
			_request = request;
		}
		
		public function get crs():String 
		{
			return _crs;
		}
		
		public function set crs(crs:String):void 
		{
			_crs = crs;
		}
		
		public function toGETString():String {
			var str:String = "";
			
			if (this._service != null)
				str += "SERVICE=" + this._service + "&";
			
			if (this._version != null)
				str += "VERSION=" + this._version + "&";
			
			if (this._request != null)
				str += "REQUEST=" + this._request + "&";
			if (this._crs != null)
			{
				switch(this._version)
				{
					case "1.1.1":
						str += "SRS=" + this._crs + "&";
						break;
					case "1.3.0":				
						str += "CRS=" + this._crs + "&";
						break;
					default:
						str += "SRS=" + this._crs + "&";
						break;
				}
			}
			
			if (this.bbox != null)
				str += "BBOX=" + this.bbox + "&";
			
			return str;
		}
	}
}