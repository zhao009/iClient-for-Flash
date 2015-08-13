package com.supermap.web.utils
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.mapping.Map;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * ${iServer6_GeoUtil_Title} 
	 * 
	 */	
	public class GeoUtil extends Object
	{
		/**
		 * @private 
		 * 
		 */	
		public function GeoUtil()
		{
		}
		
		/**
		 * @private 
		 * 
		 */	
		public static function Rect2DToRect(extent:Rectangle2D, map:Map):Rectangle
		{
			var bottomLeft:Point = map.mapToScreen(extent.bottomLeft);
			var topRight:Point = map.mapToScreen(extent.topRight);
			var rectWidth:Number = topRight.x - bottomLeft.x;
			var rectHeight:Number = bottomLeft.y - topRight.y;
			return new Rectangle(bottomLeft.x, topRight.y, rectWidth, rectHeight);
		}
		
		/**
		 * @private 
		 * 
		 */	
		public static function RectToRect2D(rect:Rectangle,map:Map):Rectangle2D
		{
			var lTP:Point2D = map.screenToMap(rect.topLeft);
			var rBP:Point2D = map.screenToMap(new Point(rect.x+rect.width, rect.y+rect.height));
			return new Rectangle2D(lTP.x, rBP.y, rBP.x, lTP.y);
		}
		
		/**
		 * @private 
		 * 
		 */	
		public static function calcArea(arrOfMapPoints:Array):Number
		{
			var PtEnd:Point2D = null;
			var PtStart:Point2D = null;
			var area:Number = 0;
			var len:int = arrOfMapPoints.length;
			var leng:int = len - 1;
			var i:int = 0;
			while (i < len)
			{		
				PtEnd = arrOfMapPoints[leng];
				PtStart = arrOfMapPoints[i];
				area += PtEnd.x * PtStart.y - PtStart.x * PtEnd.y;
				leng = i;
				i++;
			}
			area *= 0.5;
			return area;
		}
		/**
		 * @private 
		 * 
		 */	
		public static function calcCentroidAndArea(points:Array):Object
		{
			if(points == null || !points.length)
			{
				return null;
			}
			var i:int = 0;
			var j:int = 0;
			var ptFir:Point2D = null;
			var ptCon:Point2D = null;
			var k:Number = NaN;
			var l:Number = NaN;
			var m:Number = NaN;
			var p:Number = NaN;
			var q:Number = NaN;
			var length:int = points.length;
			var areaNum:Number = 0;
			var xNum:Number = 0;
			var yNum:Number = 0;
			i = length - 1;
			j = 0;
			while (j < length)
			{
				
				ptFir = points[i] as Point2D;
				ptCon = points[j] as Point2D;
				k = ptFir.x;
				l = ptFir.y;
				m = ptCon.x;
				p = ptCon.y;
				q = k * p - m * l;
				areaNum += q;
				xNum += (k + m) * q;
				yNum += (l + p) * q;
				i = j;
				j++;
			}
			areaNum = areaNum * 0.5;
			xNum /= (6 * areaNum);
			yNum /= (6 * areaNum);
			return {x:xNum, y:yNum, area:areaNum};
		}
		/**
		 * @private 
		 * 
		 */	
		public static function isClockwise(arrOfMapPoints:Array) : Boolean
		{
			return calcArea(arrOfMapPoints) <= 0;
		}
		/**
		 * ${iServer6_GeoUtil_method_filterPointsByRegion_D}
		 * @param region ${iServer6_GeoUtil_method_filterPointsByRegion_param_region}
		 * @param points ${iServer6_GeoUtil_method_filterPointsByRegion_param_points}
		 * @param partsIndexes ${iServer6_GeoUtil_method_filterPointsByRegion_param_partsIndexes}
		 * @param remainPoints ${iServer6_GeoUtil_method_filterPointsByRegion_param_remainPoints}
		 * @return ${iServer6_GeoUtil_method_filterPointsByRegion_retrun}
		 * 
		 */
		public static function filterPointsByRegion(region:GeoRegion, points:Array, partsIndexes:Array = null, remainPoints:Array = null):Array
		{
			var result:Array = [];
			var pointsInBounds:Array = [];
			if(points == null || points.length < 0)
			{
				return result;
			}
			var points2:Array = points.concat();
			//过虑bounds以外的点
			for each(var point:GeoPoint in points2)
			{
				var rectangle2D:Rectangle2D = region.bounds;
				if(rectangle2D.contains(point.x, point.y))
				{
					pointsInBounds.push(point);
				}
			}
			var part:Array;
			if(partsIndexes != null && partsIndexes.length >0)
			{
				for(var j:int = 0; j < partsIndexes.length; j++)
				{
					part = region.parts[partsIndexes[j]];
					for each(var p:GeoPoint in pointsInBounds)
					{
						if(contains(part, p.x, p.y))
						{
							result.push(p);
						}
					}
				}
			}
			else
			{
				for(var i:int = 0; i < region.parts.length; i++)
				{
					part = region.parts[i];
					for each(var p2:GeoPoint in pointsInBounds)
					{
						if(contains(part, p2.x, p2.y))
						{
							result.push(p2);
						}
					}
				}
			}
			//计算剩余点
			if(remainPoints != null)
			{
				remainPoints.length = 0;
				for(var k:int = 0; k < points2.length; k++)
				{
					var isIncloude:Boolean = false;
					for(var m:int = 0; m < result.length; m++)
					{
						if(points2[k] == result[m])
						{
							isIncloude = true;
							break;
						}
					}
					if(!isIncloude)
					{
						remainPoints.push(points2[k]);
					}
				}
			}
			return result;
		}
		//对点是否在多边形内进行判断，适合任意的多边形
		/**
		 * ${iServer6_GeoUtil_method_contains_D} 
		 * @param arrOfMapPoints ${iServer6_GeoUtil_method_contains_param_arrOfMapPoints}
		 * @param px ${iServer6_GeoUtil_method_contains_param_px}
		 * @param py ${iServer6_GeoUtil_method_contains_param_py}
		 * @return ${iServer6_GeoUtil_method_contains_return}
		 * 
		 */		
		public static function contains(arrOfMapPoints:Array, px:Number, py:Number):Boolean
		{
			if(arrOfMapPoints == null || !arrOfMapPoints.length || (arrOfMapPoints.length < 3))
			{
				return false;
			}
			var pValue:Number = NaN;
			var i:int = 0;
			var j:int = 0;
			
			var yValue:Number = NaN;
			var m:int = 0;
			var n:int = 0;
			
			var iPointX:Number = NaN;
			var iPointY:Number = NaN;
			var JPointX:Number = NaN;
			var JPointY:Number = NaN;
			
			var k:int = 0;
			var p:int = 0;
			
			yValue = arrOfMapPoints[0].y - arrOfMapPoints[(arrOfMapPoints.length - 1)].y;
			if (yValue < 0)
			{
				p = 1;
			}
			else if (yValue > 0)
			{
				p = 0;
			}
			else
			{
				m = arrOfMapPoints.length - 2;
				n = m + 1;
				while (arrOfMapPoints[m].y == arrOfMapPoints[n].y)
				{					
					m--;
					n--;
					if (m == 0)
					{
						return true;
					}
				}
				yValue = arrOfMapPoints[n].y - arrOfMapPoints[m].y;
				if (yValue < 0)
				{
					p = 1;
				}
				else if (yValue > 0)
				{
					p = 0;
				}
			}
			
			
			//使多边形封闭
			var length:int = arrOfMapPoints.length;
			i = 0;
			j = length - 1;
			while (i < length)
			{		
				iPointX = arrOfMapPoints[j].x;
				iPointY = arrOfMapPoints[j].y;
				JPointX = arrOfMapPoints[i].x;
				JPointY = arrOfMapPoints[i].y;
				if (py > iPointY)
				{
					if (py < JPointY)
					{
						pValue = (py - iPointY) * (JPointX - iPointX) / (JPointY - iPointY) + iPointX;
						if (px < pValue)
						{
							k++;
						}
						else if (px == pValue)
						{
							return true;
						}
					}
					else if (py == JPointY)
					{
						p = 0;
					}
				}
				else if (py < iPointY)
				{
					if (py > JPointY)
					{
						pValue = (py - iPointY) * (JPointX - iPointX) / (JPointY - iPointY) + iPointX;
						if (px < pValue)
						{
							k++;
						}
						else if (px == pValue)
						{
							return true;
						}
					}
					else if (py == JPointY)
					{
						p = 1;
					}
				}
				else
				{
					if (px == iPointX)
					{
						return true;
					}
					if (py < JPointY)
					{
						if (p != 1)
						{
							if (px < iPointX)
							{
								k++;
							}
						}
					}
					else if (py > JPointY)
					{
						if (p > 0)
						{
							if (px < iPointX)
							{
								k++;
							}
						}
					}
					else
					{
						if (px > iPointX && px <= JPointX)
						{
							return true;
						}
						if (px < iPointX && px >= JPointX)
						{
							return true;
						}
					}
				}
				j = i;
				i++;
			}
			if (k % 2 != 0)
			{
				return true;
			}
			return false;
		}		
		/**
		 * @private 
		 * 用矩形对多边形（支持多面的情况）进行裁剪
		 * @param geoRegion 待裁剪的多边形
		 * @param rect 作为裁剪标准的bounds
		 * return 返回裁剪后的多边形，没有交集则为null
		 */	
		public static function clipGeoRegionRect(geoRegion:GeoRegion,rect:Rectangle2D):GeoRegion
		{
			var geoRegionResult:GeoRegion = null;
			//图形在矩形内部直接返回
			//当是一个点的时候这里会判定为false，晕死
			if(rect.containsRect(geoRegion.bounds))
			{
				return geoRegion;
			}
			for(var i:int = 0;i<geoRegion.partCount;i++)
			{
				//取每一个单独的面
				var pointArray:Array = geoRegion.parts[i];
				var geoR:GeoRegion = new GeoRegion();
				//如果少于三个点返回他本来的值，这里必须排除点和线的情况
				if(pointArray.length<3)
				{
					return geoRegion;
				}
				geoR.addPart(pointArray);
				//如果矩形包含了面，则添加进去
				if(rect.containsRect(geoR.bounds))
				{
					if(!geoRegionResult)
					{
						geoRegionResult = new GeoRegion();
					}
					geoRegionResult.addPart(pointArray);
				}
				//否则进行裁剪，
				//如果面包含了矩形，也在这里处理，没找到合适的方法来判定
				else
				{
					//将矩形的四个点取出根据面的bounds计算出一个能够延长到面的bounds边缘的四条线，给后面线线求交提供基础
					var intersectLines:Array = getIntersectLineArray(rect,geoR.bounds);
					//
					var resultPoints:Array = pointArray;
					//总共四条边界，按照顺时针对面进行裁剪
					for(var j:int = 0;j<intersectLines.length;j++)
					{
						pointArray = resultPoints;
						resultPoints = null;
						resultPoints = new Array();
						var geoLine:GeoLine = intersectLines[j] as GeoLine;
						for(var k:int = 0;k<pointArray.length-1;k++)
						{
							var a1:Point2D = pointArray[k] as Point2D;
							var a2:Point2D = pointArray[k+1] as Point2D;
							var b1:Point2D = (geoLine.parts[0] as Array)[0] as Point2D;
							var b2:Point2D = (geoLine.parts[0] as Array)[1] as Point2D;
							var obj:Object = lineIntersection(a1,a2,b1,b2);
							//先看线段的起始点是否在矩形内部，在的话存入
							if((j==0) &&  a1.x>=rect.left)
							{
								resultPoints.push(a1);
							}
							else if((j==1) &&  a1.y<=rect.top)
							{
								resultPoints.push(a1);
							}
							else if((j==2) &&  a1.x<=rect.right)
							{
								resultPoints.push(a1);
							}
							else if((j==3) &&  a1.y>=rect.bottom)
							{
								resultPoints.push(a1);
							}
							
							//有如果有交点，则将交点存入
							if(obj is Point2D)
							{
								resultPoints.push(obj as Point2D);
							}
							//没有交点不作处理
							else
							{
								
							}
						}
						//最后的时候需要把第一个点负值到最后一个点
						if(resultPoints.length>0)
						{
							resultPoints.push(resultPoints[0]);
						}
					}
					if(!geoRegionResult && resultPoints.length>2)
					{
						
						geoRegionResult = new GeoRegion();
						
					}
					//一个面至少需要三个点
					if(resultPoints.length>2)
					{
						geoRegionResult.addPart(resultPoints);
					}
					
				}
				
			}
			return geoRegionResult;
		}
		
		/**
		 * @private 
		 * 根据待裁剪的多边形的bounds范围将矩形的bounds四条边进行扩展出四条裁剪标准边界
		 * @param rect1 矩形的bounds
		 * @param rect2  待裁剪多边形的bounds
		 * return 返回左、上、右、下四条扩展后的裁剪边界数组
		 */	
		private static function getIntersectLineArray(rect1:Rectangle2D,rect2:Rectangle2D):Array
		{
			//左边缘的边
			var leftLine:GeoLine = new GeoLine();
			//左边缘的边的下面的点的x保留自身，y取最小的
			var leftLineBottomPoint:Point2D = new Point2D(rect1.left,rect1.bottom<rect2.bottom?rect1.bottom:rect2.bottom);
			//左边缘的边的上面的点的x保留自身，y取最大的
			var leftLineTopPoint:Point2D = new Point2D(rect1.left,rect1.top>rect2.top?rect1.top:rect2.top);
			//按照顺时针添加这两个点
			leftLine.addPart([leftLineBottomPoint,leftLineTopPoint]);
			
			//上边缘的边
			var topLine:GeoLine = new GeoLine();
			//上边缘的边的左边的点的x取最小值，y保留自身
			var topLineLeftPoint:Point2D = new Point2D(rect1.left<rect2.left?rect1.left:rect2.left,rect1.top);
			//上边缘的边的右边的点的x取最大值，y保留自身
			var topLineRightPoint:Point2D = new Point2D(rect1.right>rect2.right?rect1.right:rect2.right,rect1.top);
			//按照顺时针添加这两个点
			topLine.addPart([topLineLeftPoint,topLineRightPoint]);
			
			var rightLine:GeoLine = new GeoLine();
			var rightLineTopPoint:Point2D = new Point2D(rect1.right,rect1.top>rect2.top?rect1.top:rect2.top);
			var rightLineBottomPoint:Point2D = new Point2D(rect1.right,rect1.bottom<rect2.bottom?rect1.bottom:rect2.bottom);
			//按照顺时针添加这两个点
			rightLine.addPart([rightLineTopPoint,rightLineBottomPoint]);
			
			var bottomLine:GeoLine = new GeoLine();
			var bottomLineRightPoint:Point2D = new Point2D(rect1.right>rect2.right?rect1.right:rect2.right,rect1.bottom);
			var bottomLineLeftPoint:Point2D = new Point2D(rect1.left<rect2.left?rect1.left:rect2.left,rect1.bottom);
			//按照顺时针添加这两个点
			bottomLine.addPart([bottomLineRightPoint,bottomLineLeftPoint]);
			
			return [leftLine,topLine,rightLine,bottomLine];
			
		}
		/**
		 * @private 
		 * 用矩形对多线（支持多条线的情况）进行裁剪
		 * @param geoLine 待裁剪的线
		 * @param rect 作为裁剪标准的bounds
		 * return 返回裁剪后的多线，没有交集则为null
		 */	
		public static function clipGeoLineRect(geoLine:GeoLine,rect:Rectangle2D):GeoLine
		{
			var geoLineResult:GeoLine = null;
			//循环线，拆分成为单一的线
			for(var i:int = 0;i<geoLine.partCount;i++)
			{
				var pointArray:Array = geoLine.parts[i];
				//将单一的线按照每两个顶点进行组合为一条线段求交
				for(var j:int = 0;j<pointArray.length-1;j++)
				{
					
					var point1:Point2D = new Point2D((pointArray[j] as Point2D).x,(pointArray[j] as Point2D).y);
					var point2:Point2D = new Point2D((pointArray[j+1] as Point2D).x,(pointArray[j+1] as Point2D).y);
					
					var array:Array = GeoUtil.clipLineRect(point1,point2,rect);
					//两个交点直接存入
					if(array.length == 2)
					{
						if(!geoLineResult)
						{
							geoLineResult = new GeoLine();
						}
						geoLineResult.addPart(array);
					}
					//一个交点，需要保留内部的点
					else if(array.length == 1)
					{
						//存起始点和相交点
						if(rect.contains(point1.x,point1.y))
						{
							if(!geoLineResult)
							{
								geoLineResult = new GeoLine();
							}
							geoLineResult.addPart([point1,array[0]]);
						}
						//存相交点和结束点
						else if(rect.contains(point2.x,point2.y))
						{
							if(!geoLineResult)
							{
								geoLineResult = new GeoLine();
							}
							geoLineResult.addPart([array[0],point2]);
						}
						//代表交予矩形的顶点，那么就不作处理
						else
						{
						}
					}
					//没有交点有两种情况，在外面或者在里面
					else if(array.length == 0)
					{
						//都在里面，将两个点加进去
						if(rect.contains(point1.x,point1.y) && rect.contains(point2.x,point2.y))
						{
							if(!geoLineResult)
							{
								geoLineResult = new GeoLine();
							}
							geoLineResult.addPart([point1,point2]);
						}
						//都在外面
						else
						{
						}
					}
				}
				
			}
			return geoLineResult;
		}
		
		//用矩形对线段进行裁剪
		/**
		 * @private 
		 * 
		 */	
		public static function clipLineRect(startPt:Point2D, endPt:Point2D, rect:Rectangle2D):Array
		{
			var aryRect:Array = [];
			var lbPoint:Point2D = new Point2D(rect.left, rect.bottom);
			var rtPoint:Point2D = new Point2D(rect.right, rect.top);
			var rbPoint:Point2D = new Point2D(rect.right, rect.bottom);
			var ltPoint:Point2D = new Point2D(rect.left, rect.top);
			
			var aryPoints:Array = [];
			aryPoints.push(lineIntersection(lbPoint, rbPoint, startPt, endPt));
			aryPoints.push(lineIntersection(rbPoint, rtPoint, startPt, endPt));
			aryPoints.push(lineIntersection(rtPoint, ltPoint, startPt, endPt));
			aryPoints.push(lineIntersection(ltPoint, lbPoint, startPt, endPt));
			
			var i:int = 0;
			while (i < aryPoints.length)
			{				
				if (aryPoints[i] is Point2D)
				{
					aryRect.push(aryPoints[i]);
				}
				i++;
			}
			return aryRect;
		}
		
		//判断两条线断是不是有交点
		/**
		 * @private 
		 * 
		 */	
		public static function lineIntersection(a1:Point2D, a2:Point2D, b1:Point2D, b2:Point2D):Object
		{
			var intersectValue:Object = null;
			var k1:Number = NaN;
			var k2:Number = NaN;
			var b:Number = (b2.x - b1.x) * (a1.y - b1.y) - (b2.y - b1.y) * (a1.x - b1.x);
			var a:Number = (a2.x - a1.x) * (a1.y - b1.y) - (a2.y - a1.y) * (a1.x - b1.x);
			var ab:Number = (b2.y - b1.y) * (a2.x - a1.x) - (b2.x - b1.x) * (a2.y - a1.y);
			if (ab != 0)
			{
				k1 = b / ab; 
				k2 = a / ab;
			
				if (k1 >= 0 && k2 <= 1 && k1 <= 1 && k2 >= 0)
				{
					intersectValue = new Point2D(a1.x + k1 * (a2.x - a1.x), a1.y + k1 * (a2.y - a1.y));
				}
				else
				{
					intersectValue = "No Intersection";
				}
			}
			else
			{
				
				if (b == 0 && a == 0)
				{
					var maxy:Number = Math.max(a1.y, a2.y);
					var miny:Number = Math.min(a1.y, a2.y);
					var maxx:Number = Math.max(a1.x, a2.x);
					var minx:Number = Math.min(a1.x, a2.x);
					if(((b1.y >= miny && b1.y <= maxy) || (b2.y >= miny && b2.y <= maxy)) && 
						(b1.x >= minx && b1.x <= maxx) || (b2.x >= minx && b2.x <= maxx))
					{
						intersectValue = "Coincident";//重合
					}
					else
					{
						intersectValue = "Parallel";//平行
					}

				}
				else
				{
					intersectValue = "Parallel";//平行
				}
			}
			return intersectValue;
		}	
		
		/**
		 * ${iServer6_GeoUtil_method_lonLatToMercator_D} 
		 * @param x ${iServer6_GeoUtil_method_lonLatToMercator_param_X}
		 * @param y ${iServer6_GeoUtil_method_lonLatToMercator_param_Y}
		 * @return 
		 * 
		 */		
		public static function lonLatToMercator(x:Number, y:Number):Point2D
		{
			var point:Point2D = new Point2D;
			point.x = x * 20037508.342789/180;
			var tempy:Number = Math.log(Math.tan((90+y)*Math.PI/360))/(Math.PI/180);
			point.y = tempy * 20037508.34789/180;
			return point;
		}
		
		/**
		 * ${iServer6_GeoUtil_method_mercatorToLonLat_D} 
		 * @param x ${iServer6_GeoUtil_method_mercatorToLonLat_param_X}
		 * @param y ${iServer6_GeoUtil_method_mercatorToLonLat_param_Y}
		 * @return 
		 * 
		 */		
		public static function mercatorToLonLat(x:Number, y:Number):Point2D
		{
			var point:Point2D = new Point2D;
			point.x = x / 20037508.342789*180;
			var tempy:Number = y/20037508.342789*180;
			point.y = 180/Math.PI*(2*Math.atan(Math.exp(tempy*Math.PI/180))-Math.PI/2);
			return point;
		}
		
		public static function regionIntersection(region1:GeoRegion, region2:GeoRegion):Boolean
		{
			var iCount1:int = region1.partCount;
			var iCount2:int = region2.partCount;
			
			for(var i:int=0; i<iCount1; i++)
			{
				var arr1:Array = region1.parts[i];
				for(var j:int=0; j<iCount2; j++)
				{
					var arr2:Array = region2.parts[j];
					if(isPolygonCrossPolygon(arr1,arr2))
						return true;
				}
			}
			return false;
		}
		
		private static function isPolygonCrossPolygon(polygon1:Array,polygon2:Array):Boolean
		{
			var iCount1:int = polygon1.length;
			var iCount2:int = polygon2.length;
			
			var p1:Point2D,p2:Point2D,p3:Point2D,p4:Point2D;
			//遍历part中的每对点
			for (var i:int=0;i<iCount1;i++)
			{
				p1 = polygon1[i];
				if (i==(iCount1-1))
				{
					p2=polygon1[0];
				}
				else
				{
					p2=polygon1[i+1];
					
				}
				for (var j:int=0;j<iCount2;j++)
				{
					p3=polygon2[j];
					if (j==(iCount2-1))
					{
						
						p4=polygon2[0];
					}
					else
					{
						p4=polygon2[j+1];
						
					}
					//判断两条
					if (isLineCrossLine(p1,p2,p3,p4))
						return true;
				}
			}
			//判断多边形是否为包含关系
			if (IsPolygonInPolygon(polygon1,polygon2) || IsPolygonInPolygon(polygon2,polygon1))
				return true;
			return false;
		}
		
		//判断两条线是否相交
		private static function isLineCrossLine(p11:Point2D,p12:Point2D,p21:Point2D,p22:Point2D):Boolean
		{
			var area1:Number,area2:Number;
			var minx:Number,miny:Number,maxx:Number,maxy:Number;
			var minx1:Number,miny1:Number,maxx1:Number,maxy1:Number;
			
			//获取p11p12线条的最大/小XY，即外接矩形
			if(p11.x>p12.x)
			{
				minx = p12.x;
				maxx = p11.x;
			}
			else
			{
				minx = p11.x;
				maxx = p12.x;
			}
			if(p11.y>p12.y)
			{
				miny = p12.y;
				maxy = p11.y;
			}
			else
			{
				miny = p11.y;
				maxy = p12.y;
			}
			
			//获取p21p22线段的最大/小XY，即外接矩形
			if(p21.x>p22.x)
			{
				minx1 = p22.x;
				maxx1 = p21.x;
			}
			else
			{
				minx1 = p21.x;
				maxx1 = p22.x;
			}
			if(p21.y>p22.y)
			{
				miny1 = p22.y;
				maxy1 = p21.y;
			}
			else
			{
				miny1 = p21.y;
				maxy1 = p22.y;
			}
			
			//初步以线段外接矩形判断两条线是否相交
			if(maxx1<=minx || minx1>=maxx || maxy1<=miny || miny1>=maxy)
				return false;
			
			//计算线段1起点与线段2围成的泰森三角形面积
			area1 = TRIANGLE_AREA(p11,p21,p22);
			//计算线段1止点与线段2围成的泰森三角形面积
			area2 = TRIANGLE_AREA(p12,p21,p22);
			//若线段相接或包含，判为不相交
			if(area1==0 || area2==0)
				return false;
			//若两面积同导,则为同侧,同侧必不相交
			if(area1>0 && area2>0 || area1<0 && area2<0)
				return false;
			
			//计算线段2起点与线段1围成的泰森三角形面积
			area1 = TRIANGLE_AREA(p21,p11,p12);
			//计算线段2止点与线段1围成的泰森三角形面积
			area2 = TRIANGLE_AREA(p22,p11,p12);
			//若线段相接或包含，判为不相交
			if(area1==0 || area2==0)
				return false;
			//若两面积同导,则为同侧,同侧必不相交
			if(area1>0 && area2>0 || area1<0 && area2<0)
				return false;
			return true;
		}
		
		private static function TRIANGLE_AREA(p:Point2D,p1:Point2D,p2:Point2D):Number
		{
			return (p.x-p1.x)*(p2.y-p1.y)-(p.y-p1.y)*(p2.x-p1.x)/*辛普森三角*/
		}
		
		private static function IsPolygonInPolygon(polygon1:Array,polygon2:Array):Boolean
		{
			var iCount1:int = polygon1.length;
			var iCount2:int = polygon2.length;
			
			var p1:Point2D= polygon1[0];
			var p2:Point2D= polygon1[iCount1-1];
			//非封闭状态下的拆线包含于polygon2，且最后一条线段也包含于polygon2，才认为两个为包含关系
			return IsPolylineInPolygon(polygon1,polygon2) && IsLineInPolygon(p1,p2,polygon2);
		}
		
		//非封闭状态下的拆线是否包含在面内
		private static function IsPolylineInPolygon(pPolyline1:Array,pPolygon2:Array):Boolean
		{
			var iCount1:int = pPolyline1.length;
			var iCount2:int = pPolygon2.length;
			
			var p1:Point2D,p2:Point2D;
			for (var i:int=0;i<iCount1-1;i++)
			{
				p1=pPolyline1[i];
				p2=pPolyline1[i+1];
				if (!IsLineInPolygon(p1,p2,pPolygon2))
					return false;
			}
			return true;
		}
		
		private static function IsLineInPolygon(pt1:Point2D,pt2:Point2D,pPolygon1:Array):Boolean
		{
			//判断线段两点是否均包含在多边形内
			if (!PointInPolygon(pPolygon1,pt1.x,pt1.y) || !PointInPolygon(pPolygon1,pt2.x,pt2.y))
				return false;
			
			var p3:Point2D,p4:Point2D;
			var iCount1:int = pPolygon1.length;
			//判断线段是否与多边形的某个边界有相交，若有，则认为不包含
			for (var i:int=0;i<iCount1;i++)
			{
				p3 =pPolygon1[i];
				if (i==iCount1-1)
					p4=pPolygon1[0];
				else
					p4=pPolygon1[i+1];
				if (isLineCrossLine(pt1,pt2,p3,p4))
					return false;
			}
			return true;
		}
		
		//判断点是否在多边形内
		private static function PointInPolygon(pt:Array,x:Number,y:Number):Boolean
		{	
			var iCount:int = pt.length;
			
			var k:int = 0;
			//遍历组成多边形的每个折线与点所组成的三角形的导向
			for(var i:int = 0;i < iCount; i++)
			{
				if(i == iCount - 1)
				{
					if(TestPoint (x,y,pt[0].x,pt[0].y,pt[i].x,pt[i].y))	
						k++;
				}
				else
				{
					if(TestPoint (x,y,pt[i].x,pt[i].y,pt[i+1].x,pt[i+1].y))	
						k++;
				}
			}
			return k != 0 && (k & 0x1) != 0; 
		}
		
		private static function TestPoint(x:Number,y:Number,x1:Number,y1:Number,x2:Number,y2:Number):Boolean
		{
			var d:Number = (y2 - y1) * (x1 - x) + (y - y1) * (x2 - x1);
			if(y2 > y1)
				return y >= y1 && y < y2 && d >= 0.0;
			else
				return y >= y2 && y < y1 && d < 0.0;
		}
	}
	
}