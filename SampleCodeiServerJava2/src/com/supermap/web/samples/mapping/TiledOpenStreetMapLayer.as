package com.supermap.web.samples.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import mx.events.*;
	
	[IconFile("/designIcon/TiledOpenStreetMapLayer.png")]
	public class TiledOpenStreetMapLayer extends TiledCachedLayer
	{
		private var _mapType:int;
		private var _mapTypeChanged:Boolean;
		private var _tileServers:Array;
		
		
		public function TiledOpenStreetMapLayer()
		{	
			this.bounds = new Rectangle2D(-2.00375e+007, -2.00375e+007, 2.00375e+007, 2.00375e+007);
			this.CRS = new CoordinateReferenceSystem(102100);
			this.buildTileInfo();
			this._tileServers = ["http://a.tile.openstreetmap.org/", "http://b.tile.openstreetmap.org/", "http://c.tile.openstreetmap.org/"];
			setLoaded(true);
		}
		
		override protected function getTileURL(row:int, col:int, level:int) : URLRequest
		{
			var serverURL:String;
			var serverID:int = Math.round(Math.random() * 3);
			serverURL = this._tileServers[serverID] + level + "/" + col + "/" + row + ".png";
			return new URLRequest(serverURL);
		}
		
		private function buildTileInfo() : void
		{
			this.tileSize = 256;
			this.origin = new Point2D(-20037508.3392, 20037508.3392);
			this.resolutions = [156543, 78271.5, 39135.8, 19567.9, 
								 9783.94, 4891.97, 2445.98, 1222.99,
								 611.496,  305.748, 152.874, 76.437,
								 38.2185, 19.1093, 9.55463,  4.77731,  
								 2.38866, 1.19433, 0.597164];

		}
	}
}