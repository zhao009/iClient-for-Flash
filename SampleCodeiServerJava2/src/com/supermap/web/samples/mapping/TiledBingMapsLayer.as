package com.supermap.web.samples.mapping
{	
	import com.supermap.web.core.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import mx.events.*;
	

	public class TiledBingMapsLayer extends TiledCachedLayer
	{
		private var _mapType:String = "road";
		private var _mapTypeChanged:Boolean;
		
		private const AE_URL:String = "http://a{subdomain}.ortho.tiles.virtualearth.net/tiles/a{quadkey}.png?g=50";
		private const AE_LABEL_URL:String = "http://h{subdomain}.ortho.tiles.virtualearth.net/tiles/h{quadkey}.png?g=50";
		private const ROAD_URL:String = "http://r{subdomain}.ortho.tiles.virtualearth.net/tiles/r{quadkey}.png?g=50";
	
		public static const MAP_TYPE_AERIAL:String = "aerial";
		public static const MAP_TYPE_AERIAL_WITH_LABELS:String = "aerialWithLabels";	
		public static const MAP_TYPE_ROAD:String = "road";
				
		public function TiledBingMapsLayer(mapType:String = "road")
		{
			this.bounds = new Rectangle2D(-2.00375e+007, -2.00375e+007, 2.00375e+007, 2.00375e+007);
			this.CRS = new CoordinateReferenceSystem(102100);
			this.buildTileInfo();
			this._mapType = mapType;			
			setLoaded(true);				
		}
			
		public function get mapType() : String
		{
			return this._mapType;
		}
		
		public function set mapType(value:String) : void
		{
			var old_mapType:String = this.mapType;
			if (old_mapType !== value)
			{
				if (this._mapType != value)
				{
					this._mapType = value;
					this._mapTypeChanged = true;
					invalidateProperties();
				}
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "mapType", old_mapType, value));
				}
			}
		}
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._mapTypeChanged)
			{
				removeAllChildren();
				this._mapTypeChanged = false;
				invalidateLayer();
			}
		}
		
		override protected function getTileURL(row:int, col:int, level:int) : URLRequest
		{
			var serverURL:String;
			switch(this._mapType)
			{
				case MAP_TYPE_AERIAL:
					serverURL = AE_URL;
					break;
				case MAP_TYPE_AERIAL_WITH_LABELS:
					serverURL = AE_LABEL_URL;
					break;
				case MAP_TYPE_ROAD:
					serverURL = ROAD_URL;
					break;
				default:
					serverURL = ROAD_URL;
					break;
			}
			var serverID:int = Math.round(Math.random() * 3);
			var quadKey:String = this.tileToQuadKey(level+1, row, col);
			serverURL = serverURL.replace("{quadkey}", quadKey);
			serverURL = serverURL.replace("{subdomain}", serverID);
			return new URLRequest(serverURL);
		}
		
		private function loadImageryInfo() : void
		{
			setLoaded(true);
			invalidateLayer();
		}
		
		private function buildTileInfo() : void
		{
			this.tileSize = 256;
			this.origin = new Point2D(-2.00375e+007, 2.00375e+007);
			this.resolutions = [78271.5, 39135.8, 19567.9,
							     9783.94, 4891.97, 2445.98, 1222.99,  
							     611.496, 305.748, 152.874, 76.437, 
							     38.2185, 19.1093, 9.55463, 4.77731,
							     2.38866, 1.19433, 0.597164, 0.298582,
							     0.149291, 0.074646, 0.037323, 0.018661];
		}
		
		private function tileToQuadKey(level:int, tileY:int, tileX:int) : String
		{
			var quadKey:String = "";
			for (var i:int = level; i > 0; i--)
			{
				var digit:int = 0;
				var mask:int = 1 << (i - 1);
				if ((tileX & mask) != 0)
				{
					digit++;
				}
				if ((tileY & mask) != 0)
				{
					digit++;
					digit++;
				}
				quadKey = quadKey + digit.toString();
			}
			return quadKey;
		}	
		
	}
}