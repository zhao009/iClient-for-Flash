package com.supermap.web.iServerJava2.mapServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.geom.Rectangle;
	
	use namespace sm_internal;

	/**
	 * ${iServer2_getMapStatus_GetMapStatusResult_Title}.
	 * <p>${iServer2_getMapStatus_GetMapStatusResult_Description}</p> 
	 * 
	 * 
	 */	
	public class GetMapStatusResult
	{
		private var _mapName:String;
		private var _coordsSys:CoordinateReferenceSystem;
		private var _referScale:Number;
		private var _mapBounds:Rectangle2D;
		private var _referViewBounds:Rectangle2D;
		private var _referViewer:Rectangle;
		private var _serverLayers:Array;
		
		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_serverLayers_D} 
		 */
		public function get serverLayers():Array
		{
			return _serverLayers;
		}
		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_referViewer_D} 
		 */
		public function get referViewer():Rectangle
		{
			return _referViewer;
		}

		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_referViewBounds_D} 
		 */
		public function get referViewBounds():Rectangle2D
		{
			return _referViewBounds;
		}

		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_mapBounds_D} 
		 */
		public function get mapBounds():Rectangle2D
		{
			return _mapBounds;
		}

		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_referScale_D} 
		 */
		public function get referScale():Number
		{
			return _referScale;
		}
		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_coordsSys_D} 
		 */
		public function get coordsSys():CoordinateReferenceSystem
		{
			return _coordsSys;
		}

		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_mapName_D} 
		 */
		public function get mapName():String
		{
			return _mapName;
		}

		/**
		 * ${iServer2_getMapStatus_GetMapStatusResult_attribute_DPI_D} 
		 * @return 
		 * 
		 */		
		public function get DPI():Number 	// 服务器端平面的分辨率
		{
			if (this.referScale && this.referViewBounds && this.referViewer)			
				return this.referScale * this.referViewBounds.width / this.referViewer.width;
				
			return -1;
		}
		

		sm_internal static function toMapStatusResult(object:Object):GetMapStatusResult
		{
			var GMSR:GetMapStatusResult;
            if (object)
            {
                GMSR = new GetMapStatusResult();
                GMSR._mapName = object.mapName;
                GMSR._coordsSys = JsonUtil.toCRS(object.coordsSys);
                GMSR._referScale = object.referScale;
                GMSR._mapBounds = JsonUtil.toRectangle2D(object.mapBounds);          									
               	GMSR._referViewBounds = JsonUtil.toRectangle2D(object.referViewBounds);
               	if(object.layers)
               	{
               	   	GMSR._serverLayers = new Array();
	               	var tempServerLayers:Array = object.layers;
	               	for(var i:int = 0; i < tempServerLayers.length; i++)
	               	{
	                	GMSR.serverLayers.push(ServerLayer.toServerLayer(tempServerLayers[i]));
	               	}
               	}
               	GMSR._referViewer =  JsonUtil.toRectangle(object.referViewer);
            }
            return GMSR;
		}

	}
}