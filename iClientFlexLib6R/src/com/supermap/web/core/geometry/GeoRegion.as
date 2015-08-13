package com.supermap.web.core.geometry
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.GeoUtil;
	
	import flash.events.Event;
	
	use namespace sm_internal;
	
	/**
	 * ${core_GeoRegion_Event_geometryChange_D}
	 */	
	[Event(name="geometryChange", type="flash.events.Event")]
	[DefaultProperty("parts")]
	/**
	 * ${core_GeoRegion_Title}.
	 * <p>${core_GeoRegion_Description}</p> 
	 * 
	 * 
	 */	
	public class GeoRegion extends Geometry 
	{
		
		private var _partCount:int;
		private var _parts:Array;
		private var _bounds:Rectangle2D;
		
		private static var SMALL_VALUE:Number = 1.0E-10;
		
		/**
		 * ${core_GeoRegion_constructor_None_D} 
		 * 
		 */		
		public function GeoRegion()
		{
			_parts = new Array();
			
		}
		
		override public function get center():Point2D
		{
			if(!_center)
			{
				_center = calcPolygonCenter();
			}
			return _center;
		}
		sm_internal function setCenter(vaule:Point2D):void
		{
			_center = vaule;
		}
		private function calcPolygonCenter():Point2D
		{
			var point2Ds:Array = [];
			var center:Point2D = new Point2D();
			
			if (this._parts == null)
			{
				return center;
			}
			var allParts:Array = [];
			
			var point2DCount:int = 0;
			for each (var item:Array in this._parts)
			{
				for each (var item1:Point2D in item)
				{
					point2Ds.push(item1);
				}
				allParts[point2DCount] = item.length;
				point2DCount++;
			}
			
			var i:int;
			var crossNum:int;
			var totalPoints:int;
			var x1:Number;
			var y1:Number;
			var x2:Number;
			var y2:Number;
			var x3:Number;
			var y3:Number;
			var x4:Number;
			var y4:Number;
			var dist:Number;
			var maxLength:Number;
			var maxSegmentNo:int;
			var sign1:Number = 0;
			var sign2:Number = 0;
			var bAddRepPoint:Boolean;
			
			var n:int = 0;
			var m:int = 0;
			var lPointCount:int = 0;
			var yMax:Number;
			var yMin:Number;
			
			var polyCountsMax:int = allParts[0];
			var flag:int = 0;
			for (n = 0; n < allParts.length; n++)
			{
				if (polyCountsMax <= allParts[n])
				{
					polyCountsMax = allParts[n];
					flag = n;
				}
			}
			
			for (n = 0; n < flag; n++)
			{
				lPointCount += allParts[n];
			}
			
			yMax = (point2Ds[lPointCount] as Point2D).y;
			yMin = (point2Ds[lPointCount] as Point2D).y;
			
			for (m = 0; m < allParts[flag]; m++)
			{
				if (yMax <= (point2Ds[lPointCount + m] as Point2D).y)
				{
					yMax = (point2Ds[lPointCount + m] as Point2D).y;
				}
				if (yMin >= (point2Ds[lPointCount + m] as Point2D).y)
				{
					yMin = (point2Ds[lPointCount + m] as Point2D).y;
				}
			}
			
			y1 = (yMax + yMin) / 2;
			y2 = y1;
			x1 = bounds.bottomLeft.x - Math.abs(bounds.topRight.x - bounds.bottomLeft.x);
			x2 = bounds.topRight.x + Math.abs(bounds.topRight.x - bounds.bottomLeft.x);
			
			var pntResult:Point2D = new Point2D();
			totalPoints = 0;
			crossNum = 0;
			
			var pSPointX:Array = new Array();
			
			var y0:Number = 0;
			
			for (var n1:int = 0; n1 < allParts.length; n1++)
			{
				var crossOfN:int = 0;
				
				for (var j1:int = 1; j1 < allParts[n1]; j1++)
				{
					x3 = (point2Ds[totalPoints + j1 - 1] as Point2D).x;
					y3 = (point2Ds[totalPoints + j1 - 1] as Point2D).y;
					x4 = (point2Ds[totalPoints + j1] as Point2D).x;
					y4 = (point2Ds[totalPoints + j1] as Point2D).y;
					
					if (((y4 - y3) > SMALL_VALUE) || ((y4 - y3) < -SMALL_VALUE))
					{
						bAddRepPoint = true;
						
						if (((y3 - y1) > -SMALL_VALUE) && ((y3 - y1) < SMALL_VALUE))
						{
							y1 = y3;
							y2 = y1;
						}
						else if (((y4 - y1) > -SMALL_VALUE) && ((y4 - y1) < SMALL_VALUE))
						{
							y1 = y4;
							y2 = y1;
						}
						
						var nSpy:int = -1;
						if (j1 == 1)
						{
							sign1 = (point2Ds[totalPoints + allParts[n1] - 2] as Point2D).y - (point2Ds[totalPoints] as Point2D).y;
							nSpy = allParts[n1] - 2;
						}
						else
						{
							sign1 = (point2Ds[totalPoints + j1 - 2] as Point2D).y - (point2Ds[totalPoints + j1 - 1] as Point2D).y;
							nSpy = j1 - 2;
						}
						
						sign2 = y4 - y3;
						if (((y3 - y1) > -SMALL_VALUE) && ((y3 - y1) < SMALL_VALUE))
						{
							while ((sign1 > -SMALL_VALUE) && (sign1 < SMALL_VALUE))
							{
								nSpy--;
								if (nSpy < 0)
								{
									nSpy = allParts[n1] - 2;
								}
								sign1 = (point2Ds[totalPoints + nSpy] as Point2D).y - (point2Ds[totalPoints + j1 - 1] as Point2D).y;
							}
							bAddRepPoint = ((sign1 * sign2) > 0);
						}
					}
					else
					{
						bAddRepPoint = false;
					}
					
					if ((bAddRepPoint) && (this.intersectLineSect(x1, y1, x2, y2, x3, y3, x4, y4, pntResult)))
					{
						var tempPointX:Array = new Array();
						var iLength:int = pSPointX.length;
						for each(var tempItem:Number in pSPointX){
							tempPointX.push(tempItem);
						}
						
						pSPointX = tempPointX;
						
						pSPointX[crossNum] = pntResult.x;
						crossOfN++;
						crossNum++;
						
						if (crossOfN > 1 && pSPointX[crossNum - 1] == pSPointX[crossNum - 2] && (y0 - y3) * (y4 - y3) < 0)
						{
							crossNum--;
							crossOfN--;
						}
						y0 = y3;
					}
				}
				
				if (crossNum - 1 >= 0 && crossNum - 1 < pSPointX.length && pSPointX[crossNum - 1] == pSPointX[0])
				{
					y0 = (point2Ds[totalPoints + 1] as Point2D).y;
					y3 = (point2Ds[totalPoints] as Point2D).y;
					y4 = (point2Ds[totalPoints + allParts[n1] - 1] as Point2D).y;
					if ((y0 - y3) * (y4 - y3) < 0)
					{
						crossNum--;
					}
				}
				
				totalPoints = totalPoints + Math.abs(allParts[n1]);
			}
			
			if (((crossNum % 2) == 0) && (crossNum >= 2))
			{
				this.quickSort(pSPointX, 0, (crossNum - 1));
				
				maxLength = -1.7E+308;
				maxSegmentNo = -1;
				for (i = 0; i <= (crossNum / 2 - 1); i++)
				{
					dist = pSPointX[2 * i + 1] - pSPointX[2 * i];
					if (dist > maxLength)
					{
						maxLength = dist;
						maxSegmentNo = i;
					}
				}
				center.x = (pSPointX[2 * maxSegmentNo + 1] + pSPointX[2 * maxSegmentNo]) / 2;
				center.y = y1;
			}
			return center;
		}
		private function intersectLineSect( x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number, x4:Number, 
										   y4:Number, result:Point2D):Boolean
		{
			var flag:Boolean = false;
			var de:Number = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
			
			if (Math.abs(de) > SMALL_VALUE)
			{
				var ub:Number = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / de;
				
				if ((ub > (-SMALL_VALUE)) && ub < (1 + SMALL_VALUE))
				{
					flag = true;
				}
				else
				{
					flag = false;
				}
			}
			else
			{
				flag = false;
			}
			
			if (flag)
			{
				if (Math.abs(x1 - x2) < SMALL_VALUE)
				{
					result.x = x1;
					result.y = ((y3 - y4) * x1 + x3 * y4 - x4 * y3) / (x3 - x4);
				}
				else if (Math.abs(x3 - x4) < SMALL_VALUE)
				{
					result.x = x3;
					result.y = ((x1 - y2) * x3 + x1 * y2 - x2 * y1) / (x1 - x2);
				}
				else if (Math.abs(y1 - y2) < SMALL_VALUE)
				{
					result.y = y1;
					result.x = ((x3 - x4) * y1 + y3 * x4 - y4 * x3) / (y3 - y4);
				}
				else if (Math.abs(y3 - y4) < SMALL_VALUE)
				{
					result.y = y3;
					result.x = ((x1 - x2) * y3 + y1 * x2 - y2 * x1) / (y1 - y2);
				}
				else
				{
					var k1:Number = (y1 - y2) / (x1 - x2);
					var k2:Number = (y3 - y4) / (x3 - x4);
					var b1:Number = (x2 * y1 - y2 * x1) / (x2 - x1);
					var b2:Number = (x4 * y3 - y4 * x3) / (x4 - x3);
					
					result.x = (b2 - b1) / (k1 - k2);
					result.y = (b1 * k2 - b2 * k1) / (k2 - k1);
				}
			}
			return flag;
		}
		private function quickSort(d:Array, nStart:int, nEnd:int):void
		{
			if (nEnd - nStart < 1)
			{
				return;
			}
			
			var dTemp:Number;
			if (nEnd - nStart == 1)
			{
				if (d[nStart] > d[nEnd])
				{
					dTemp = d[nStart];
					d[nStart] = d[nEnd];
					d[nEnd] = dTemp;
				}
				return;
			}
			
			var dPivot:Number = this.median(d, nStart, nEnd);
			
			var nLeft:int;
			var nRight:int;
			nLeft = nStart;
			nRight = nEnd - 1;
			while (nLeft < nRight)
			{
				while (d[++nLeft] < dPivot)
				{
				}
				while (d[--nRight] > dPivot)
				{
				}
				if (nLeft < nRight)
				{
					dTemp = d[nLeft];
					d[nLeft] = d[nRight];
					d[nRight] = dTemp;
				}
			}
			
			d[nEnd - 1] = d[nLeft];
			d[nLeft] = dPivot;
			
			if (nRight > nStart)
			{
				this.quickSort(d, nStart, nRight);
			}
			if (nLeft < nEnd)
			{
				this.quickSort(d, nLeft, nEnd);
			}
		}
		private function median(d:Array, nStart:int , nEnd:int):Number
		{
			var nMid:int = nStart / 2 + nEnd / 2;
			var dTemp:Number;
			
			if (d[nStart] > d[nEnd])
			{
				dTemp = d[nStart];
				d[nStart] = d[nEnd];
				d[nEnd] = dTemp;
			}
			
			if (d[nStart] > d[nMid])
			{
				dTemp = d[nStart];
				d[nStart] = d[nMid];
				d[nMid] = dTemp;
			}
			
			if (d[nMid] > d[nEnd])
			{
				dTemp = d[nMid];
				d[nMid] = d[nEnd];
				d[nEnd] = dTemp;
			}
			
			dTemp = d[nEnd - 1];
			d[nEnd - 1] = d[nMid];
			d[nMid] = dTemp;
			
			return d[nEnd - 1];
		}
		
		/**
		 * ${core_GeoRegion_attribute_partCount_D}.
		 * ${core_GeoRegion_attribute_partCount_remarks_D} 
		 * @see #parts
		 * @return 
		 * 
		 */		
		public function get partCount():int
		{
			return this._parts.length;
		}
		
		/**
		 * @inheritDoc 
		 * @see Geometry
		 * @return 
		 * 
		 */		
		public override function get type():String
		{
			return Geometry.GEOREGION;
		}
		
		/**
		 * @inheritDoc  
		 * @return 
		 * 
		 */		
		public override function get bounds():Rectangle2D
		{
			//如果line有变化要记得把bounds设为null
			if(this._bounds == null)
			{
				var partCount:int = this.partCount;
				
				var left:Number = Number.MAX_VALUE;
				var right:Number = -Number.MAX_VALUE;
				var top:Number = -Number.MAX_VALUE;
				var bottom:Number = Number.MAX_VALUE;
				
				if(partCount < 1) 
				{
					return null;
				}
				else
				{				
					for (var i:int = 0; i < partCount; i++)
					{
						var part:Array = this.getPart(i);
						var point2DCount:int = part.length;
						for (var m:int = 0; m < point2DCount; m++)
						{
							var point2D:Point2D = part[m];
							left = point2D.x < left ? point2D.x : left;
							right = point2D.x > right ? point2D.x : right;
							bottom = point2D.y < bottom ? point2D.y : bottom;
							top = point2D.y > top ? point2D.y : top;
						}
					}
					this._bounds = new Rectangle2D(left, bottom, right, top);				
				}
			}
			
			return this._bounds;		
		}
		
		/**
		 * ${core_GeoRegion_attribute_parts_D}.
		 * <p>${core_GeoRegion_attribute_parts_remarks}</p> 
		 * @see #partCount
		 * 
		 */		
		public function set parts(value:Array):void
		{
			for each(var part:Array in value)
			{
				var number:int = part.length;
				if(number > 2 && !(Point2D(part[0]).equals(Point2D(part[number - 1]))))
				{
					part.push(part[0]);
				}
			}
			_parts = value;
			this._bounds = null;
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));
		}
		
		public function get parts():Array
		{
			return this._parts;
		}
		
		/**
		 * ${core_GeoRegion_method_getPart_D} 
		 * @param index ${core_GeoRegion_method_getPart_param_index}
		 * @return ${core_GeoRegion_method_getPart_return}
		 * 
		 */		
		public function getPart(index:int):Array
		{
			var cloneArr:Array=new Array();
			if(index>-1 && index<this.partCount)
			{
				var ptAry:Array=this._parts[index] as Array;				
				for (var i:int=0; i < ptAry.length; i++)
				{
					cloneArr.push(ptAry[i]);				
				}
			}
			else
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
			return cloneArr ;
		}
		
		/**
		 * ${core_GeoRegion_method_addPart_D} 
		 * @param pts ${core_GeoRegion_method_addPart_param_pts}
		 * @return ${core_GeoRegion_method_addPart_return_int}
		 * 
		 */		
		public function addPart(pts:Array):int
		{
			var ptsLength:int = pts.length;	
			var cloneArr:Array=new Array();
			if(ptsLength > 2)
			{
				var ptStart:Point2D=pts[0];
				var ptEnd:Point2D=pts[ptsLength-1];
				if(ptStart.equals(ptEnd))
				{
					for (var i:int = 0; i < pts.length; i++)
					{
						var point2D:Point2D = pts[i];				
						cloneArr.push(point2D);					
					}			
					this._parts.push(cloneArr);
				}
				else
				{
					//如果起点止点不一致 那么把起点添加到数组的尾部
					pts.push(ptStart);
					for (var j:int = 0; j < pts.length; j++)
					{
						var point2DN:Point2D = pts[j];				
						cloneArr.push(point2DN);					
					}			
					this._parts.push(cloneArr);
					
				}
				
			}
			else
			{
				throw new SmError(SmResource.PART_LENGHT_LESSTHAN_THREE);
			}
			this._bounds = null;
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));
			return this._parts.length - 1;
		}
		
		/**
		 * ${core_GeoRegion_method_insertPart_D} 
		 * @param index ${core_GeoRegion_method_insertPart_param_index}
		 * @param pts ${core_GeoRegion_method_insertPart_param_pts}
		 * @return ${core_GeoRegion_method_insertPart_return}
		 * 
		 */		
		public function insertPart(index:int,pts:Array):Boolean
		{			
			var bolInserPt:Boolean=false;
			var ptCount:int=this._parts.length;
			if(pts.length > 2)
			{
				if(!pts[0].equals(pts[pts.length-1]))
				{
					pts.push(pts[0]);
				}
				if(index<ptCount && index>-1)
				{					
					this._parts.splice(index, 0, pts);
					bolInserPt=true;					
				}
				else if(index == ptCount)
				{
					this._parts.push(pts);
				}
				else
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}	
				
							
			}
			else
			{
				throw new SmError(SmResource.PART_LENGHT_LESSTHAN_THREE);
			}	
			this._bounds = null;
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));
			return bolInserPt;			
		}
		
		/**
		 * ${core_GeoRegion_method_indexOf_D} 
		 * @param pts ${core_GeoRegion_method_indexOf_param_pts}
		 * @return ${core_GeoRegion_method_indexOf_return}
		 * 
		 */		
		public function indexOf(pts:Array):int
		{
			var index:int = -1;
			var bol:Boolean = false;
			if (pts != null)
			{
				var length:int = pts.length;
				var ptCount:int = this.partCount;
				for (var i:int = 0; i < ptCount; i++)
				{					
					var aryPartPts:Array = this._parts[i] as Array;
					var partLength:int = this._parts[i].length;
					if (length == partLength)
					{
						for(var j:int = 0;j<partLength;j++)
						{
							bol = pts[j].equals(aryPartPts[j]);
							if (!bol)
							{
								break;
							}
							if(j == partLength-1)
							{
								index = i;
							}
						}		
					}		
				}
			}
			return index;
		}
		
		/**
		 * ${core_GeoRegion_method_removePart_D} 
		 * @param index ${core_GeoRegion_method_removePart_param_index}
		 * @return ${core_GeoRegion_method_removePart_return}
		 * 
		 */		
		public function removePart(index:int):Boolean
		{
			var bolRemovePart:Boolean;
			var length:int = this._parts.length;
			if(index<length && index>-1){
				
				this._parts.splice(index, 1);
				bolRemovePart=true;		
			}
			else
			{
				bolRemovePart=false;
			}
			this._bounds = null;
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));
			return bolRemovePart;	
		
		}		
		
		/**
		 * ${core_GeoRegion_method_setPart_D} 
		 * @param index ${core_GeoRegion_method_setPart_param_index}
		 * @param pts ${core_GeoRegion_method_setPart_param_pts}
		 * @return ${core_GeoRegion_method_setPart_return}
		 * 
		 */		
		public function setPart(index:int, pts:Array):Boolean
		{
			var count:int = this._parts.length;
			var point2DCount:int = pts.length;
			var bolSetPt:Boolean;
			
			if(point2DCount > 2)
			{
				if(index>-1 && index<count)
				{
					if(!pts[0].equals(pts[pts.length-1]))
					{
						pts.push(pts[0]);
					}
					this._parts.splice(index, 1, pts);
					bolSetPt=true;
				}
				else
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}	
				
			}
			else
			{
				throw new SmError(SmResource.PART_LENGHT_LESSTHAN_THREE);
			}
			this._bounds = null;
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));
			return bolSetPt;
		}
		
		//一般添加点不在首尾位置 如果在的话 就相当于修改了起点与终点的坐标
		/**
		 * ${core_GeoRegion_method_insertPoint_D} 
		 * @param partIndex ${core_GeoRegion_method_insertPoint_param_partIndex}
		 * @param pointIndex ${core_GeoRegion_method_insertPoint_param_pointIndex}
		 * @param point ${core_GeoRegion_method_insertPoint_param_point}
		 * 
		 */		
		public function insertPoint(partIndex:int, pointIndex:int, point:Point2D) : void
		{
			var aryInsert:Array = null;
			var partLength:int;
			var numPart:int=this.partCount;
			if(partIndex>-1 && partIndex<numPart)
			{
				aryInsert = this._parts[partIndex];
				partLength=this._parts[partIndex].length;
				if (pointIndex>-1 && pointIndex<partLength)
				{					
					if(pointIndex==0)
					{						
						aryInsert.splice(pointIndex, 0, point);
						aryInsert.pop();
						aryInsert.push(point);	
					}					
					else
					{						
						aryInsert.splice(pointIndex, 0, point);
						
					}
				}	
				else if(pointIndex == partLength)
				{
					aryInsert.push(point);
				}
				else
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
				this._bounds = null;
				this.dispatchEvent(new Event(GEOMETRY_CHANGE));
				
			}
			else
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
			
		}		
		
		//修改某一个part里一个点的坐标值 
		/**
		 * ${core_GeoRegion_method_setPoint_D}
		 * @param partIndex ${core_GeoRegion_method_setPoint_param_partIndex}
		 * @param pointIndex ${core_GeoRegion_method_setPoint_param_pointIndex}
		 * @param point ${core_GeoRegion_method_setPoint_param_point}
		 * 
		 */		
		public function setPoint(partIndex:int, pointIndex:int, point:Point2D) : void
		{
			var aryInsert:Array = null;
			var partPtsLength:int;
			var numPart:int=this.partCount;
			if(partIndex>-1 && partIndex<numPart)
			{
				aryInsert = this._parts[partIndex];
				partPtsLength=this._parts[partIndex].length;
				if (pointIndex>-1 && pointIndex<partPtsLength)
				{					
					if(pointIndex == 0 || pointIndex == partPtsLength-1)
					{						
						aryInsert.shift();
						aryInsert.unshift(point);
						aryInsert.pop();
						aryInsert.push(point);						
					}				
					else
					{						
						aryInsert.splice(pointIndex, 1, point);
						
					}
					this._bounds = null;
					this.dispatchEvent(new Event(GEOMETRY_CHANGE));
					
				}
				else
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
			}
			else
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
		}
		
		//删除某一个part里一个点的坐标值 
		/**
		 * ${core_GeoRegion_method_deletePoint_D} 
		 * @param partIndex ${core_GeoRegion_method_deletePoint_param_partIndex}
		 * @param pointIndex ${core_GeoRegion_method_deletePoint_param_pointIndex}
		 * 
		 */		
		public function deletePoint(partIndex:int, pointIndex:int) : void
		{
			var aryInsert:Array = null;
			var partLength:int;	
			var numPart:int=this.partCount;
			if(partIndex>-1 && partIndex<numPart)
			{
				aryInsert = this._parts[partIndex];
				partLength=this._parts[partIndex].length;
				if(partLength>3)
				{
					if(pointIndex>-1 && pointIndex<partLength)	
					{					
						if(pointIndex == 0)
						{
							aryInsert.shift();
							aryInsert.pop();
							aryInsert.push(aryInsert[0] as Point2D);	
						}
						else if(pointIndex == partLength-1 )
						{						
							aryInsert.pop();
							aryInsert.shift();
							aryInsert.push(aryInsert[0] as Point2D);
						}
						else
						{						
							aryInsert.splice(pointIndex, 1);
							
						}
						this.dispatchEvent(new Event(GEOMETRY_CHANGE));
						this._bounds = null;
					}
				}
			}
			
		}
		
		//当part数目与每一个part里的点都相等的时候 两者才完全相等
		/**
		 * @inheritDoc 
		 * @param geometry
		 * @return 
		 * 
		 */		
		override public  function equals(geometry:Geometry):Boolean
		{
			var pointsEquals:Boolean = false;
			if (geometry != null && geometry is GeoRegion)
			{
				var geoRegion:GeoRegion = GeoRegion(geometry);
				var count:int = geoRegion.partCount;
				if (count == this.partCount)
				{
					for (var i:int=0; i < count; i++)
					{
						var aryPartPts:Array=this._parts[i];
						var aryLinePartPts:Array=geoRegion._parts[i];
						for(var j:int=0;j<aryPartPts.length;j++)
						{
							pointsEquals = aryPartPts[j].equals(aryLinePartPts[j]);
							if (!pointsEquals)
							{
								return false;
							}
						}
						pointsEquals=true;
					}					
				}
			}
			return pointsEquals;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function clone():Geometry
		{
			var geoReg:GeoRegion=new GeoRegion();
			var count:int=this._parts.length;
			for(var i:int=0;i<count;i++){
				var part:Array=this.getPart(i); 
				geoReg.addPart(part);
			}			
			return geoReg;			
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override function get defaultStyle():Style
		{
			return PredefinedFillStyle.defaultStyle;
		}
		//TODO:defaultStyle()
		//TODO:toJson()
		
		/**
		 * ${core_GeoRegion_method_contains_D} 
		 * @param point ${core_GeoRegion_method_contains_param_point}
		 * @return ${core_GeoRegion_method_contains_return}
		 * 
		 */		
		public function contains(point:GeoPoint) : Boolean
		{
			if(!point)
			{
				return false;
			}
			var points:Array = [];	
			var partItem:Array;
//			for each (partItem in this.parts)
//			{
//				points = points.concat(partItem);
//			}		
//			return GeoUtil.contains(points, point.x, point.y);;
			for each (partItem in this.parts)
			{
				if(GeoUtil.contains(partItem, point.x, point.y))
				{
					return true;
				}
			}	
			return false;

		}


	}
}