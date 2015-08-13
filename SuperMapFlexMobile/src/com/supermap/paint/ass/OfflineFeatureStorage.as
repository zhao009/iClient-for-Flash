package com.supermap.paint.ass
{
	import com.supermap.events.ViewerEventDispatcher;
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.*;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.NetworkInfo;
	import flash.net.NetworkInterface;
	
	import mx.utils.NameUtil;

	use namespace sm_internal;

	/**
	 * 提供将feature存储到本地功能的类。
	 */
	public class OfflineFeatureStorage
	{
		private var _userRootDirectory:String = "featureCache";
		private var localFileStream:FileStream;
		
		public function get userRootDirectory():String
		{
			return _userRootDirectory;
		}
		
		/**
		 * 设置存储路径,如 "supermap/features"。
		 */
		public function set userRootDirectory(value:String):void
		{
			_userRootDirectory = value;
			if(!_userRootDirectory)
				_userRootDirectory = "featureCache";
		}

		/**
		 * 添加feature。
		 */
		public function putFeature(feature:Feature):void
		{
			if(!feature.id)
				feature.id = NameUtil.createUniqueName(feature);
			var path:String;
			path = _userRootDirectory + "/" + feature.id;
			var localFile:File = File.documentsDirectory.resolvePath(path);
			localFileStream = new FileStream();
			localFileStream.open(localFile, FileMode.WRITE);
			localFileStream.writeObject(feature);
			localFileStream.close();
			path = null;
		}
		
		/**
		 * 更新feature。
		 * @return 更新成功时返回true,否则返回false。
		 */
		public function updateFeature(feature:Feature):Boolean
		{
			var path:String;
			path = _userRootDirectory + "/" + feature.id;
			var localFile:File = File.documentsDirectory.resolvePath(path);
			if(localFile.exists)
			{
				localFileStream = new FileStream();
				localFileStream.open(localFile, FileMode.READ);
				var feaObj:Object = localFileStream.readObject();
				feaObj.geometry = feature.geometry;
				feaObj.attributes = feature.attributes;
				localFileStream.open(localFile, FileMode.WRITE);
				localFileStream.writeObject(feaObj);
				localFileStream.close();
				return true;
			}
			path = null;
			return false;
		}
		
		/**
		 * 获取用户路径下的所有feature。
		 */
		public function get features():Array
		{
			var features:Array = [];
			var path:String = _userRootDirectory;
			var localFile:File = File.documentsDirectory.resolvePath(path);
			if(localFile.exists)
			{
				var featureList:Array = localFile.getDirectoryListing();
				for each(var feaFile:File in featureList)
				{
					localFileStream = new FileStream();
					localFileStream.open(feaFile, FileMode.READ);
					var fea:Object = localFileStream.readObject();
					localFileStream.close();
					features.push(this.toFeature(fea));
				}
				path = null;
			}
			return features;
		}
		
		/**
		 * 获取用户路径下的单个feature。
		 * @param id feature的id
		 * @return　Feature。
		 */
		public function getFeatureByID(id:String):Feature
		{
			var path:String = _userRootDirectory + "/" + id;
			var localFile:File = File.documentsDirectory.resolvePath(path);
			var feature:Feature = null;
			if(localFile.exists)
			{
				localFileStream = new FileStream();
				localFileStream.open(localFile, FileMode.READ);
				var feaObj:Object = localFileStream.readObject();
				feature = this.toFeature(feaObj);
				localFileStream.close();
			}
			return feature;
		}
		
		/**
		 * 通过id删除单个feature。
		 */
		public function removeFeatureByID(id:String):void
		{
			var path:String = _userRootDirectory + "/" + id;
			var localFile:File = File.documentsDirectory.resolvePath(path);
			if(localFile.exists)
			{
				localFile.deleteFile();
			}
		}
		
		/**
		 * 检测当前网络是否可用。
		 * @return 如果可用返回true,否则返回false。 
		 */
		public function networkConnectionEnabled():Boolean
		{   
			var interfaces:Vector.<NetworkInterface> = NetworkInfo.networkInfo.findInterfaces(); 
			
			for (var i:int = 0; i < interfaces.length; i++)    
			{   
				if(interfaces[i].name.toLowerCase() == "wifi" && interfaces[i].active){   
					return true;  
				}   
				else if(interfaces[i].name.toLowerCase() == "mobile" && interfaces[i].active){   
					return true;   
				}   
			}   
			return false; 
		}   

		/**
		 * 清除用户路径下的所有feature。
		 */
		public function clear():void
		{
			var localFile:File = File.documentsDirectory.resolvePath(_userRootDirectory);
			if(localFile.exists)
			{
				localFile.deleteDirectory(true);
			}
		}
		
		private function toGeoPoint(obj:Object):GeoPoint
		{
			var geoPoint:GeoPoint = new GeoPoint();
			geoPoint.x = obj.x;
			geoPoint.y = obj.y;
			geoPoint.type = Geometry.GEOPOINT;
			
			return geoPoint;
		}
		
		private function toGeoLine(obj:Object):GeoLine
		{
			var line:GeoLine;
			var partsObj:Array = obj.parts[0];
			if(partsObj &&　partsObj.length)
			{
				var p2ds:Array = [];
				for each (var point:Object in partsObj)
				{ 
					var point2D:Point2D = new Point2D(point.x, point.y);
					p2ds.push(point2D);
				}
				line = new GeoLine();
				line.addPart(p2ds);
//				line.center = new Point2D(obj.center.x, obj.center.y);
				line.type = Geometry.GEOLINE;
			}
			return line;
		}
		
		private function toGeoRegion(obj:Object):GeoRegion
		{
			var region:GeoRegion;
			var partsObj:Array = obj.parts[0];
			if(partsObj &&　partsObj.length)
			{
				var p2ds:Array = [];
				for each (var point:Object in partsObj)
				{ 
					var point2D:Point2D = new Point2D(point.x, point.y);
					p2ds.push(point2D);
				}
				region = new GeoRegion();
				region.addPart(p2ds);
//				region.center = new Point2D(obj.center.x, obj.center.y);
				region.type = Geometry.GEOREGION;
			}
			return region;
		}
		
		private function toPredefinedMarkerStyle(obj:Object):PredefinedMarkerStyle
		{
			var style:PredefinedMarkerStyle = new PredefinedMarkerStyle();
			style.alpha = obj.alpha;
			style.angle = obj.angle;
			style.color = obj.color;
			style.size = obj.size;
			style.symbol = obj.symbol;
			style.xOffset = obj.xOffset;
			style.yOffset = obj.yOffset;
			if(obj.border)
				style.border = this.toPredefinedLineStyle(obj.border);
			return style;
		}
		
		private function toPredefinedLineStyle(obj:Object):PredefinedLineStyle
		{
			var style:PredefinedLineStyle = new PredefinedLineStyle();
			style.alpha = obj.alpha;
			style.cap = obj.cap;
			style.color = obj.color;
			style.join = obj.join;
			style.symbol = obj.symbol;
			style.miterLimit = obj.miterLimit;
			style.weight = obj.weight;
			style.pattern = obj.pattern;
			
			return style;
			
		}
		
		private function toPredefinedFillStyle(obj:Object):PredefinedFillStyle
		{
			var style:PredefinedFillStyle = new PredefinedFillStyle();
			style.alpha = obj.alpha;
			if(obj.border)
				style.border = this.toPredefinedLineStyle(obj.border);
			style.color = obj.color;
			style.symbol = obj.symbol;
			style.pattern = obj.pattern;
			return style;
		}
		
		private function toFeature(obj:Object):Feature
		{
			var feature:Feature = new Feature();
			var geoObj:Object = obj.geometry;
			var geoType:String = geoObj.type;
			if(geoType == Geometry.GEOPOINT)
			{
//				if(obj.style.type == StyleType.PREDEFINED_MARKER_STYLE)
					feature.style = this.toPredefinedMarkerStyle(obj.style);
				feature.geometry = this.toGeoPoint(geoObj);
			}
			else if(geoType == Geometry.GEOLINE)
			{
				
				feature.style = this.toPredefinedLineStyle(obj.style);
				feature.geometry = this.toGeoLine(geoObj);
			}
			else
			{
//				if(obj.style.type == StyleType.PREDEFINED_FILL_STYLE)
					feature.style = this.toPredefinedFillStyle(obj.style);
				feature.geometry = this.toGeoRegion(geoObj);
			}
			feature.attributes = obj.attributes;
			feature.id = obj.id;
			return feature;
		}
		
	}
}