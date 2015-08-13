package com.supermap.path
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.styles.PredefinedLineStyle;

	public class FindPathRecordSet
	{
		private var _features:Array;
		private var _distance:String;
		private var _pathInfo:Array;
		
		public function get pathInfo():Array
		{
			return _pathInfo;
		}
		
		public function set pathInfo(value:Array):void
		{
			_pathInfo = value;
		}
		
		public function set distance(value:String):void
		{
			_distance = value;
		}
		
		public function get distance():String
		{
			return _distance;
		}
		
		public function get features():Array
		{
			return _features;
		}
		
		public function set features(value:Array):void
		{
			_features = value;
		}
		public function FindPathRecordSet()
		{
		}
		
		public static function toExtendRecordSetPath(object:Object):FindPathRecordSet
		{
			var recordset:FindPathRecordSet;
			if(object&&object.distance&&object.pathInfoList)
			{
				recordset = new FindPathRecordSet();	
				recordset.distance = object.distance;
				
				var fs:Array = [];
				var pathArr:Array = [];
				pathArr = (object.path as Object).parts as Array;
				for(var k:int = 0; k < pathArr.length; k++)
				{ 
					var point:Array = pathArr[k];
					var line:GeoLine = new GeoLine();
					var parts:Array = [];
					for(var i:int = 0;i <point.length;i++)
					{
						parts.push(new Point2D(point[i].x,point[i].y));
					}
					line.addPart(parts);
					var lineFeature:Feature = new Feature();
					lineFeature.geometry = line;
					lineFeature.style = new PredefinedLineStyle(PredefinedLineStyle.SYMBOL_SOLID,0x126d00,0.8,6);
					fs.push(lineFeature);
				}
				recordset.pathInfo = object.pathInfoList as Array;
				recordset.features = fs;
				return recordset;
			}
			else
			{
				return null;
			}
		}
	}
}