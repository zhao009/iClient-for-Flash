package com.supermap.web.mapping
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.mapping.supportClasses.MBTilesUtil;
	import com.supermap.web.mapping.supportClasses.MetadataObj;
	import com.supermap.web.sm_internal;

	import flash.events.Event;
	import flash.utils.ByteArray;
	use namespace sm_internal;

	[Exclude(name="url", kind="property")]
	[Exclude(name="resolutions", kind="property")]
	[Exclude(name="scales", kind="property")]
	[Exclude(name="tileSize", kind="property")]
	[Exclude(name="imageFormat", kind="property")]
	[Exclude(name="origin", kind="property")]

	/**
	 * ${mapping_MBTilesLayer_Title}.
	 * <p>${mapping_MBTilesLayer_Description}</p>
	 *
	 *
	 */
	public class MBTilesLayer extends TiledCachedLayer
	{
		/**
		 * @private
		 */
		private var _mbtilesPath:String="";
		private var _mbtilesHelper:MBTilesUtil;
		private var _metadataObj:MetadataObj;
		private var _compatible:Boolean;
//		private var _defaultResolutions:Array=[156543.0339, 78271.51695, 39135.758475, 19567.8792375, 9783.939619, 4891.969809, 2445.984905, 1222.992452, 611.496226, 305.748113, 152.874057, 76.437028, 38.218514, 19.109257, 9.554629, 4.777314, 2.388657, 1.194328, 0.597164, 0.298582, 0.149291, 0.074646, 0.037323];

		//中国范围 8095077.4039, 723063.43873, 15163690.1746, 7129832.1305,默认为全球范围 _defaultBounds
//		private var _defaultBounds:Rectangle2D = new Rectangle2D(-2.00375e+007, -2.00375e+007, 2.00375e+007, 2.00375e+007);

		//构造函数
		/**
		 * ${mapping_MBTilesLayer_constructor_None_D}
		 *
		 */
		public function MBTilesLayer()
		{
			super();
			_offlineFilestored=true;
		}

		/**
		 * ${mapping_MBTilesLayer_attribute_mbtilesPath_D}
		 * @return
		 *
		 */
		public function set mbtilesPath(value:String):void
		{
			_mbtilesPath=value;
			_mbtilesHelper=new MBTilesUtil(_mbtilesPath);
			if (_mbtilesHelper.open())
			{
				_metadataObj=_mbtilesHelper.readMetadataObj();
				//设置图层元数据信息
				if (null != _metadataObj)
				{
					this.bounds=_metadataObj.bounds;

//					if (_metadataObj.tag == "supermap")
//					{
					this.resolutions=_metadataObj.resolutions;
					this.scales=_metadataObj.scales;
					this.origin=new Point2D(this.bounds.left, this.bounds.top);
					this._compatible=_metadataObj.compatible;

					this.tileSize=_metadataObj.tileSize;
					this.imageFormat=("jpg" == _metadataObj.format.toLowerCase()) ? ImageFormat.JPG : ImageFormat.PNG;
					this.CRS=new CoordinateReferenceSystem(_metadataObj.crs_wkid , _metadataObj.unit);
//					}
//					else
//					{
//						this.tileSize = _metadataObj.tileSize;
//						this.origin = new Point2D(this.bounds.left, this.bounds.top);
//						this.imageFormat = ("jpg" == _metadataObj.format.toLowerCase()) ? ImageFormat.JPG : ImageFormat.PNG;
//						this.resolutions = _defaultResolutions.slice(_metadataObj.minzoom, _metadataObj.maxzoom + 1);
//						this.CRS = new CoordinateReferenceSystem(3857, "meter");
//						this._isMBTiles = _metadataObj.isMBTiles;
//					}
					setLoaded(true);
				}
				else
				{
					throw new Error("数据错误");
				}
			}
			else
			{
				throw new Error("离线数据包路径设置错误");
			}
		}

		override protected function getLocalTile(row:int, col:int, level:int):ByteArray
		{
			if ("" == _mbtilesPath || null == _mbtilesHelper || !_mbtilesHelper.opened || level < 0)
			{
				return null;
			}
			//加上最小级别，换算成从左上角点出图,MBTiles是从左 下 角切图（supermap iServer切的MBTiles缓存也遵循此标准）
//			var mLevel:int = level + _metadataObj.minzoom;
//			if(_metadataObj.tag == "supermap")
//			{
//				return _mbtilesHelper.getTile(row, col, mLevel);
//			}
			var resolution:Number=this.resolutions[level];
			if (!_compatible)
			{
				return _mbtilesHelper.getTile(row, col, resolution);
			}
			else
			{
				return _mbtilesHelper.getTile(Math.pow(2, level) - row - 1, col, resolution);
			}
		}
	}
}
