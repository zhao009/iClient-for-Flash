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
		
		/**
		 * ${core_GeoLine_static_method_createBezier_D} 
		 * @param points ${core_GeoLine_static_method_createBezier_param_points}
		 * @param precision ${core_GeoLine_static_method_createBezier_param_precision}
		 * @param part ${core_GeoLine_static_method_createBezier_param_part}
		 * @return ${core_GeoLine_static_method_createBezier_retrun}
		 * 
		 */	
		public static function createBezier(points:Array, precision:int, part:int):GeoLine
		{
			if(part)
			{
				return GeoLine.createBezier3(points,part);
			}
			//获取待拆分的点
			var bezierPts:Array = [];
			for(var m:int = 0; m < points.length; m++){
				bezierPts[m]= points[m];
			}
			//获取输入点的数量
			var i:int;
			var k:int;
			var j:int = 0;
			var bExit:Boolean;
			var count:int = bezierPts.length;
			var ptBuffer:Array = [];
			var ok:Boolean = true;
			while(ok){
				bExit= true;
				//贝塞尔分解是按4个点为一组进行的，所以小于4个点就再不进行分解
				for(i=0;i<count-3;i+=3){
					//对输入点数组进行分解
					//判断bezierPts[i]到bezierPts[i+4]是否达到精度
					if(GetBezierGap(bezierPts,i)>precision){
						bExit= false;
						//对未达到精度的bezierPts[i]到bezierPts[i+4]进行计算，得到新的ptBuffer点数组
						InciseBezier(bezierPts,i,ptBuffer);
						//去除已使用过的2个控制点
						bezierPts.splice(i+1,2);
						//将本次计算得到的5个新的点插入到bezierPts[i]位置之后，得到新的bezierPts点数组
						for(k=0;k<5;k++){
							bezierPts.splice(i+1+k,0,ptBuffer[k+1]);
						}
						//bezierPts[i]到bezierPts[i+4]没有达到精度，所以不能跳过，i需回归初始
						i-=3;
						count= bezierPts.length;
					}
					if(bExit)
						break;
				}
				//对分解得出的新bezierPts点数组进行优化，除去相同的点
				while(j<count-1){
					if(bezierPts[j]==bezierPts[j+1]){
						bezierPts.splice(j+1,1);
						count--;
					}
					j++;
				}
				ok = false;
			}
			//将分解完成的新的bezierPts点数组转化为GeoLine对象并返回
			var result:GeoLine = new GeoLine();
			result.addPart(bezierPts);
			return result;
		}
		/**
		 * @private
		 */
		public static function InciseBezier(pSrcPt:Array, j:int, pDstPt:Array):void
		{
			var buffer:Array =[];
			buffer[0] = [];
			buffer[1] = [];
			buffer[2] = [];
			var i:int;
			var p:Point2D;
		    var p_x:Number;
			var p_y:Number;
			for(i=0;i<3;i++){
				p_x = (pSrcPt[j+i].x + pSrcPt[j+i+1].x)/2;
				p_y = (pSrcPt[j+i].y + pSrcPt[j+i+1].y)/2; 
				p = new Point2D(p_x,p_y);
				buffer[0].push(p);
			}
			for(i=0;i<2;i++){
				p_x = (buffer[0][i].x + buffer[0][i+1].x)/2;
				p_y = (buffer[0][i].y + buffer[0][i+1].y)/2;
				p = new Point2D(p_x,p_y);
				buffer[1].push(p);
			}
			buffer[2][0] = new Point2D((buffer[1][0].x + buffer[1][1].x)/2, (buffer[1][0].y + buffer[1][1].y)/2);
			//将输入的四个点拆分成7个点
			pDstPt[0] = pSrcPt[j];
			pDstPt[1] = buffer[0][0];
			pDstPt[2] = buffer[1][0];
			pDstPt[3] = buffer[2][0];
			pDstPt[4] = buffer[1][1];
			pDstPt[5] = buffer[0][2];
			pDstPt[6] = pSrcPt[j+3];
		} 
		/**
		 * @private
		 */
		public static function GetBezierGap(pSrcPt:Array, j:int):int
		{
			var gap:int = 0;
			for(var i:int=1;i<4;i++){
				if(Math.abs(pSrcPt[j+i].x-pSrcPt[j+i-1].x)>gap)
					gap=Math.abs(pSrcPt[j+i].x-pSrcPt[j+i-1].x);
				if(Math.abs(pSrcPt[j+i].y-pSrcPt[j+i-1].y)>gap)
					gap=Math.abs(pSrcPt[j+i].y-pSrcPt[j+i-1].y);
			}
			return gap;
		}
		
		/**
		 * ${core_GeoLine_static_method_createBspline_D} 
		 * @param points ${core_GeoLine_static_method_createBspline_param_points}
		 * @param filterSize ${core_GeoLine_static_method_createBspline_param_filterSize}
		 * @return ${core_GeoLine_static_method_createBspline_retrun}
		 * 
		 */	
		public static function createBspline(points:Array, filterSize:int):GeoLine
		{
			//一个点无效，至少需要两个点
			if(points.length<2)
			{
				return null;
			}
			//曲线内部的所有点数组
			var pointListDraw:Array = [];
			//设置曲线平滑曲度
			var k:int=10;
			if(filterSize)
			{
				k=filterSize;
			}
			var i:int;
			var j:int;
			var a0:Number;
			var a1:Number;
			var a2:Number;
			var dt:Number;
			var t1:Number;
			var t2:Number;
			var t_x:Number;
			var t_y:Number;
			dt=1.0/k;
			//计算起始点，
			var value:Number = Math.sqrt((Math.pow(points[1].x-points[0].x, 2) + Math.pow(points[1].y-points[0].y, 2))/2);   //取的点数组中前两个点粗略计算出的一个值
			//此为第一个控制点，此点以后可能会开放出来
			var pointFirst:Point2D = new Point2D(points[0].x-value,points[0].y-value);
			//初始化一个点数组，存放所有的控制点
			var pointListControl:Array = [];
			//第一个控制点也就是起始点pointFirst
			pointListControl[0] = pointFirst;
			//循环用户传进的点数组
			for(i=0;i<points.length-1;i++)
			{
				//定义一个零时数组，只需要三个元素，后期用于调用贝茨曲线划线（由首尾两个挤出点和中间的控制点组成的）
				var  pointList:Array = [];
				//
				pointList[0]=points[i];
				//由前一个控制点和当前的点生成的后一个控制点
				var point:Point2D = new Point2D(points[i].x*2-pointListControl[i].x,points[i].y*2-pointListControl[i].y);
				pointList[1]=point;
				pointListControl[i+1]=point;
				pointList[2]=points[i+1];
				//将此控制点存起来
				pointListDraw.push(pointList[0]);
				//生成当前曲线中的所有点
				for(j=0;j<=k;j++)
				{
					t1=j*dt;
					t2=t1*t1;
					
					a0=(t2-2*t1+1)/2.0;
					a1=(2*t1-2*t2+1)/2.0;
					a2=t2/2.0;
					
					t_x=a0*pointList[0].x+a1*pointList[1].x+a2*pointList[2].x;
					t_y=a0*pointList[0].y+a1*pointList[1].y+a2*pointList[2].y;
					pointListDraw.push(new Point2D(t_x,t_y));
				}
			}
			//将最后一个用户的点存进去才能达到曲线通过所有的点
			pointListDraw.push(points[points.length-1]);
			//将分解完成的pointListDraw点数组转化为GeoLine对象并返回
			var result:GeoLine = new GeoLine();
			result.addPart(pointListDraw);
			return result;
		}
		/**
		 * ${core_GeoLine_static_method_createCardinal_D} 
		 * @param points ${core_GeoLine_static_method_createCardinal_param_points}
		 * @return ${core_GeoLine_static_method_createCardinal_retrun}
		 * 
		 */	
		public static function createCardinal(points:Array):Array
		{
			//如果没有点和一个点、两个点就返回本身
			if(points == null || points.length<3)
			{
				return points;
			}
			//定义传入的点数组，我们会在这些点数组中央（每两个点）插入两个控制点
			var C:Array = points;
			//包含输入点和控制点的数组
			var N:Array = [];
			
			//至少三个点以上
			//这些都是相关资料测出的经验数值
			//定义张力系数，取值在0<t<0.5
			var t:Number = 0.4;
			//为端点张力系数因子，取值在0<b<1
			var b:Number = 0.5;
			//误差控制，是一个大于等于0的数，用于三点非常趋近与一条直线时，减少计算量
			var e:Number = 0.005;
			
			//传入的点数量，至少有三个，n至少为2
			var n:Number = C.length-1;
			//从开始遍历到倒数第三个
			for(var k:Number = 0;k<=n+1-3;k++)
			{
				//三个基础输入点
				var p0:Point2D = C[k];
				var p1:Point2D = C[k+1];
				var p2:Point2D = C[k+2];
				//定义p1的左控制点和右控制点
				var p1l:Point2D = new Point2D();
				var p1r:Point2D = new Point2D();
				//通过p0、p1、p2计算p1点的做控制点p1l和又控制点p1r
				//计算向量p0_p1和p1_p2
				var p0_p1:Point2D = new Point2D(p1.x-p0.x,p1.y-p0.y);
				var p1_p2:Point2D = new Point2D(p2.x-p1.x,p2.y-p1.y);
				//并计算模
				var d01:Number = Math.sqrt(p0_p1.x*p0_p1.x + p0_p1.y*p0_p1.y);
				var d12:Number = Math.sqrt(p1_p2.x*p1_p2.x + p1_p2.y*p1_p2.y);
				//向量单位化
				var p0_p1_1:Point2D = new Point2D(p0_p1.x/d01,p0_p1.y/d01);
				var p1_p2_1:Point2D = new Point2D(p1_p2.x/d12,p1_p2.y/d12);
				//计算向量p0_p1和p1_p2的夹角平分线向量
				var p0_p1_p2:Point2D = new Point2D(p0_p1_1.x+p1_p2_1.x,p0_p1_1.y+p1_p2_1.y);
				//计算向量 p0_p1_p2 的模
				var d012:Number = Math.sqrt(p0_p1_p2.x*p0_p1_p2.x + p0_p1_p2.y*p0_p1_p2.y);
				//单位化向量p0_p1_p2
				var p0_p1_p2_1:Point2D = new Point2D(p0_p1_p2.x/d012,p0_p1_p2.y/d012);
				//判断p0、p1、p2是否共线，这里判定向量p0_p1和p1_p2的夹角的余弦和1的差值小于e就认为三点共线
				var cosE_p0p1p2:Number = (p0_p1_1.x*p1_p2_1.x+p0_p1_1.y*p1_p2_1.y)/1;
				//共线
				if(Math.abs(1-cosE_p0p1p2)<e)
				{
					//计算p1l的坐标
					p1l.x = p1.x-p1_p2_1.x*d01*t;
					p1l.y = p1.y-p1_p2_1.y*d01*t;
					//计算p1r的坐标
					p1r.x = p1.x+p0_p1_1.x*d12*t;
					p1r.y = p1.y+p0_p1_1.y*d12*t;
				}
				//非共线
				else
				{
					//计算p1l的坐标
					p1l.x = p1.x-p0_p1_p2_1.x*d01*t;
					p1l.y = p1.y-p0_p1_p2_1.y*d01*t;
					//计算p1r的坐标
					p1r.x = p1.x+p0_p1_p2_1.x*d12*t;
					p1r.y = p1.y+p0_p1_p2_1.y*d12*t;
				}
				//记录下这三个控制点
				N[k*3+2+0] = p1l;
				N[k*3+2+1] = p1;
				N[k*3+2+2] = p1r;
				
				//当为起始点时需要计算第一个点的右控制点
				
				if(k==0)
				{
					//定义p0的右控制点
					var p0r:Point2D = new Point2D();
					
					//计算向量p0_p1l
					var po_p1l:Point2D = new Point2D(p1l.x-p0.x,p1l.y-p0.y);
					//计算模
					var d01l:Number = Math.sqrt(po_p1l.x*po_p1l.x+po_p1l.y*po_p1l.y);
					//单位化
					var po_p1l_1:Point2D = new Point2D(po_p1l.x/d01l,po_p1l.y/d01l);
					//计算p0r
					p0r.x = p0.x+po_p1l_1.x*d01*t*b;
					p0r.y = p0.y+po_p1l_1.y*d01*t*b;
					
					N[k*3+0] = p0;
					N[k*3+1] = p0r;
				}
				//当为倒数第三个点时需要计算最后点的左控制点
				if(k==n+1-3)
				{
					//定义 p2的做控制点p2l
					var p2l:Point2D = new Point2D();
					
					//计算向量p2_p1r
					var p2_p1r:Point2D = new Point2D(p1r.x-p2.x,p1r.y-p2.y);
					//并取模
					var d21r:Number = Math.sqrt(p2_p1r.x*p2_p1r.x+p2_p1r.y*p2_p1r.y);
					//单位化
					var p2_p1r_1:Point2D = new Point2D(p2_p1r.x/d21r,p2_p1r.y/d21r);
					//计算p2l
					p2l.x = p2.x+p2_p1r_1.x*d12*t*b;
					p2l.y = p2.y+p2_p1r_1.y*d12*t*b;
					
					N[k*3+2+3] = p2l;
					N[k*3+2+4] = p2;
				}
			}
			return N;
		}
		/**
		 * ${core_GeoLine_static_method_createBezier2_D} 
		 * @param points ${core_GeoLine_static_method_createBezier2_param_points}
		 * @param part ${core_GeoLine_static_method_createBezier2_param_part}
		 * @return ${core_GeoLine_static_method_createBezier2_retrun}
		 * 
		 */	
		public static function createBezier2(points:Array,part:int = 20):GeoLine
		{
			//获取待拆分的点
			var bezierPts:Array = [];
			var scale:Number = 0.05;
			if(part>0)
			{
				scale = 1/part;
			}
			
			
			for(var i:int = 0;i<points.length-2;)
			{
				//起始点
				var pointS:Point2D = points[i] as Point2D;
				//控制点
				var pointC:Point2D = points[i+1] as Point2D;
				//结束点
				var pointE:Point2D = points[i+2] as Point2D;
				
				bezierPts.push(pointS);
				for(var t:Number = 0;t<1;)
				{
					//二次贝塞尔曲线公式
					var x:Number = (1-t)*(1-t)*pointS.x+2*t*(1-t)*pointC.x+t*t*pointE.x;
					var y:Number = (1-t)*(1-t)*pointS.y+2*t*(1-t)*pointC.y+t*t*pointE.y;
					var point:Point2D = new Point2D(x,y);
					bezierPts.push(point);
					t+=scale;
				}
				
				i+=2;
				if(i>=points.length)
				{
					bezierPts.push(pointS);
				}
			}
			var result:GeoLine = new GeoLine();
			
			//需要判定一下最后一个点是否存在
			var poRE:Point2D = bezierPts[bezierPts.length-1] as Point2D;
			var popE:Point2D = points[points.length-1] as Point2D;
			if(!poRE.equals(popE))
			{
				bezierPts.push(popE.clone());
			}
			result.addPart(bezierPts);
			return result;
		}
		//此处实现三次贝塞尔曲线
		private static function createBezier3(points:Array,part:int = 20):GeoLine
		{
			//获取待拆分的点
			var bezierPts:Array = [];
			var scale:Number = 0.05;
			if(part>0)
			{
				scale = 1/part;
			}
			
			for(var i:int = 0;i<points.length-3;)
			{
				//起始点
				var pointS:Point2D = points[i] as Point2D;
				//第一个控制点
				var pointC1:Point2D = points[i+1] as Point2D;
				//第二个控制点
				var pointC2:Point2D = points[i+2] as Point2D;
				//结束点
				var pointE:Point2D = points[i+3] as Point2D;
				
				bezierPts.push(pointS);
				for(var t:Number = 0;t<1;)
				{
					//二次贝塞尔曲线公式
					var x:Number = (1-t)*(1-t)*(1-t)*pointS.x+3*t*(1-t)*(1-t)*pointC1.x+3*t*t*(1-t)*pointC2.x+t*t*t*pointE.x;
					var y:Number = (1-t)*(1-t)*(1-t)*pointS.y+3*t*(1-t)*(1-t)*pointC1.y+3*t*t*(1-t)*pointC2.y+t*t*t*pointE.y;
					var point:Point2D = new Point2D(x,y);
					bezierPts.push(point);
					t+=scale;
				}
				
				i+=3;
				if(i>=points.length)
				{
					bezierPts.push(pointS);
				}
			}
			var result:GeoLine = new GeoLine();
			
			//需要判定一下最后一个点是否存在
			var poRE:Point2D = bezierPts[bezierPts.length-1] as Point2D;
			var popE:Point2D = points[points.length-1] as Point2D;
			if(!poRE.equals(popE))
			{
				bezierPts.push(popE.clone());
			}
			result.addPart(bezierPts);
			return result;
		}
	}
}