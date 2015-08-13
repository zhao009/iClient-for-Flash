package com.supermap.web.mapping
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;

//	import mx.graphics.codec.PNGEncoder;
	
	use namespace sm_internal;
	
	public class OfflineStorage
	{
		private var _userRootDirectory:String;
		private const _settingsFileName:String = "settings";
//	private const libraryCachesDir:String = "../Library/Caches/";
		private var _mapName:String;
		private var localFileStream:FileStream;
		private var _scales:Array;
		private var path:String;
		
		public function OfflineStorage(mapName:String = null, userRootDirectory:String = "mapTiles", scales:Array = null)
		{
			this._mapName = mapName;
			this._userRootDirectory =  userRootDirectory;
			this._scales = scales;
		}
		
		public function get scales():Array
		{
			return _scales;
		}

		public function set scales(value:Array):void
		{
			_scales = value;
		}

		public function set mapName(value:String):void
		{
			_mapName = value;
		}

		public function get mapName():String
		{
			return _mapName;
		}

		public function get userRootDirectory():String
		{
			return _userRootDirectory;
		}
		
		public function set userRootDirectory(value:String):void
		{
			_userRootDirectory =  value;
		}
		
			
		public function buildPath(row:Number, col:Number, level:Number, resolution:Number, tileSize:Number):String
		{
			var pathStr:String;
			if(_userRootDirectory)
				pathStr = _userRootDirectory + "/";
			
			if(this._mapName)
				pathStr += this._mapName + "_"
			
			if(this._scales &&　this._scales.length)
				pathStr += tileSize + "ｘ" +　tileSize + "/" + this._scales[level] + "/" +  col + "/" + row;
			else
				pathStr += tileSize + "ｘ" +　tileSize + "/" + resolution + "/" +  col + "/" + row;
			return pathStr;  
		}
			
		sm_internal function putTile(imageLoader:ImageLoader):void
		{
			var imgByteArray:ByteArray = imageLoader.contentLoaderInfo.bytes;
			if(imgByteArray)
			{
				path = this.getTileInfo(imageLoader);
				
				//保存为png图片格式
				//			var bitmap:Bitmap = imageLoader.content as Bitmap;
				//			var tileBMD:BitmapData = bitmap.bitmapData;
				//			var pngenc:PNGEncoder = new PNGEncoder(); 
				//			var imgByteArray:ByteArray = pngenc.encode(tileBMD);
				
				//保存为二进制格式（loader的二进制格式）
				
				var localFile:File = File.documentsDirectory.resolvePath(path);
				localFileStream = new FileStream();
				localFileStream.open(localFile, FileMode.WRITE);
				localFileStream.writeBytes(imgByteArray);
				localFileStream.close();
				path = null;
			}
				
		}
		
		private function getTileInfo(imageLoader:ImageLoader):String
		{
			var tileInfos:Array = imageLoader.id.split("_");
			var tileSize:Number = tileInfos[0];
			var tileLevel:Number = tileInfos[1];
			var tileResolution:Number = tileInfos[2];
			var tileCol:Number = tileInfos[3];
			var tileRow:Number = tileInfos[4];
			
			return buildPath(tileRow, tileCol, tileLevel, tileResolution, tileSize);
			
		}
		
		
		sm_internal function getTile(imageLoader:ImageLoader):ByteArray
		{
			path = this.getTileInfo(imageLoader);
			var localFile:File = File.documentsDirectory.resolvePath(path);
			
			var tileBytes:ByteArray = null;
			if(localFile.exists)
			{
				localFileStream = new FileStream();
				localFileStream.open(localFile, FileMode.READ);
				tileBytes = new ByteArray();
				localFileStream.readBytes(tileBytes, 0, localFileStream.bytesAvailable);
				localFileStream.close();
			}
			return tileBytes;
			
		}
		
		sm_internal function get settingsFileName():String
		{
			return _settingsFileName;
		}
		
		/**
		 * 针对iserver6服务图层提供离线加载支持
		 */
		sm_internal function putSettings(bounds:Rectangle2D, wkid:int, unit:String, datumAxis:Number, origin:Point2D, dpi:Number):void
		{
			var str:String = "bounds:" + bounds.toString() + "\n" +
				"wkid:" + wkid + "\n" +
				"unit:" + unit + "\n" +
				"datumAxis:" + datumAxis + "\n" +
				"origin:" + origin.toString() + "\n" +
				"dpi:" + dpi;
			
			var localSettingsFile:File = File.documentsDirectory.resolvePath(_userRootDirectory + "/" + _settingsFileName);
			var fileStream:FileStream = new FileStream();
			fileStream.open(localSettingsFile, FileMode.WRITE);
			fileStream.writeUTFBytes(str);//需要加密
			fileStream.close();
		}
		
		sm_internal function putXMLSettings(xml:XML):void
		{
			var localSettingsFile:File = File.documentsDirectory.resolvePath(_userRootDirectory + "/" + _settingsFileName);
			var fileStream:FileStream = new FileStream();
			fileStream.open(localSettingsFile, FileMode.WRITE);
			fileStream.writeUTFBytes(xml.toXMLString());//需要加密
			fileStream.close();
		}
		
		sm_internal function getXMLSettings():XML
		{
			var xml:XML;
			var file:File = File.documentsDirectory.resolvePath(_userRootDirectory + "/" + _settingsFileName);
			if(file.exists)
			{
				var str:String;
				var stream:FileStream = new FileStream();
				stream.open(file,FileMode.READ);
				str = stream.readUTFBytes(stream.bytesAvailable);
				stream.close();
				xml = XML(str);
				return xml;
			}
			return null;
		}
		
		sm_internal function getSettings():Object
		{
			var settings:Object = {};
			var file:File = File.documentsDirectory.resolvePath(_userRootDirectory + "/" + _settingsFileName);
			if(file.exists)
			{
				var str:String;
				var stream:FileStream = new FileStream();
				stream.open(file,FileMode.READ);
				str = stream.readUTFBytes(stream.bytesAvailable);
				stream.close();
				var ary:Array = str.split("\n");
				for(var i:int = 0; i < ary.length; i++)
				{
					var item:String = ary[i];
					var aryItem:Array = item.split(":") as Array;
					if(item.indexOf("bounds") != -1)
						settings.bounds = aryItem[1];
					if(item.indexOf("wkid") != -1)
						settings.wkid = aryItem[1];
					if(item.indexOf("unit") != -1)
						settings.unit = aryItem[1];
					if(item.indexOf("datumAxis") != -1)
						settings.datumAxis = aryItem[1];
					if(item.indexOf("origin") != -1)
						settings.origin = aryItem[1];
					if(item.indexOf("dpi") != -1)
						settings.dpi = aryItem[1];
				}
				return settings;
			}
			return null;
		}
		
		public function clear():void
		{
			var localFile:File = File.documentsDirectory.resolvePath(_userRootDirectory);
			localFile.deleteDirectory(true);
		}
		
	}
}