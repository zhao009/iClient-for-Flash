package com.supermap.web.clustering
{
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.text.*;
	
	import mx.core.*;
	import mx.events.*;
	use namespace sm_internal;
	
	/**
	 * ${clustering_SparkClusterStyle_Title}. 
	 * <p>${clustering_SparkClusterStyle_Description}</p>
	 * @see com.supermap.web.events.SparkClusterEvent
	 * @see com.supermap.web.events.SparkClusterMouseEvent
	 *  
	 */	
	public class SparkClusterStyle extends Style
	{
		private var _size:Number = 20;
		private var _isSizeWithWeightFactor:Boolean = true;
		private var _backgroundColor:Number = 0xff0000;
		private var _backgroundAlpha:Number = 0.75;
		private var _borderThickness:Number = 2;
		private var _borderColor:Number = 0xffffff;
		private var _borderAlpha:Number = 0.8;
		private var _sparkMaxCount:int = 30;
		private var _maxCountPerRing:int = 6;
		private var _ringAngleStart:Number = 5;
		private var _ringAngleStep:Number = 15;
		private var _ringDistanceStart:Number = 30;
		private var _ringDistanceStep:Number = 20;
		private var _sparkSize:Number = 5;
		private var _sparkSizeOnRollOver:Number = 2;
		private var _textFormat:TextFormat;
		private static var _instance:SparkClusterStyle;
		//是否根据分散点的权重值来设置背景色
		private var _isWeightClusterStyle:Boolean = false;
		//是否在聚合点上显示权重值(根据离散点的权重值计算出来 默认求和) --- 2011.12.4
		private var _isWeightCluster:Boolean = false;
		//根据传递进来的字段来计算总和 当_isWeightClusterStyle为true时候必设
		private var _fieldValue:String = "SMID";  
		//这个就是设置的信息 当_isWeightClusterStyle为true时候必设
		private var _WeightClusterItems:Array;   
		//设置字段计算规则 默认的是对字段值进行求和运算
		private var _fieldValueMode:String = FieldValuesRule.SUM;
		//自定义计算规则函数(此函数需要传入一个数组对象 对数组里数字进行数学运算并返回一个结果)

		public function get isWeightCluster():Boolean
		{
			return _isWeightCluster;
		}

		public function set isWeightCluster(value:Boolean):void
		{			
			var old_value:Boolean = this.isWeightCluster;
			if (old_value !== value)
			{
				this._isWeightCluster = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isWeightCluster", old_value, value));
				}
			}
		}

		private var _fieldValueFun:Function;
				
		/**
		 * ${clustering_SparkClusterStyle_constructor_D} 
		 * 
		 */		
		public function SparkClusterStyle()
		{
			
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_fieldValueFun_D}.
		 * <p>${clustering_SparkClusterStyle_attribute_fieldValueFun_remarks}</p> 
		 * @see FieldValuesRule
		 * @see #fieldValue
		 * @return 
		 * 
		 */		
		public function get fieldValueFun():Function
		{
			return _fieldValueFun;
		}
		
		public function set fieldValueFun(value:Function):void
		{
			var old_value:Function = this.fieldValueFun;
			if (old_value !== value)
			{
				this._fieldValueFun = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldValueFun", old_value, value));
				}
			}
		}	
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_fieldValueMode_D}.
		 * <p>${clustering_SparkClusterStyle_attribute_fieldValueMode_remarks}</p> 
		 * @see FieldValuesRule
		 * @see #fieldValue
		 * @see #fieldValueFun
		 * @return 
		 * 
		 */		
		public function get fieldValueMode():String
		{
			return _fieldValueMode;
		}

		public function set fieldValueMode(value:String):void
		{
			var old_value:String = this.fieldValueMode;
			if (old_value !== value)
			{
				this._fieldValueMode = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldValueMode", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_SparkClusterStyle_attribute_fieldValue_D}.
		 * <p>${clustering_SparkClusterStyle_attribute_fieldValue_remarks}</p> 
		 * @see WeightClusterItem
		 * @see #WeightClusterItems
		 * @return 
		 * 
		 */		
		public function get fieldValue():String
		{
			return _fieldValue;
		}

		public function set fieldValue(value:String):void
		{
			var old_value:String = this.fieldValue;
			if (old_value !== value)
			{
				this._fieldValue = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fieldValue", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_SparkClusterStyle_attribute_WeightClusterItems_D}.
		 * <p>${clustering_SparkClusterStyle_attribute_WeightClusterItems_remarks}</p> 
		 * @see WeightClusterItem
		 * @return 
		 * 
		 */		
		public function get WeightClusterItems():Array
		{
			return _WeightClusterItems;
		}

		public function set WeightClusterItems(value:Array):void
		{
			var old_value:Array = this.WeightClusterItems;
			if (old_value !== value)
			{
				this._WeightClusterItems = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "WeightClusterItems", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_SparkClusterStyle_attribute_isWeightClusterStyle_D}.
		 * <p>${clustering_SparkClusterStyle_attribute_isWeightClusterStyle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get isWeightClusterStyle():Boolean
		{
			return _isWeightClusterStyle;
		}

		public function set isWeightClusterStyle(value:Boolean):void
		{
			var old_value:Boolean = this.isWeightClusterStyle;
			if (old_value !== value)
			{
				this._isWeightClusterStyle = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isWeightClusterStyle", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_SparkClusterStyle_attribute_backgroundAlpha_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get backgroundAlpha() : Number
		{
			return this._backgroundAlpha;
		}	
		public function set backgroundAlpha(value:Number) : void
		{
			var old_value:Number = this.backgroundAlpha;
			if (old_value !== value)
			{
				this._backgroundAlpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundAlpha", old_value, value));
				}
			}
			
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_backgroundColor_D} 
		 * @default 7786752
		 * @return 
		 * 
		 */		
		public function get backgroundColor() : Number
		{
			return this._backgroundColor;
		}	
		public function set backgroundColor(value:Number) : void
		{
			var old_value:Number = this.backgroundColor;
			if (old_value !== value)
			{
				this._backgroundColor = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundColor", old_value, value));
				}
			}
			
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_borderAlpha_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get borderAlpha() : Number
		{
			return this._borderAlpha;
		}	
		public function set borderAlpha(value:Number) : void
		{
			var old_value:Number = this.borderAlpha;
			if (old_value !== value)
			{
				this._borderAlpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderAlpha", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_borderColor_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get borderColor() : Number
		{
			return this._borderColor;
		}	
		public function set borderColor(value:Number) : void
		{
			var old_value:Number = this.borderColor;
			if (old_value !== value)
			{
				this._borderColor = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderColor", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_borderThickness_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get borderThickness() : Number
		{
			return this._borderThickness;
		}	
		public function set borderThickness(value:Number) : void
		{
			var old_value:Number = this.borderThickness;
			if (old_value !== value)
			{
				this._borderThickness = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderThickness", old_value, value));
				}
			}
		}
		
		sm_internal static function get instance() : SparkClusterStyle
		{
			if (_instance === null)
			{
				_instance = new SparkClusterStyle;
			}
			return _instance;
		}
		
		//是否显示cluster时按其权重系数来调整size，权重系数是该cluster的权重与最大的权重的比值
		/**
		 * ${clustering_SparkClusterStyle_attribute_isSizeWithWeightFactor_D} 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get isSizeWithWeightFactor() : Boolean
		{
			return this._isSizeWithWeightFactor;
		}	
		public function set isSizeWithWeightFactor(value:Boolean) : void
		{
			var old_value:Boolean = this.isSizeWithWeightFactor;
			if (old_value !== value)
			{
				this._isSizeWithWeightFactor = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isSizeWithWeightFactor", old_value, value));
				}
			}		
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_maxCountPerRing_D} 
		 * @default 6
		 * @return 
		 * 
		 */		
		public function get maxCountPerRing() : int
		{
			return this._maxCountPerRing;
		}
		
		public function set maxCountPerRing(value:int) : void
		{		
			var old_value:Number = this.maxCountPerRing;
			if (old_value !== value)
			{
				this._maxCountPerRing = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "maxCountPerRing", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_ringAngleStart_D} 
		 * @default 5
		 * @return 
		 * 
		 */		
		public function get ringAngleStart() : Number
		{
			return this._ringAngleStart;
		}
		
		public function set ringAngleStart(value:Number) : void
		{
			
			var old_value:Number = this.maxCountPerRing;
			if (old_value !== value)
			{
				this._ringAngleStart = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ringAngleStart", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_ringAngleStep_D}
		 * @default 15 
		 * @return 
		 * 
		 */		
		public function get ringAngleStep() : Number
		{
			return this._ringAngleStep;
		}
		
		public function set ringAngleStep(value:Number) : void
		{
			var old_value:Number = this.maxCountPerRing;
			if (old_value !== value)
			{
				this._ringAngleStep = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ringAngleInc", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_ringDistanceStart_D} 
		 * @default 30
		 * @return 
		 * 
		 */		
		public function get ringDistanceStart() : Number
		{
			return this._ringDistanceStart;
		}
		
		public function set ringDistanceStart(value:Number) : void
		{

			var old_value:Number = this.ringDistanceStart;
			if (old_value !== value)
			{
				this._ringDistanceStart = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ringDistanceStart", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_ringDistanceInc_D} 
		 * @default 20
		 * @return 
		 * 
		 */		
		public function get ringDistanceInc() : Number
		{
			return this._ringDistanceStep;
		}
		
		public function set ringDistanceInc(value:Number) : void
		{
			var old_value:Number = this.ringDistanceInc;
			if (old_value !== value)
			{
				this._ringDistanceStep = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ringDistanceInc", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_sparkSize_D} 
		 * @default 5
		 * @return 
		 * 
		 */		
		public function get sparkSize() : Number
		{
			return this._sparkSize;
		}
		
		public function set sparkSize(value:Number) : void
		{
			var old_value:Number = this.sparkSize;
			if (old_value !== value)
			{
				this._sparkSize = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sparkSize", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SparkClusterStyle_attribute_sparkSizeOnRollOver_D} 
		 * @return 
		 * 
		 */		
		public function get sparkSizeOnRollOver() : Number
		{
			return this._sparkSizeOnRollOver;
		}
		
		public function set sparkSizeOnRollOver(value:Number) : void
		{
			var old_value:Number = this.sparkSizeOnRollOver;
			if (old_value !== value)
			{
				this._sparkSizeOnRollOver = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sparkSizeIncOnRollOver", old_value, value));
				}
			}
		}
	
		/**
		 * ${clustering_SparkClusterStyle_attribute_sparkMaxCount_D}.
		 * <p>${clustering_SparkClusterStyle_attribute_sparkMaxCount_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get sparkMaxCount() : int
		{
			return this._sparkMaxCount;
		}	
		public function set sparkMaxCount(value:int) : void
		{
			if (this._sparkMaxCount !== value)
			{
				this._sparkMaxCount = value;
				dispatchEventChange();
			}
		}
	
		/**
		 * ${clustering_SparkClusterStyle_attribute_size_D} 
		 * @return 
		 * 
		 */		
		public function get size() : Number
		{
			return this._size;
		}	
		public function set size(value:Number) : void
		{
			var old_value:Number = this.size;
			if (old_value !== value)
			{
				this._size = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "size", old_value, value));
				}
			}
			
		}
	
		/**
		 * ${clustering_SparkClusterStyle_attribute_textFormat_D} 
		 * @return 
		 * 
		 */		
		public function get textFormat() : TextFormat
		{
			return this._textFormat;
		}	
		public function set textFormat(value:TextFormat) : void
		{
			var old_value:TextFormat = this.textFormat;
			if (old_value !== value)
			{
				this._textFormat = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textFormat", old_value, value));
				}
			}
		}
		
		
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function clear(sprite:Sprite) : void
		{
			sprite.graphics.clear();
//			sprite.getChildAt(0);
			sprite.numChildren;
			if(sprite.numChildren > 0)
				sprite.removeChildAt(0);
		}
		
		/**
		 * @inheritDoc 
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */		
		override sm_internal function createSwatch(width:Number = 50, height:Number = 50) : UIComponent
		{
			var com:UIComponent = new UIComponent();
			com.width = width;
			com.height = height;
			if (this.borderThickness > 0)
			{
				com.graphics.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha);
			}
			com.graphics.beginFill(this.backgroundColor, this.backgroundAlpha);
			com.graphics.drawCircle(width * 0.5, height * 0.5, Math.min(width, height) * 0.5);
			com.graphics.endFill();
			return com;
		}
		
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * @param geometry
		 * @param attributes
		 * @param map
		 * 
		 */		
		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{
			
			var geoPoint:GeoPoint = null;
			var clusterFeature:ClusterFeature = sprite as ClusterFeature;
			if (clusterFeature)
			{
				geoPoint = clusterFeature.geoPoint;
				sprite.x = toScreenX(map, geoPoint.x);
				sprite.y = toScreenY(map, geoPoint.y);				
				sprite.addChild(new SparkClusterContainer(this, clusterFeature.cluster));
				
			}
		}
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function destroy(sprite:Sprite) : void
		{
			removeAllChildren(sprite);
		}
		/**
		 * @inheritDoc 
		 */
		override public function initialize(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{
//			var clusterFeature:ClusterFeature = sprite as ClusterFeature;
//			if (clusterFeature)
//			{
//				sprite.addChild(new SparkClusterContainer(this, clusterFeature.cluster));
//			}
			
		}
		
//		public function setFieldValueRegular(fn:Function):Number
//		{
//			var result:Number = fn(array);//fn是用户自己定义的一个函数 这个函数用来处理array
//			trace(result);
//			return result; 
//		}		
	}
}