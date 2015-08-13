package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ClipParameter_Title} 
	 * 
	 */	
	public class ClipParameter
	{
		
		//定义参数
		private var _clipDatasetName:String;
		private var _clipDatasourceName:String;
		private var _clipRegion:GeoRegion;
		private var _isClipInRegion:Boolean = false;
		private var _isExactClip:Boolean =false;
		
		/**
		 * ${iServerJava6R_ClipParameter_constructor_D} 
		 * 
		 */	
		public function ClipParameter()
		{
		}
		
		/**
		 * ${iServerJava6R_ClipParameter_attribute_clipDatasetName_D} 
		 * @return 
		 * 
		 */
		public function get clipDatasetName():String
		{
			return _clipDatasetName;
		}
		
		public function set clipDatasetName(value:String):void
		{
			_clipDatasetName = value;
		}
		
		/**
		 * ${iServerJava6R_ClipParameter_attribute_clipDatasourceName_D} 
		 * @return 
		 * 
		 */
		public function get clipDatasourceName():String
		{
			return _clipDatasourceName;
		}
		
		public function set clipDatasourceName(value:String):void
		{
			_clipDatasourceName = value;
		}
		
		/**
		 * ${iServerJava6R_ClipParameter_attribute_clipRegion_D} 
		 * @return 
		 * 
		 */
		public function get clipRegion():GeoRegion
		{
			return _clipRegion;
		}
		
		public function set clipRegion(value:GeoRegion):void
		{
			_clipRegion = value;
		}

		/**
		 * ${iServerJava6R_ClipParameter_attribute_isClipInRegion_D} 
		 * @return 
		 * 
		 */
		public function get isClipInRegion():Boolean
		{
			return _isClipInRegion;
		}
		
		public function set isClipInRegion(value:Boolean):void
		{
			_isClipInRegion = value;
		}
		
		/**
		 * ${iServerJava6R_ClipParameter_attribute_isExactClip_D} 
		 * @return 
		 * 
		 */
		public function get isExactClip():Boolean
		{
			return _isExactClip;
		}

		public function set isExactClip(value:Boolean):void
		{
			_isExactClip = value;
		}
		
		/**
		 * 将 ClipParameter 对象转化为json字符串。
		 */
		sm_internal function toJSON():String
		{
			if(this.isClipInRegion == false)
				return null;
			var strClipParameter:String = "";
			
			strClipParameter +="'isClipInRegion':" + this.isClipInRegion.toString();
			
			if(this.clipDatasetName != null)
				strClipParameter += "," + "'clipDatasetName':" + this.clipDatasetName;
			
			if(this.clipDatasourceName != null)
				strClipParameter += "," + "'clipDatasourceName':" + this.clipDatasourceName;
			
			if(this.isExactClip)
				strClipParameter += "," + "'isExactClip':" + this.isExactClip.toString();
			
			if(this.clipRegion != null)
			{
				var serverGeometry:ServerGeometry = ServerGeometry.fromGeometry(this.clipRegion);
				if (serverGeometry) {
					var pointsCount:int = serverGeometry.parts[0];
					var point2ds:Array = serverGeometry.points;
					var point2dStr:String = "";
					for each (var item:Point2D in point2ds) 
					{
						point2dStr += "{'x':"+item.x+",'y':"+item.y+"},";
					}
					strClipParameter += "," + "'clipRegion':" +  "{'point2Ds':[";
					strClipParameter += point2dStr;
					strClipParameter += "]}";
				}
			} 
			return "{" +  strClipParameter + "}";
		}
		
	}
}