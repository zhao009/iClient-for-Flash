package com.supermap.web.utils
{
	import com.supermap.web.core.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.mapping.supportClasses.*;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class TileUtil
	{
		public function TileUtil()
		{
		}
		
		public static function getContainingTileCoords(tileSize:int, origin:Point2D, point:Point2D, resolution:Number, isStartRowAndCol:Boolean) : Coords
		{
			if (isNaN(tileSize) || origin == null || point == null || isNaN(resolution) == true)
			{
				return null;
			}
			
			//转换为地理坐标系下宽度和高度
			var tSize:Number = tileSize * resolution;
			
			//求出tile的位置（行，列）
			var tempCol:* = (point.x - origin.x) / tSize;
			//计算行
			var tempRow:* = (origin.y - point.y) / tSize; 
			
			if(isStartRowAndCol)
			{
				tempCol = Math.floor(tempCol);
				tempRow = Math.floor(tempRow);
			}
			else
			{
				if(tempCol is int)
				{
					tempCol = tempCol - 1;
				}
				else
				{
					tempCol = Math.floor(tempCol);
				}
				if(tempRow is int)
				{
					tempRow = tempRow - 1;
				}
				else		
				{
					tempRow = Math.floor(tempRow);
				}
			}
			
			//定义行列参数
			var col:Number = tempCol;
			var row:Number = tempRow;
			
			return new Coords(row, col);
		}
		
		public static function getCandidateTileInfo(scrollRectX:Number, scrollRectY:Number, tileSize:int, origin:Point2D, bounds:Rectangle2D, resolution:Number = NaN, level:int = -1) : CandidateTileInfo
		{
			if (isNaN(tileSize) || origin == null　|| bounds == null || isNaN(resolution))
			{
				return null;
			}

			var tile:Tile = getContainingTile(scrollRectX, scrollRectY, tileSize, origin, new Point2D(bounds.left, bounds.top), resolution);
			return new CandidateTileInfo(tile, resolution, bounds, level);
		}
		
		public static function getClosestResolutionAndLevel(screenWidth:Number, screenHeight:Number, geoWidth:Number, geoHeight:Number, resolutions:Array) : Object
		{

			var closest:Object = new Object();
//			var widthRatio:Number = map.width / tileSize;
//			var heightRatio:Number = map.height / tileSize;
			var new_offset:Number = NaN;
			var old_offset:Number = -1;
			if(resolutions != null)
			{
				var i:int = 0;
				var length:Number = resolutions.length;
				while (i < length)
				{				
					var resolution:Number = resolutions[i];
					new_offset = geoWidth > geoHeight ? (Math.abs(geoHeight - screenHeight * resolution)) : (Math.abs(geoWidth - screenWidth * resolution));
					if(old_offset < 0)
					{
						old_offset = new_offset;
					}
					if (new_offset <= old_offset)
					{
						closest.resolution = resolution;
						closest.level = i;
						old_offset = new_offset;
					}
					else
					{
						break;
					}
					i++;
				}
			}
			else
			{
				closest.resolution = Math.max(geoWidth / screenWidth, geoHeight / screenHeight);
				closest.level = -1;
			}
			
			return closest;
		}
		
		private static function getContainingTile(scrollRectX:Number, scrollRectY:Number, tileSize:int, origin:Point2D, point:Point2D, resolution:Number) : Tile
		{		
			var tileGeoWidth:Number = tileSize * resolution;
			var tileGeoHeight:Number = tileSize * resolution;
			var row:int = Math.floor((origin.y - point.y) / tileGeoHeight);
			var col:int = Math.floor((point.x - origin.x) / tileGeoWidth);
			var geoX:* = origin.x + col * tileGeoWidth;
			var geoY:* = origin.y - row * tileGeoHeight;
			var offsetX:* = Math.floor(Math.abs((point.x - geoX) * tileSize / tileGeoWidth)) - scrollRectX;
			var offsetY:* = Math.floor(Math.abs((point.y - geoY) * tileSize / tileGeoHeight)) - scrollRectY;
			return new Tile(new Coords(row, col), point, new Point2D(offsetX, offsetY));
		}
	}
}