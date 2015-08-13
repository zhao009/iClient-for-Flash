package com.supermap.web.utils
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.utils.Unit;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.geom.Rectangle;
	use namespace sm_internal;

	/**
	 * ${iServer6_ScaleUtil_Title}.
	 * <p>${iServer6_ScaleUtil_Description}</p>
	 * @see  scaleToResolutionWithoutDPI()
	 * 
	 */		
	public class ScaleUtil
	{
		
		private static const PIXELS_PER_METER:Number = 3779.53;
		private static const EARTH_RADIUS_IN_METERS:Number = 6371000;
		private static const TWO_PI:Number = Math.PI * 2;
		private static const METERS_PER_DEGREE:Number = TWO_PI * EARTH_RADIUS_IN_METERS / 360;
		private static const PIXELS_PER_DEGREE:Number = PIXELS_PER_METER * METERS_PER_DEGREE;
		
		sm_internal static function getDpi2(referViewBounds:Rectangle2D, referViewer:Rectangle, referScale:Number):Number
		{		
			var ratio:Number = 10000;
			//10000 是 0.1毫米与米的转换，底层UGC有个int变换，换回去即可
			
			var nD1:Number = referViewBounds.width * ratio * referScale;//逻辑宽度（单位：0.1毫米），比例尺=图上距离：实际距离，
			                                                                                                //这里所计算的即为referViewBounds.width代表的图上宽度。
			
			nD1 = (nD1 > 0.0) ? int(nD1 + 0.5) : int(nD1 - 0.5);//判断当前地图单位是否为经纬度，若逻辑宽度nD1的值介于-0.5~0.5之间，则认为地图单位为经纬度
			
			var num1:Number = referViewBounds.width / referViewer.width;//横向分辨率
			var num2:Number = referViewBounds.height / referViewer.height;//纵向分辨率
			var referResolution:Number = num1 > num2 ? num1 : num2;//取横向或纵向分辨率中的较大者，用于计算DPI
			
			//地图单位为经纬度
			if (nD1 == 0)
			{
				var referScaleRatio:int = 100000;
				referScale *= referScaleRatio;//referScale乘以100000，用于保证比例尺值小数点后的精度
				var dpi0:Number = 0.0254 / referResolution / referScale;//DPI与分辨率、比例尺之间的转换公式
				return dpi0 * referScaleRatio;//这里DPI再乘以100000，和上步抵消
			}
			
			//地图单位为米，则按以下步骤计算DPI
			//1英寸 = 0.0254 米   1米 = 39.3700787 英寸
			var nD2:Number = nD1 / referViewer.width;//DPI定义为一英寸所代表的像素个数，即DPI=像素大小/英寸大小，可见该行代码可被视为DPI的导数。
			var dpi:Number = 0.0254 / (nD2 / ratio);//将上行计算中nD1的单位转换英寸，再取nD2的导数即为DPI值
			return dpi;
		}
		
		/**
		 * ${iServer6_ScaleUtil_method_getDpi_D}. 
		 * <p>${iServer6_ScaleUtil_method_getDpi_remarks}</p> 
		 * @return ${iServer6_ScaleUtil_method_getDpi_return}
		 * 
		 */		
		public static function getDpi(referViewBounds:Rectangle2D, referViewer:Rectangle, referScale:Number, datumAxis:Number = 6378137):Number
		{		
			var ratio:Number = 10000;
			//10000 是 0.1毫米与米的转换，底层UGC有个int变换，换回去即可
			
			var nD1:Number = referViewBounds.width * ratio * referScale;//逻辑宽度（单位：0.1毫米），比例尺=图上距离：实际距离，
			//这里所计算的即为referViewBounds.width代表的图上宽度。
			
			var nD3:Number = (nD1 > 0.0) ? int(nD1 + 0.5) : int(nD1 - 0.5);//判断当前地图单位是否为经纬度，若逻辑宽度nD1的值介于-0.5~0.5之间，则认为地图单位为经纬度
			
			var num1:Number = referViewBounds.width / referViewer.width;//横向分辨率
			var num2:Number = referViewBounds.height / referViewer.height;//纵向分辨率
			var referResolution:Number = num1 > num2 ? num1 : num2;//取横向或纵向分辨率中的较大者，用于计算DPI
			
			//地图单位为经纬度
			if (nD3 == 0)
			{
				var tempRes:Number = referResolution * ((Math.PI*2*datumAxis)/360);
				var referScaleRatio:int = 100000;
				referScale *= referScaleRatio;//referScale乘以100000，用于保证比例尺值小数点后的精度
				var dpi0:Number = 0.0254 / tempRes / referScale;//DPI与分辨率、比例尺之间的转换公式
				return dpi0 * referScaleRatio;//这里DPI再乘以100000，和上步抵消
			}
			
			//地图单位为米，则按以下步骤计算DPI
			//1英寸 = 0.0254 米   1米 = 39.3700787 英寸
			var nD2:Number = nD1/ referViewer.width;//DPI定义为一英寸所代表的像素个数，即DPI=像素大小/英寸大小，可见该行代码可被视为DPI的导数。
			var dpi:Number = 0.0254 / (nD2 / ratio);//将上行计算中nD1的单位转换英寸，再取nD2的导数即为DPI值
			return dpi;
		}
		
		//调用这个函数前需把scales中的值设置为1：XXXX的形式
		/**
		 * ${iServer6_ScaleUtil_method_scalesToResolutions_D} 
		 * @param scales ${iServer6_ScaleUtil_method_scalesToResolutions_param_scales}
		 * @param dpi ${iServer6_ScaleUtil_method_scalesToResolutions_param_dpi}
		 * @param unit ${iServer6_ScaleUtil_method_scalesToResolutions_param_unit}
		 * @param datumAxis ${iServer6_ScaleUtil_method_scalesToResolutions_param_datumAxis}
		 * @return  ${iServer6_ScaleUtil_method_scalesToResolutions_return}
		 * 
		 */		
		public static function scalesToResolutions(scales:Array, dpi:Number, unit:String = "degree", datumAxis:Number = 6378137):Array
		{
			var resolutions:Array = [];
			if (dpi != 0.0)
			{
				var length:int = scales.length;
				for (var i:int = 0; i < length; i++)
				{
					resolutions[i] = scaleToResolution(scales[i], dpi, unit, datumAxis);//0.0254 / scales[i] / dpi;
				}
			}
			return resolutions;
		}
		
		//将经纬度单位的分辨率转换为米制单位，采用的椭球半径为 6371000，该方法内部目前没用到，暂不考虑
		sm_internal static function ResolutionToResolutionForMeter(resolution:Number, map:Map):Number
		{
			var metersPerPixel:Number;
			if(resolution && map && map.CRS)
			{
				if(map.CRS.unit.toLowerCase() != Unit.METER)
				{
					metersPerPixel = resolution * PIXELS_PER_DEGREE / PIXELS_PER_METER;
				}
				else
					metersPerPixel = resolution;
			}
			return metersPerPixel;
		}
		
		//该方法根据Map参数可获取地图单位，并取椭球半径： 6371000，DPI：96，因此该方法暂不考虑 unit 和 datum 参数
		/**
		 * ${iServer6_ScaleUtil_method_scaleToResolutionWithoutDPI_D}.
		 * <p>${iServer6_ScaleUtil_method_scaleToResolutionWithoutDPI_remarks}</p> 
		 * @param scale ${iServer6_ScaleUtil_method_scaleToResolutionWithoutDPI_param_scale}
		 * @param map ${iServer6_ScaleUtil_method_scaleToResolutionWithoutDPI_param_map}
		 * @return ${iServer6_ScaleUtil_method_scaleToResolutionWithoutDPI_return}
		 * 
		 */		
		public static function scaleToResolutionWithoutDPI(scale:Number, map:Map):Number
		{
			if(map.CRS)
			{
				if(map.CRS.unit.toLowerCase() != Unit.METER)
				{
					return 1 / scale / PIXELS_PER_DEGREE;
				}
				else
					return 1 / scale / PIXELS_PER_METER;
			}
			return NaN;
		}
		
		//该方法根据Map参数可获取地图单位，并取椭球半径： 6371000，DPI：96，因此该方法暂不考虑 unit 和 datum 参数
		/**
		 * ${iServer6_ScaleUtil_method_scalesToResolutionsWithoutDPI_D}.
		 * <p>${iServer6_ScaleUtil_method_scalesToResolutionsWithoutDPI_remarks}</p> 
		 * @param scales ${iServer6_ScaleUtil_method_scalesToResolutionsWithoutDPI_param_scales}
		 * @param map ${iServer6_ScaleUtil_method_scalesToResolutionsWithoutDPI_param_map}
		 * @return ${iServer6_ScaleUtil_method_scalesToResolutionsWithoutDPI_return}
		 * @see scaleToResolutionWithoutDPI()
		 * 
		 */		
		public static function scalesToResolutionsWithoutDPI(scales:Array, map:Map):Array
		{
			var resolutions:Array = [];
			
			var length:int = scales.length;
			for (var i:int = 0; i < length; i++)
			{
				resolutions[i] = scaleToResolutionWithoutDPI(scales[i], map);
			}
			
			return resolutions;
		}
		
		/**
		 * ${iServer6_ScaleUtil_method_scaleToResolution_D} 
		 * @param scale ${iServer6_ScaleUtil_method_scaleToResolution_param_scale}
		 * @param dpi ${iServer6_ScaleUtil_method_scaleToResolution_param_dpi}
		 * @param unit ${iServer6_ScaleUtil_method_scalesToResolutions_param_unit}
		 * @param datumAxis ${iServer6_ScaleUtil_method_scalesToResolutions_param_datumAxis}
		 * @return ${iServer6_ScaleUtil_method_scaleToResolution_return}
		 * 
		 */		
		public static function scaleToResolution(scale:Number, dpi:Number, unit:String = "degree", datumAxis:Number = 6378137):Number
		{
			var res:Number = NaN;
			if (dpi != 0.0 && scale > 0)
			{
				res = 0.0254 / scale / dpi;//分辨率单位为：米/像素
				if(unit && (unit.toLowerCase() == "degree" || unit.toLowerCase() == "undefined"))
				{
					res /= ((Math.PI*2*datumAxis)/360);//米转度
				}
			}
			return res;
		}
		
		/**
		 * ${iServer6_ScaleUtil_method_resolutionToScale_D} 
		 * @param resolution ${iServer6_ScaleUtil_method_resolutionToScale_param_resolution}
		 * @param dpi ${iServer6_ScaleUtil_method_resolutionToScale_param_dpi}
		 * @param unit ${iServer6_ScaleUtil_method_scalesToResolutions_param_unit}
		 * @param datumAxis ${iServer6_ScaleUtil_method_scalesToResolutions_param_datumAxis}
		 * @return ${iServer6_ScaleUtil_method_resolutionToScale_return}
		 * 
		 */		
		public static function resolutionToScale(resolution:Number, dpi:Number, unit:String = "degree", datumAxis:Number = 6378137):Number
		{
			var scale:Number = NaN;
			if (dpi != 0.0 && resolution > 0)
			{
				if(unit && (unit.toLowerCase() == "degree" || unit.toLowerCase() == "undefined"))
				{
					resolution *= ((Math.PI*2*datumAxis)/360);//度转米
				}
				scale = 0.0254 / resolution / dpi;
			}
			return scale;
		}
	}
}