package com.supermap.web.samples.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.utils.Unit;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import mx.events.*;
	
	public class ArcGIS93MapLayer extends TiledCachedLayer
	{		
		private var _tileServer:String;
		private var _isBaseLayer:Boolean = true;
		private var _projection:String;
				
		public function ArcGIS93MapLayer()
		{
			this.bounds = new Rectangle2D(-2.00375e+007, -2.00375e+007, 2.00375e+007, 2.00375e+007);
			this.CRS = new CoordinateReferenceSystem(this.projection as int,Unit.METER);
			this.buildTileInfo();						
			setLoaded(true);
		}

		override protected function getTileURL(row:int, col:int, level:int) : URLRequest
		{
			var serverURL:String;			
			//计算瓦片左下角点的坐标
			var x1:Number = this.origin.x + this.tileSize * this.resolutions[level] * col ;
			var y1:Number = this.origin.y - this.tileSize * this.resolutions[level] * (row+1);
			//计算瓦片右上角点的坐标
			var x2:Number = this.origin.x + this.tileSize * this.resolutions[level] * (col+1);
			var y2:Number = this.origin.y - this.tileSize * this.resolutions[level] * row;		
			var BBOX:String = x1.toString()+ "," + y1.toString() + "," + x2.toString() + "," + y2.toString();
			serverURL = this.tileServer + "?LAYERS=show:0,1,2,4&FORMAT=png&BBOX="+ BBOX + "&SIZE=256,256&F=image&BBOXSR=" + this.projection + "&IMAGESR="+ this.projection;
			return new URLRequest(serverURL);
		}
									
		private function buildTileInfo() : void
		{
			this.tileSize = 256;
			this.origin = new Point2D(-20037508.342787, 20037508.342787);
		}
		
		public function get projection():String
		{
			return _projection;
		}
		
		public function set projection(value:String):void
		{
			_projection = value;
		}
		
		public function get isBaseLayer():Boolean
		{
			return _isBaseLayer;
		}
		
		public function set isBaseLayer(value:Boolean):void
		{
			_isBaseLayer = value;
		}
		
		public function get tileServer():String
		{
			return _tileServer;
		}
		
		public function set tileServer(value:String):void
		{
			_tileServer = value;
		}
		
	}
}