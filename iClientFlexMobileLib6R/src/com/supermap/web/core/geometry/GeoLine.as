package com.supermap.web.core.geometry
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	
	use namespace sm_internal;
	
	/**
	 * ${core_GeoLine_event_geometryChange_D} 
	 */	
	[Event(name="geometryChange", type="flash.events.Event")]
	[DefaultProperty("parts")]
	/**
	 * ${core_GeoLine_Title}.
	 * <p>${core_GeoLine_Description}</p> 
	 */	
	public class GeoLine extends Geometry
	{
		private var _partCount:int;
		private var _parts:Array;
		private var _bounds:Rectangle2D;

		/**
		 * ${core_GeoLine_constructor_None_D} 
		 * 
		 */		
		public function GeoLine()
		{
			_parts = [];
		}

		override public function get center():Point2D
		{
			if(!_center)
			{
				_center = calculateCenter();
			}
			return _center;
		}
		
		sm_internal function setCenter(vaule:Point2D):void
		{
			_center = vaule;
		}
		
		private function calculateCenter():Point2D{
			var c:Point2D = new Point2D();
			var maxCountIndex:int = 0;
			if (this._parts != null && this._parts.length > 0)
			{
				for (var i:int = 1; i < this._parts.length; i++)
				{
					if ((this._parts[maxCountIndex] as Array).length < (this._parts[i] as Array).length)
					{
						maxCountIndex = i;
					}
				}
				
				if ((this._parts[maxCountIndex] as Array).length == 2)
				{
					c.x = (((this.parts[maxCountIndex] as Array)[0] as Point2D).x + ((this.parts[maxCountIndex] as Array)[1] as Point2D).x) / 2.0;
					c.y = (((this.parts[maxCountIndex] as Array)[0] as Point2D).y + ((this.parts[maxCountIndex] as Array)[1] as Point2D).y) / 2.0;
				}
				else
				{
					var centerPointPosition:int = (this.parts[maxCountIndex] as Array).length / 2;
					c.x = ((this.parts[maxCountIndex] as Array)[centerPointPosition] as Point2D).x;
					c.y = ((this.parts[maxCountIndex] as Array)[centerPointPosition] as Point2D).y;
				}
			}
			return c;
		}
		
		/**
		 * ${core_GeoLine_attribute_partCount_D} 
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
			return Geometry.GEOLINE;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override function  get bounds():Rectangle2D
		{
			//如果line有变化要记得把bounds设为null
			if(!this._bounds)
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
		 * ${core_GeoLine_method_parts_D}.
		 * <p>${core_GeoLine_method_parts_remarks}</p> 
		 * @see #partCount
		 * @param value
		 * 
		 */		
		public function set parts(value:Array):void
		{
			this._parts = value;
			this._bounds = null;
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));	
		}
		
		public function get parts():Array
		{
			return this._parts;
		}
		
		/**
		 * ${core_GeoLine_method_getPart_D} 
		 * @param index ${core_GeoLine_method_getPart_param_index}
		 * @return ${core_GeoLine_method_getPart_return_array}
		 * 
		 */		
		public function getPart(index:int):Array
		{			
			var partAry:Array = this._parts[index] as Array;						
			var cloneArr:Array = [];
			var length:int=partAry.length;
			for (var i:int=0; i < length; i++)
			{
				cloneArr[i] = partAry[i];
			}
			return cloneArr;
				
		}
		
		/**
		 * ${core_GeoLine_method_addPart_D} 
		 * @param pts ${core_GeoLine_method_addPart_param_pts}
		 * @return ${core_GeoLine_method_addPart_return_int}
		 * 
		 */		
		public function addPart(pts:Array):int
		{
			var index:int = -1;
			var point2DCount:int = pts.length;				
			var cloneArr:Array = [];
			if(point2DCount > 1)
			{
				for (var i:int = 0; i < point2DCount; i++)
				{
					var point2D:Point2D = pts[i];
					if(!point2D)
					{
						continue;			
					}
					cloneArr[i] = point2D;
					
				}				
			    this._parts.push(cloneArr);	
				index = this._parts.length - 1;
			}
			else
			{
				throw new SmError(SmResource.PART_LENGHT_LESSTHAN_TWO);
			}
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));	
			this._bounds = null;
			return index;	
		}
		
		/**
		 * ${core_GeoLine_method_insertPart_D} 
		 * @param index ${core_GeoLine_method_insertPart_param_index}
		 * @param pts ${core_GeoLine_method_insertPart_param_pts}
		 * @return ${core_GeoLine_method_insertPart_return}
		 * 
		 */		
		public function insertPart(index:int, pts:Array):Boolean
		{			
			var bolInserPt:Boolean=false;
			var ptCount:int=this._parts.length;
			if(pts.length>1)
			{
				if(index < ptCount && index > -1)
				{					
					this._parts.splice(index, 0, pts);
					bolInserPt = true;					
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
				throw new SmError(SmResource.PART_LENGHT_LESSTHAN_TWO);
			}
			this.dispatchEvent(new Event(GEOMETRY_CHANGE));	
			this._bounds = null;
			return bolInserPt;			
		}
		
		/**
		 * ${core_GeoLine_method_indexOf_D} 
		 * @param pts ${core_GeoLine_method_indexOf_param_pts}
		 * @return ${core_GeoLine_method_indexOf_return}
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
		 * ${core_GeoLine_method_removePart_D} 
		 * @param index ${core_GeoLine_method_removePart_param_index}
		 * @return ${core_GeoLine_method_removePart_return} 
		 * 
		 */		
		public function removePart(index:int):Boolean
		{
			var bolRemovePart:Boolean;
			var length:int = this._parts.length;			
			
			if(index<length && index>-1){
				this._parts.splice(index, 1);
				bolRemovePart=true;			
				this.dispatchEvent(new Event(GEOMETRY_CHANGE));	
			}
			this._bounds = null;
			return bolRemovePart;
		}
		
		/**
		 * ${core_GeoLine_method_setPart_D} 
		 * @param index ${core_GeoLine_method_setPart_param_index}
		 * @param pts ${core_GeoLine_method_setPart_param_pts}
		 * @return ${core_GeoLine_method_setPart_return}
		 * 
		 */		
		public function setPart(index:int, pts:Array):Boolean
		{
			var count:int = this._parts.length;
			var point2DCount:int = pts.length;
			var bolSetPt:Boolean;
			
			if(point2DCount>1)
			{
				if(index>-1 && index<count)
				{
					this._parts.splice(index, 1, pts);
					bolSetPt=true;
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
				throw new SmError(SmResource.PART_LENGHT_LESSTHAN_TWO);
			}
			
			return bolSetPt;
		}
		
		/**
		 * ${core_GeoLine_method_insertPoint_D} 
		 * @param partIndex ${core_GeoLine_method_insertPoint_param_partIndex}
		 * @param pointIndex ${core_GeoLine_method_insertPoint_param_pointIndex}
		 * @param point ${core_GeoLine_method_insertPoint_param_point}
		 * 
		 */		
		public function insertPoint(partIndex:int, pointIndex:int, point:Point2D) : void
		{
			var aryInsert:Array = null;
			var numPart:int=this.partCount;
			if(partIndex>-1 && partIndex<numPart)
			{
				var partLength:int=this._parts[partIndex].length;
				aryInsert = this._parts[partIndex];	
				if (pointIndex>-1 && pointIndex<partLength)
				{				
					aryInsert.splice(pointIndex, 0, point);	
					
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
		
		//修改点
		/**
		 * ${core_GeoLine_method_setPoint_D}
		 * @param partIndex ${core_GeoLine_method_setPoint_param_partIndex}
		 * @param pointIndex ${core_GeoLine_method_setPoint_param_pointIndex}
		 * @param point ${core_GeoLine_method_setPoint_param_point}
		 * 
		 */		
		public function setPoint(partIndex:int, pointIndex:int, point:Point2D) : void
		{
			var aryInsert:Array = null;
			var numPart:int=this.partCount;
			if(partIndex>-1 && partIndex<numPart)
			{
				var partLength:int=this._parts[partIndex].length;
				aryInsert = this._parts[partIndex];	
				if (pointIndex>-1 && pointIndex<partLength)
				{				
					aryInsert.splice(pointIndex, 1, point);	
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
		
		//删除点
		/**
		 * ${core_GeoLine_method_deletePoint_D} 
		 * @param partIndex ${core_GeoLine_method_deletePoint_param_partIndex}
		 * @param pointIndex ${core_GeoLine_method_deletePoint_param_pointIndex}
		 * 
		 */		
		public function deletePoint(partIndex:int, pointIndex:int) : void
		{
			var aryInsert:Array = null;
			var numPart:int=this.partCount;
			var partLength:int;
			if(partIndex>-1 && partIndex<numPart)
			{
				aryInsert = this._parts[partIndex];
				partLength=this._parts[partIndex].length;
				if(partLength>2)
				{
					if(pointIndex>-1 && pointIndex<partLength)	
					{
						aryInsert.splice(pointIndex, 1);
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
					throw new SmError(SmResource.PART_LENGHT_LESSTHAN_THREE);
				}
			}
			else
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public  function equals(geometry:Geometry):Boolean
		{
			var pointsEquals:Boolean = false;
			if (geometry != null && geometry is GeoLine)
			{
				var line:GeoLine = GeoLine(geometry);
				var count:int = line.partCount;
				if (count == this.partCount)
				{
					for (var i:int=0; i < count; i++)
					{
						var aryPartPts:Array=this._parts[i];
						var aryLinePartPts:Array=line._parts[i];
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
		override public  function clone():Geometry
		{
			var geoLine:GeoLine = new GeoLine();
			var ptCount:int = this.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				//注：此处取出的part都是clone的，所以可以直接添加到_parts中。
				var part:Array = this.getPart(i);
				geoLine._parts.push(part);
			}
			return geoLine;
		}
		

		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override function get defaultStyle():Style
		{
			return PredefinedLineStyle.defaultStyle;
		}	
		
		//TODO:defaultStyle()
		//TODO:toJson()
		
		/**
		 * ${core_GeoLine_method_toString_D} 
		 * @return 
		 * 
		 */		
		/*public override function toString():String
		{
			return "[bounds: "+this._bounds+",parts: "+this.parts +",partCount: "+ this._partCount+"]";
		}*/
	}
}