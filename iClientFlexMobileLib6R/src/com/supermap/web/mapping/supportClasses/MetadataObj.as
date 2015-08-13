package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	
	import flash.utils.Dictionary;
	use namespace sm_internal;
	public class MetadataObj
	{
		// 应该为安符串
		private var _bounds:Rectangle2D;
		private var _name:String = "";
		private var _type:String = "baselayer";
		private var _version:String = "1.0.0";
		private var _description:String = "";
		private var _format:String = "png";
		private var _compatible:Boolean;

		private var _tag:String = "MOBAC";
		private var _resolutions:Array = null;
		private var _scales:Array = null;
		private var _crs_wkid:int = 0;
		private var _unit:String = "degree";
		
		private var _minzoom:int = 0;
		private var _maxzoom:int = 0;
		
		//以下属性暂时没有使用
//		private var _legend:String = "";
		private var _resolutionsStr:String = "";
		private var _tileSize:int = 256;
		
		private var _attribution:Dictionary = new Dictionary;
		
		public function MetadataObj()
		{
		}

		//提供额外信息的设置,值允许字符串格式

		public function get compatible():Boolean
		{
			return _compatible;
		}

		public function set compatible(value:Boolean):void
		{
			_compatible = value;
		}

		public function get unit():String
		{
			return _unit;
		}

		public function set unit(value:String):void
		{
			_unit = value;
		}

		public function get crs_wkid():int
		{
			return _crs_wkid;
		}

		public function set crs_wkid(value:int):void
		{
			_crs_wkid = value;
		}

		public function get resolutions():Array
		{
			return _resolutions;
		}

		public function set resolutions(value:Array):void
		{
			_resolutions = value;
		}

		public function get scales():Array
		{
			return _scales;
		}

		public function set scales(value:Array):void
		{
			_scales = value;
		}

		public function get tag():String
		{
			return _tag;
		}

		public function set tag(value:String):void
		{
			_tag = value;
		}

		public function get tileSize():int
		{
			return _tileSize;
		}

		public function set tileSize(value:int):void
		{
			_tileSize = value;
		}

		public function getResolutions():Array
		{
			return _resolutions;
		}

		public function setResolutions(value:Array):void
		{
			_resolutions = value;
			var item:Number;
			_resolutionsStr = "";
			for each(item in _resolutions)
			{
				_resolutionsStr = _resolutions + item + ",";
			}
			if(0 != resolutionsStr.length)
			{
				_resolutionsStr = _resolutionsStr.substr(0, _resolutionsStr.length - 1);
			}
		}

		public function get resolutionsStr():String
		{
			return _resolutionsStr;
		}

		public function set resolutionsStr(value:String):void
		{
			_resolutionsStr = value;
			_resolutions = getResolutionsFromStr(value);
		}

		public function get attribution():Dictionary
		{
			return _attribution;
		}
		
		//添加额外属性
		public function addAttribution(key:String, value:String):void
		{
			_attribution[key] = value;
		}
		
		//获取具体属性key对应的值
		public function getAttributionValue(key:String):String
		{
			return _attribution[key];
		}

		//图片格式
		public function get format():String
		{
			return _format;
		}

		public function set format(value:String):void
		{
			_format = value;
		}

		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
		}

//		public function get legend():String
//		{
//			return _legend;
//		}

//		public function set legend(value:String):void
//		{
//			_legend = value;
//		}

		//描述信息
		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		public function get maxzoom():int
		{
			return _maxzoom;
		}

		public function set maxzoom(value:int):void
		{
			_maxzoom = value;
		}

		public function get minzoom():int
		{
			return _minzoom;
		}

		public function set minzoom(value:int):void
		{
			_minzoom = value;
		}

		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get staticAttribution():Dictionary
		{
			var temp:Dictionary = new Dictionary;
			temp["name"] = name;
			temp["format"] = format;
			temp["type"] = type;
			temp["version"] = version;
//			temp["legend"] = legend;
			temp["description"] = description;
			temp["maxzoom"] = maxzoom;
			temp["minzoom"] = minzoom;
			temp["bounds"] = bounds;
			temp["resolutions"] = resolutionsStr;
			temp["tileSize"] = tileSize;
			temp["compatible"] = compatible;
			return temp;
		}
		
		sm_internal function getResolutionsFromStr(resolutionsStr:String):Array
		{
			if(null == resolutionsStr || 0 == resolutionsStr.length)
			{
				return null;
			}
			var reses:Array = resolutionsStr.split(",");
			var resNums:Array = [];
			var item:String = "";
			//整理resolutions，回头考虑放到metadataObj中做这步处理
			for each( item in reses)
			{
				if(isNaN(Number(item)))
				{
					continue;
				}
				resNums.push(Number(item));
			}
			return resNums;
		}
		
		sm_internal function getScalesFromStr(scalesStr:String):Array
		{
			if(null == scalesStr || 0 == scalesStr.length)
			{
				return null;
			}
			var scalesArr:Array = scalesStr.split(",");
			var result:Array = [];
			for each(var item:String in scalesArr)
			{
				if(isNaN(Number(item)))
				{
					continue;
				}
				result.push(1/Number(item));
			}
			return result;
		}
		
		public function validateMetadata():void
		{
			//检查图层级别
			var levelLength:int = maxzoom - minzoom + 1;
			if(levelLength != _resolutions.length)
			{
				throw new Error("图层级别不匹配");
			}
			
			//检查bounds信息
			//符合左上右下的要求
		}
		
		sm_internal function getLayerBounds(bounds:String):Rectangle2D
		{
			var boundsArr:Array = bounds.split(",");
			return new Rectangle2D(Number(boundsArr[0]),Number(boundsArr[1]),Number(boundsArr[2]),Number(boundsArr[3]));
		}
	}
}