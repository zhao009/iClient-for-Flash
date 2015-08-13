package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.geom.Rectangle;

	use namespace sm_internal;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	internal class NAResultMapParameter
	{ 
		public var backgroundTransparent:Boolean;
		public var bounds:Rectangle2D;
		public var center:Point2D;
		public var format:OutputFormat;
		public var scale:Number = 0;
		public var style:ServerStyle;
		public var useDefaultParameter:Boolean;
		public var viewer:Rectangle;//接口文档中为Rectangle类型
		
		public function NAResultMapParameter()
		{     
		}
		
		sm_internal static function toJson(param:NAResultMapParameter):String//用于组装json的静态方法
		{
			if (param != null)
			{
				var json:String = "{"; 
				var list:Array = [];
				
				list.push(String("\"backgroundTransparent\":" + param.backgroundTransparent.toString().toLowerCase()));
				list.push(String("\"useDefaultParameter\":" + param.useDefaultParameter));
				
				if (param.bounds) 
					list.push(String("\"bounds\":" +  JsonUtil.fromRectangle2D(param.bounds))); 
				if (param.center)
					list.push(String("\"center\":" + JsonUtil.fromPoint2D(param.center)));
				list.push(String("\"format\":\"" +  param.format + "\""));
				if (param.scale != 0)
					list.push(String("\"scale\":\"" +  param.scale + "\""));
				if (param.style)
					list.push(String("\"style\":\"" + param.style.toJSON() + "\""));
				if (param.viewer)
					list.push(String("\"viewer\":" + String("{{\"leftTop\":{{\"x\":0,\"y\":0}},\"rightBottom\":{{\"x\":" + param.viewer.width + ",\"y\":" + param.viewer.height + "}}}}")));
				
				json += list.toString();
				json += "}";
				return json;
			}
			return null;
		}
		
		public static function fromJson(json:Object):NAResultMapParameter
		{
			if (json == null)
				return null;
			
			var result:NAResultMapParameter = new NAResultMapParameter();
			result.backgroundTransparent = json.backgroundTransparent;
			result.bounds = JsonUtil.toRectangle2D(json.bounds);
			result.center = JsonUtil.toPoint2D(json.center);
			
			result.format = json.format as OutputFormat;
			result.scale = json.scale;
			result.style = ServerStyle.fromJson(json.style);
			result.useDefaultParameter = json.useDefaultParameter;
			result.viewer = JsonUtil.toRectangle(json.viewer);
			
			return result;
		}

	}
}