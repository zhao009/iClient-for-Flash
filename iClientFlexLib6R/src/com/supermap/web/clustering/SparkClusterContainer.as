package com.supermap.web.clustering
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.events.*;
	import com.supermap.web.mapping.InfoWindow;
	import com.supermap.web.serialization.json.JSONDecoder;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.text.*;
	
	import mx.core.*;
	import mx.effects.easing.*;
	
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */	
	final internal class SparkClusterContainer extends UIComponent
	{

		public static var sparkEasing:Function;
		
		sm_internal var cluster:Cluster;
		sm_internal var sparkClusterStyle:SparkClusterStyle;
		
		private var _updateDisplayList:Function;
		private var _distance:Number;
		private var _factor:Number = 0;
		private var _textField:TextField;
		private var _sparkFactorIncOut:Number = 0.05;
		private var _sparkFactorIncIn:Number = 0.1;
		private var _weightClusterStyle:WeightClusterStyle;
		private var fieldValuesRegular:FieldValuesRule;
		
		public function SparkClusterContainer(sparkClusterStyle:SparkClusterStyle, cluster:Cluster)
		{
			this._updateDisplayList = this.updateDisplayListCluster;
			this.doubleClickEnabled = false;
			this.sparkClusterStyle = sparkClusterStyle;
			this.cluster = cluster;
			if(sparkClusterStyle.isWeightClusterStyle)
				_weightClusterStyle = new WeightClusterStyle();
			fieldValuesRegular = new FieldValuesRule();
		}
		
		public function get sparkFactorIncIn():Number
		{
			return _sparkFactorIncIn;
		}	
		
		public function set sparkFactorIncIn(value:Number):void
		{
			_sparkFactorIncIn = value;
		}
		
		public function get weightClusterStyle():WeightClusterStyle
		{
			return _weightClusterStyle;
		}
		
		public function set weightClusterStyle(value:WeightClusterStyle):void
		{
			_weightClusterStyle = value;
		}
		
		public function get sparkFactorIncOut():Number
		{
			return _sparkFactorIncOut;
		}		
		public function set sparkFactorIncOut(value:Number):void
		{
			_sparkFactorIncOut = value;
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
			this._textField = new TextField();
			this._textField.name = "textField";
			this._textField.mouseEnabled = false;
			this._textField.mouseWheelEnabled = false;
			this._textField.selectable = false;
			this._textField.autoSize = TextFieldAutoSize.CENTER;
			this._textField.textColor = 0xffffff;
			this._textField.text = this.cluster.weight.toString();
			addChild(this._textField);
			if (this.cluster.features.length < this.sparkClusterStyle.sparkMaxCount)
			{
				addEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
			}
		}
		
		private function rollOverHandler(event:MouseEvent) : void
		{
			if (event.eventPhase === EventPhase.AT_TARGET)
			{
				removeEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
				addEventListener(MouseEvent.ROLL_OUT, this.rollOutHandler);
				removeChild(this._textField);
				this.addSparkElements();
				this._factor = 0;
				SparkClusterContainer.sparkEasing = Bounce.easeOut;
				this._updateDisplayList = this.updateDisplayListSpark;
				addEventListener(Event.ENTER_FRAME, this.enterFrameOutHandler);
				event.updateAfterEvent();
				mouseChildren = false;
				dispatchEvent(new SparkClusterEvent(SparkClusterEvent.SPARK_OUT_START, this.cluster));
			}
		}
		
		private function addSparkElements() : void
		{		
			var countPerRing:int = 0;
			var startAngle:Number = this.sparkClusterStyle.ringAngleStart;
			var incrementAngle:Number = 0;
			var step:Number = 360 / Math.min(this.sparkClusterStyle.maxCountPerRing, this.cluster.features.length);
			this._distance = this.sparkClusterStyle.ringDistanceStart;
			var feature:Feature = null;
			for each (feature in this.cluster.features)
			{			
				if (countPerRing === this.sparkClusterStyle.maxCountPerRing)
				{
					countPerRing = 0;
					startAngle += this.sparkClusterStyle.ringAngleStep;
					incrementAngle = 0;
					this._distance += this.sparkClusterStyle.ringDistanceInc;
				}
				addChild(new SparkClusterElement(feature, startAngle + incrementAngle, this._distance, this.sparkClusterStyle.sparkSize));
				incrementAngle += step;
				countPerRing++;
			}
			this.swapZ();
		}
		
		private function swapZ() : void
		{
			var start:int = 0;
			var end:int = numChildren - 1;
			while (start < end)
			{			
				swapChildrenAt(start++, end--);
			}
		}
		
		private function enterFrameOutHandler(event:Event) : void
		{
			if (this._factor > 1)
			{
				removeEventListener(Event.ENTER_FRAME, this.enterFrameOutHandler);
				mouseChildren = true;
				dispatchEvent(new SparkClusterEvent(SparkClusterEvent.SPARK_OUT_COMPLETE, this.cluster));
			}
			else
			{
				this._factor = this._factor + this.sparkFactorIncOut;
				invalidateDisplayList();
			}
		}
		
		private function rollOutHandler(event:MouseEvent) : void
		{
			if (event.eventPhase === EventPhase.AT_TARGET && !(event.relatedObject is InfoWindow))
			{
				removeEventListener(MouseEvent.ROLL_OUT, this.rollOutHandler);
				if (this._factor < 1)
				{
					removeEventListener(Event.ENTER_FRAME, this.enterFrameOutHandler);
				}
				else
				{
					this._factor = 1;
				}
				SparkClusterContainer.sparkEasing = Linear.easeIn;
				addEventListener(Event.ENTER_FRAME, this.enterFrameInHandler);
				event.updateAfterEvent();
				mouseChildren = false;
				dispatchEvent(new SparkClusterEvent(SparkClusterEvent.SPARK_IN_START, this.cluster));
			}
		}
		
		private function enterFrameInHandler(event:Event) : void
		{
			this._factor = this._factor - this._sparkFactorIncIn;
			if (this._factor <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, this.enterFrameInHandler);
				this.removeAllSparkElements();
				addChild(this._textField);
				this._updateDisplayList = this.updateDisplayListCluster;
				addEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
				dispatchEvent(new SparkClusterEvent(SparkClusterEvent.SPARK_IN_COMPLETE, this.cluster));
			}
			invalidateDisplayList();
		}
		
		private function removeAllSparkElements() : void
		{
			while (numChildren)
			{		
				removeChildAt(0);
			}
		}
		
		private function updateDisplayListCluster() : void
		{
			graphics.clear();			
			
			//-------------------------------------------------------------------------------
			//样式设置
			//-------------------------------------------------------------------------------
			
			var clusterColor:uint;
			var clusterAlpha:Number;	
			var fieldValueNUM:Number = 0;//表示聚合点权重值	
			//计算权重
			if(this.sparkClusterStyle && ((this.sparkClusterStyle.fieldValue && this.sparkClusterStyle.isWeightCluster) || (this.sparkClusterStyle.isWeightClusterStyle && this.sparkClusterStyle.WeightClusterItems && this.sparkClusterStyle.WeightClusterItems.length)))
			{
				
				var clusterFeatureNumber:Number = this.cluster.features.length;//取出来总共的feature个数						
			    var fieldValues:Array = [];
				for(var i:int = 0; i < 	clusterFeatureNumber; i++)
				{
					var feature:Feature = this.cluster.features[i] as Feature;
					for(var field:String in feature.attributes)
					{							
						if(field == this.sparkClusterStyle.fieldValue)
						{							
							var fieldValue:String = feature.attributes[field];
							var json:JSONDecoder = new JSONDecoder(fieldValue,true);
							var fieldObj:Number = json.getValue() as Number;
							fieldValues.push(Math.round(fieldObj));	
						}						
					}	
				}
			
				fieldValuesRegular.array = fieldValues;
				
				if(this.sparkClusterStyle.fieldValueFun == null)
				{
					switch(this.sparkClusterStyle.fieldValueMode)
					{
						case FieldValuesRule.SUM:
							fieldValueNUM = fieldValuesRegular.setResultNumber(sumFn) as Number;
							break;
						case FieldValuesRule.MAX:
							fieldValueNUM = fieldValuesRegular.setResultNumber(maxFn) as Number;
							break;
						case FieldValuesRule.MIN:
							fieldValueNUM = fieldValuesRegular.setResultNumber(minFn) as Number;
							break;
						default:
							break;
					}
				}
				else
				{				
					fieldValuesRegular.fieldValueFun = this.sparkClusterStyle.fieldValueFun;
					fieldValueNUM = fieldValuesRegular.setResultNumber(fieldValuesRegular.fieldValueFun) as Number;					
				}
			}
			//计算权重结束					
				
			//处理离散点样式部分
			var minweight:Number;
			var maxweight:Number;
			if(this.sparkClusterStyle.isWeightClusterStyle && this.sparkClusterStyle.WeightClusterItems && this.sparkClusterStyle.WeightClusterItems.length)
			{
				var itemsLen:int = this.sparkClusterStyle.WeightClusterItems.length;
				for(var j:int = 0; j < 	itemsLen; j++)
				{
					var currentWeightClusterItem:WeightClusterItem = this.sparkClusterStyle.WeightClusterItems[j] as WeightClusterItem;
					minweight = currentWeightClusterItem.minWeight;
					maxweight = currentWeightClusterItem.maxWeight;
					
					if(fieldValueNUM >= minweight && fieldValueNUM < maxweight)
					{
						if(currentWeightClusterItem.weightClusterStyle && currentWeightClusterItem.weightClusterStyle.weightBorderThickness > 0 )
						{
							graphics.lineStyle(currentWeightClusterItem.weightClusterStyle.weightBorderThickness, currentWeightClusterItem.weightClusterStyle.weightBorderColor, currentWeightClusterItem.weightClusterStyle.weightBorderAlpha);
						}
						if(currentWeightClusterItem.weightClusterStyle && !isNaN(currentWeightClusterItem.weightClusterStyle.weightBackgroundColor) && currentWeightClusterItem.weightClusterStyle.weightBackgroundAlpha)
						{
							graphics.beginFill(currentWeightClusterItem.weightClusterStyle.weightBackgroundColor, currentWeightClusterItem.weightClusterStyle.weightBackgroundAlpha);
						}
						break;
					}
					else
					{	
						if(currentWeightClusterItem.defaultWeightClusterStyle)
						{
							var defaultWeightClusterStyle:WeightClusterStyle = currentWeightClusterItem.defaultWeightClusterStyle;
							graphics.lineStyle(defaultWeightClusterStyle.weightBorderThickness, defaultWeightClusterStyle.weightBorderColor, defaultWeightClusterStyle.weightBorderAlpha);						
							graphics.beginFill(defaultWeightClusterStyle.weightBackgroundColor, defaultWeightClusterStyle.weightBorderAlpha);
						}
						else
						{
							var weightClusterStyle:WeightClusterStyle = new WeightClusterStyle();
							graphics.lineStyle(weightClusterStyle.weightBorderThickness, weightClusterStyle.weightBorderColor, weightClusterStyle.weightBorderAlpha);						
							graphics.beginFill(weightClusterStyle.weightBackgroundColor, weightClusterStyle.weightBorderAlpha);
						}
					}
				}	
			}//处理离散点样式部分 结束	
			else
			{
				if(this.sparkClusterStyle.borderThickness > 0)		
				{
					graphics.lineStyle(this.sparkClusterStyle.borderThickness, this.sparkClusterStyle.borderColor, this.sparkClusterStyle.borderAlpha);
				}
				graphics.beginFill(this.sparkClusterStyle.backgroundColor, this.sparkClusterStyle.backgroundAlpha);
			}	
			
			//-------------------------------------------------------------------------------
			//样式设置完毕
			//-------------------------------------------------------------------------------
			
			var size:Number = this.sparkClusterStyle.isSizeWithWeightFactor ? this.sparkClusterStyle.size * this.cluster.weightFactor : this.sparkClusterStyle.size;
			graphics.drawCircle(0, 0, size);
			graphics.endFill();
			
			if (this.sparkClusterStyle.textFormat)
			{
				this._textField.embedFonts = FlexGlobals.topLevelApplication.systemManager.isFontFaceEmbedded(this.sparkClusterStyle.textFormat);
				this._textField.setTextFormat(this.sparkClusterStyle.textFormat);
			}
			
			if(this.sparkClusterStyle.isWeightCluster && fieldValueNUM)
			{
				this._textField.text = String(fieldValueNUM);
			}
			this._textField.x = this._textField.textWidth * -0.5 - 2;
			this._textField.y = this._textField.textHeight * -0.5 - 2;		
		}
		
		//---------------------------------------------------
		//  预定义字段值计算规则 默认为求和运算
		//---------------------------------------------------
		public function sumFn(array:Array):Number 
		{
			var sum:Number = 0;
			for (var i:int;i < array.length; i++) {
				sum += array[i];
			}
			return sum;
		}
		
		public function maxFn(array:Array):Number 
		{
			var array:Array = this.sortArray(array);   
			return array[array.length-1];			
		}
		
		public function minFn(array:Array):Number 
		{
			var array:Array = this.sortArray(array);   
			return array[0];        
		}
		
		public  function sortArray(numbers:Array):Array{         
			numbers.sort(Array.NUMERIC);   
			return numbers;   
		} 
		
		//---------------------------------------------------
		//  预定义字段值计算规则
		//----------------------------------------------------
		
		private function updateDisplayListSpark() : void
		{		
			graphics.clear();
			graphics.beginFill(16777215, 0.01);
			var size:Number = this.sparkClusterStyle.isSizeWithWeightFactor ? this.sparkClusterStyle.size * this.cluster.weightFactor : this.sparkClusterStyle.size;
			graphics.drawCircle(0, 0, Math.max(this._distance, size) + this.sparkClusterStyle.sparkSize);
			graphics.endFill();
			var elem:SparkClusterElement = null;
			var item:int = 0;
			while (item < numChildren)
			{		
				elem = SparkClusterElement(getChildAt(item));
				elem.updateFactor(this._factor);
				elem.updateDisplayList(elem.feature);
				item++;
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			this._updateDisplayList();
		}
	}
}