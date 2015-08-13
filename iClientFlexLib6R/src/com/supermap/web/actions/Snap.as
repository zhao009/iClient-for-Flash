package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.events.SnapEvent;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	import mx.collections.ArrayCollection;

	use namespace sm_internal;
	/**
	 * ${actions_Snap_Title}.
	 * <p>${actions_Snap_Deccription}</p> 
	 * 
	 * 
	 */	
	public class Snap extends EventDispatcher
	{
		private var _featureLayers:Array;
		private var _isActivate:Boolean = false;
		private var _pointTolerance:int = 15;
		private var _lineTolerance:int = 10;
		private var _map:Map;
		//捕捉时通过side构建一个bounds，然后与这个bounds相交的feature才进行捕捉计算
		private var _snapSide:Number = 100;
		//用于记录是否处于多捕获状态
		private var _isMultiSnap:Boolean = false;
		
		//用于存储编辑时前一次点击的捕获点
		private var _oldFeature:Feature = null;
		private var _oi:int = -1;
		private var _oj:int = -1;
		//记录捕获的点在当前线段的位置，分为前（f）、中（c）、后（b）
		private var _ol:String = null;
		//存储当前捕获到的Feature，没有捕获到就置为空
		private var _currentFeature:Feature = null;
		//记录当前捕获到的点在 Geometry 的子对象的索引
		private var _ni:int = -1;
		//记录当前捕获到的点在 Geometry 的子对象中的点（所在线段的起始点）索引
		private var _nj:int = -1;
		private var _nl:String = null;
		//记录当前多节点捕捉中间的节点数组
		private var _nodeArray:Array = [];
		
		
		/**
		 * ${actions_Snap_constructor_D}.
		 * @param featureLayers ${actions_Snap_constructor_param_featureLayers}
		 * 
		 */	
		public function Snap(featureLayers:Array)
		{
			this._featureLayers = featureLayers;
		}

		//属性
		//不对外开放

		

		sm_internal function get map():Map
		{
			return _map;
		}
		
		sm_internal function set map(value:Map):void
		{
			_map = value;
		}
		
		
		sm_internal function get nodeArray():Array
		{
			return _nodeArray;
		}
		/**
		 * ${actions_Snap_attribute_snapSide_D} 
		 * @return 
		 * 
		 */
		public function get snapSide():Number
		{
			return _snapSide;
		}

		public function set snapSide(value:Number):void
		{
			_snapSide = value;
		}

		
		/**
		 * ${actions_Snap_attribute_pointTolerance_D} 
		 * @return 
		 * 
		 */
		public function get pointTolerance():int
		{
			return _pointTolerance;
		}

		public function set pointTolerance(value:int):void
		{
			_pointTolerance = value;
		}
		/**
		 * ${actions_Snap_attribute_lineTolerance_D} 
		 * @return 
		 * 
		 */
		public function get lineTolerance():int
		{
			return _lineTolerance;
		}
		
		public function set lineTolerance(value:int):void
		{
			_lineTolerance = value;
		}
		/**
		 * ${actions_Snap_attribute_currentFeature_D} 
		 * @return
		 * 
		 */
		public function get currentFeature():Feature
		{
			return _currentFeature;
		}
		
		/**
		 * ${actions_Snap_attribute_isActivate_D} 
		 * @return 
		 * 
		 */
		public function get isActivate():Boolean
		{
			return _isActivate;
		}

		public function set isActivate(value:Boolean):void
		{
			_isActivate = value;
			if(_isActivate && this._map.stage)
			{
				this.map.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				this.map.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
			else if(!_isActivate && this._map.stage)
			{
				this.map.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				this.map.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			}
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			var keyCode:int = event.keyCode;
			if(keyCode === 16)
			{
				//按下shift的时候
				_isMultiSnap = true;
			}
		}
		private function onKeyUp(event:KeyboardEvent):void
		{
			var keyCode:int = event.keyCode;
			if(keyCode === 16)
			{
				//按下shift释放的时候
				_isMultiSnap = false;
			}
		}
		/**
		 * ${actions_Snap_attribute_featureLayers_D} 
		 * @return 
		 * 
		 */
		public function get featureLayers():Array
		{
			return _featureLayers;
		}

		public function set featureLayers(value:Array):void
		{
			_featureLayers = value;
		}
		
		//方法
		
		/**
		 * @private 不对外公开
		 * 获取进行捕捉计算后的点（距离大于容限时点位置不变）
		 * @param point 鼠标当前的位置
		 * @return 转换后的位置
		 * 
		 */		
		public function getSnapPoint(point:Point2D,updateOldSnapPoint:Boolean = false):Point2D
		{
			var resultPoint:Point2D = point;
			//激活才进行计算，没激活直接返回原点
			if(this.isActivate)
			{
				//计算出一个以当前坐标为中心的一个bounds去寻找feature，这样会减少很多运算量
				var si:Number = this._map.resolution*this.snapSide/2;
				var clipRect:Rectangle2D = new Rectangle2D(point.x - si,point.y - si,point.x + si,point.y + si);
				var feaArray:Array = [];
				//此处遍历所有图层，支持多图层捕捉
				for(var i:int = 0;i<this.featureLayers.length;i++)
				{
					if(this.featureLayers[i] is FeaturesLayer)
					{
						var featureLayer:FeaturesLayer = this.featureLayers[i] as FeaturesLayer;
						if(featureLayer.features !=null)
						{
							var features:ArrayCollection = featureLayer.features as ArrayCollection;
							for(var j:int = 0;j<features.length;j++)
							{
								var feature:Feature = features.getItemAt(j) as Feature;
								var geo:Geometry = feature.geometry;
								if(geo is GeoPoint)
								{
									var geoPoint:GeoPoint = geo as GeoPoint;
									if (clipRect.contains(geoPoint.x, geoPoint.y))
									{
										resultPoint = this.getSnapPointFromGeoPoint(geoPoint,point);
									}
								}
								else if(geo is GeoLine)
								{
									var geoLine:GeoLine = geo as GeoLine;
									if (clipRect.intersects(geoLine.bounds))
									{
										//加进数组以备匹配边缘之用
										feaArray.push(feature);
										resultPoint = this.getSnapPointFromGeoLine(geoLine,point,true);
									}
								}
								else if(geo is GeoRegion)
								{
									var geoRegion:GeoRegion = geo as GeoRegion;
									if (clipRect.intersects(geoRegion.bounds))
									{
										//加进数组以备匹配边缘之用
										feaArray.push(feature);
										resultPoint = this.getSnapPointFromGeoRegion(geoRegion,point,true);
									}
								}
								if(!resultPoint.equals(point))
								{
									_currentFeature = feature;
									getNodes();
									//当点击后存储当前的feature
									if(updateOldSnapPoint)
									{
										_oldFeature = _currentFeature;
										_oi = _ni;
										_oj = _nj;
										_ol = _nl;
									}
									dispatchEvent(new SnapEvent(SnapEvent.SNAP_SUCCEED, resultPoint,_nodeArray,feature));
									return resultPoint;
								}
							}
						}
						else
						{
						}
					}
					else
					{
					}
				}
				//当把所有的feature遍历一遍，使用匹配节点都不行时，此处在匹配那些选出来的feature的边缘
				if(resultPoint.equals(point) && feaArray.length>0)
				{
					for(var k:int = 0;k<feaArray.length;k++)
					{
						var feature2:Feature = feaArray[k] as Feature;
						var geo2:Geometry = feature2.geometry;
						if(geo2 is GeoLine)
						{
							var geoLine2:GeoLine = geo2 as GeoLine;
							
							resultPoint = this.getSnapPointFromGeoLine(geoLine2,point,false);
							
						}
						else if(geo2 is GeoRegion)
						{
							var geoRegion2:GeoRegion = geo2 as GeoRegion;
						
							resultPoint = this.getSnapPointFromGeoRegion(geoRegion2,point,false);
							
						}
						if(!resultPoint.equals(point))
						{
							_currentFeature = feature2;
							//计算连续捕捉节点
							getNodes();
							//当点击后存储当前的feature
							if(updateOldSnapPoint)
							{
								_oldFeature = _currentFeature;
								_oi = _ni;
								_oj = _nj;
								_ol = _nl;
							}
							dispatchEvent(new SnapEvent(SnapEvent.SNAP_SUCCEED, resultPoint,_nodeArray,feature2));
							return resultPoint;
						}
					}
					
				}
				
			}
			else
			{
			}
			//点击时没有捕获到也需要清空
			if(updateOldSnapPoint)
			{
				_oldFeature = null;
				_oi = -1;
				_oj = -1;
				_ol = null;
			}
			//没有捕捉到设置为空
			_currentFeature = null;
			_ni = -1;
			_nj = -1;
			_nl = null;
			_nodeArray = [];
			dispatchEvent(new SnapEvent(SnapEvent.SNAP_FAILED, resultPoint));
			return resultPoint;
		}
		//对点进行捕捉
		private function getSnapPointFromGeoPoint(geoPoint:GeoPoint,point:Point2D):Point2D
		{
			var dx:Number = geoPoint.x - point.x;
			var dy:Number = geoPoint.y - point.y;
			
			var distance:Number = Math.sqrt(dx * dx + dy * dy) / this.map.resolution;
			//默认节点的容限时垂足的1.5倍
			if(distance > this.pointTolerance)
			{
				return point;
			}
			else
				return new Point2D(geoPoint.x,geoPoint.y);
		}
		//对线进行捕捉，可能会是多线
		private function getSnapPointFromGeoLine(geoLine:GeoLine,point:Point2D,isPoint:Boolean):Point2D
		{
			var reaultPoint:Point2D = point;
			for(var i:int = 0;i<geoLine.partCount;i++)
			{
				//取每一条单独的线
				var pointArray:Array = geoLine.parts[i];
				for(var j:int = 0;j<pointArray.length-1;j++)
				{
					//计算线的节点，如果节点满足就直接使用
					if(isPoint)
					{
						
						var point1:Point2D = this.getSnapPointFromGeoPoint(new GeoPoint((pointArray[j] as Point2D).x,(pointArray[j] as Point2D).y), point);
						var point2:Point2D = this.getSnapPointFromGeoPoint(new GeoPoint((pointArray[j+1] as Point2D).x,(pointArray[j+1] as Point2D).y), point);
						if(!point.equals(point1))
						{
							_ni = i;
							_nj = j;
							_nl = "f";
							return point1;
						}
						if(!point.equals(point2))
						{
							_ni = i;
							_nj = j;
							_nl = "b";
							return point2;
						}
					}
					//计算线的垂足
					else
					{
						//计算垂足点是否满足
						var geo:Point2D = this.findNearestPoint(pointArray[j],pointArray[j+1], point);
						
						var dx2:Number = geo.x - point.x;
						var dy2:Number = geo.y - point.y;
						
						var distance:Number = Math.sqrt(dx2 * dx2 + dy2 * dy2) / this.map.resolution;
						if(distance > this.lineTolerance)
						{
							_ni = -1;
							_nj = -1;
							_nl = null;
						}
						else
						{
							_ni = i;
							_nj = j;
							_nl = "c";
							reaultPoint = new Point2D(geo.x,geo.y);
							//有符合的点直接返回，不需要再匹配
							return reaultPoint;
						}
					}
				}
			}
			return reaultPoint;
		}
		//对面进行捕捉，可能会是多面
		private function getSnapPointFromGeoRegion(geoRegion:GeoRegion,point:Point2D,isPoint:Boolean):Point2D
		{
			var reaultPoint:Point2D = point;
			var regionArray:Array = geoRegion.parts;
			for(var i:int = 0;i<geoRegion.partCount;i++)
			{
				//取每一个单独的面
				var pointArray:Array = geoRegion.parts[i];
				for(var j:int = 0;j<pointArray.length-1;j++)
				{
					
					//计算面的节点，如果节点满足就直接使用
					if(isPoint)
					{
						var point1:Point2D = this.getSnapPointFromGeoPoint(new GeoPoint((pointArray[j] as Point2D).x,(pointArray[j] as Point2D).y), point);
						var point2:Point2D = this.getSnapPointFromGeoPoint(new GeoPoint((pointArray[j+1] as Point2D).x,(pointArray[j+1] as Point2D).y), point);
						if(!point.equals(point1))
						{
							_ni = i;
							_nj = j;
							_nl = "f";
							return point1;
						}
						if(!point.equals(point2))
						{
							_ni = i;
							_nj = j;
							_nl = "b";
							return point2;
						}
					}
					//计算面的边界垂足
					else
					{
						var geo:Point2D = this.findNearestPoint(pointArray[j],pointArray[j+1], point);
						
						var dx2:Number = geo.x - point.x;
						var dy2:Number = geo.y - point.y;
						
						var distance:Number = Math.sqrt(dx2 * dx2 + dy2 * dy2) / this.map.resolution;
						if(distance > this.lineTolerance)
						{
							_ni = -1;
							_nj = -1;
							_nl = null;
						}
						else
						{
							_ni = i;
							_nj = j;
							_nl = "c";
							reaultPoint = new Point2D(geo.x,geo.y);
							//有符合的点直接返回，不需要再匹配
							return reaultPoint;
						}
					}
				}
			}
			return reaultPoint;
		}			
		/**
		 * @private
		 * 
		 * 获取点在一条线段上面的垂足点坐标
		 * @param p0： 线段的起始点。
		 * @param p1： 线段的结束点。
		 * @param p： 线段外的一个点。
		 * @return 返回线段外的点在线段上的垂足。
		 */
		private function findNearestPoint(p0:Point2D,p1:Point2D, p:Point2D):Point2D
		{
			//这里两个节点不能一样，不然会出现bug
			if(p0.equals(p1))
			{
				return p0;
			}
			//这里的线只能是两个节点的线段
			var pp0:GeoPoint = new GeoPoint(p.x - p0.x, p.y - p0.y);
			var p1p0:GeoPoint = new GeoPoint(p1.x - p0.x, p1.y - p0.y);
			
			var coefficient:Number = (pp0.x * p1p0.x + pp0.y * p1p0.y) / (p1p0.x * p1p0.x + p1p0.y * p1p0.y);
			if (coefficient < 0.0)
			{
				coefficient = 0.0;
			}
			else if (coefficient > 1.0)
			{
				coefficient = 1.0;
			}
			return new Point2D(p0.x + p1p0.x * coefficient, p0.y + p1p0.y * coefficient);
		}

		/**
		 * 计算多节点捕捉时中间的节点
		 */
		private function getNodes():Array
		{
			_nodeArray = [];
			if(_isMultiSnap && _oldFeature && _currentFeature && (_oldFeature.id == _currentFeature.id) && (_oi == _ni))
			{
				var startIndex:int = -1;
				var endIndex:int = -1;
				//正向的索引
				if(_oj<_nj)
				{
					//计算起始索引
					if((_ol == "f")||(_ol == "c"))
					{
						startIndex = _oj+1;
					}
					else if(_ol == "b")
					{
						startIndex = _oj+2;
					}
					//计算结束索引
					if((_nl == "b")||(_nl == "c"))
					{
						endIndex = _nj;
					}
					else if(_nl == "f")
					{
						endIndex = _nj-1;
					}
					if(startIndex <= endIndex)
					{
						if(_oldFeature.geometry is GeoLine)
						{
							_nodeArray =(_oldFeature.geometry as GeoLine).getPart(_oi).slice(startIndex,endIndex+1);
						}
						if(_oldFeature.geometry is GeoRegion)
						{
							_nodeArray =(_oldFeature.geometry as GeoRegion).getPart(_oi).slice(startIndex,endIndex+1);
						} 
					}
				}
				//反向的索引
				else if(_oj>_nj)
				{
					//计算起始索引
					if((_nl == "f")||(_nl == "c"))
					{
						startIndex = _nj+1;
					}
					else if(_nl == "b")
					{
						startIndex = _nj+2;
					}
					//计算结束索引
					if((_ol == "b")||(_ol == "c"))
					{
						endIndex = _oj;
					}
					else if(_ol == "f")
					{
						endIndex = _oj-1;
					}
					if(startIndex <= endIndex)
					{
						if(_oldFeature.geometry is GeoLine)
						{
							_nodeArray =(_oldFeature.geometry as GeoLine).getPart(_oi).slice(startIndex,endIndex+1);
						}
						if(_oldFeature.geometry is GeoRegion)
						{
							_nodeArray =(_oldFeature.geometry as GeoRegion).getPart(_oi).slice(startIndex,endIndex+1);
						} 
						//需要倒转一下
						_nodeArray = _nodeArray.reverse();
					}
				}
				//相等，肯定中间没有拐点，返回空数组
				else
				{
				}
			}
			return _nodeArray;
		}
	}
}