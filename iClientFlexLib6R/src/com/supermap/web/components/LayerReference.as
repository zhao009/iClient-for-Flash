
package com.supermap.web.components
{
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.GraphicsLayer;
	import com.supermap.web.mapping.Layer;
	
	import mx.collections.ArrayCollection;

	/**
	 * @private 
	 * 
	 */	
	internal class LayerReference
	{ 
		/**
		 * 记录是按照feature来绘制还是按照graphic来绘制
		 */
		private var _useFeature:Boolean = true; 
		private var _featuresLayer:FeaturesLayer; 
		private var _graphicsLayer:GraphicsLayer;
		private var _timeData:TimeData; 
		
		public function LayerReference(value:Layer)
		{
			if(value is FeaturesLayer)
			{
				this._featuresLayer = value as FeaturesLayer;
				this._useFeature = true;
			}
			else if(value is GraphicsLayer)
			{
				this._graphicsLayer = value as GraphicsLayer;
				this._useFeature = false;
			}
			else
			{
				//出错
			}
		}
		
		public function get timeData():TimeData
		{
			return _timeData;
		}
		
		public function set timeData(value:TimeData):void
		{
			_timeData = value; 
			this.clear();  
		}
		
		public function paintFeatures(value:int, isClear:Boolean):void//一个点测试方式
		{ 
			if(isClear)
			{
				this.clear();
			} 
			if(this._timeData.features && this._timeData.timeStops && value < this._timeData.timeStops.length && (_featuresLayer || _graphicsLayer))
			{ 
				var length:int = this._timeData.features.length;
				var features:ArrayCollection = this.timeData.features;
				for(var i:int = 0; i < length; i++)//在整个数组中循环，首次测试，将改进
				{
					var isEqual:Boolean = (features[i].attributes[this.timeData.timeField] as Date).time == (this.timeData.timeStops[value] as Date).time;
					if(isEqual)
					{
						if(_useFeature)
						{
							this._featuresLayer.addFeature(features[i]);//累积添加图形要素
						}
						else
						{
							this._graphicsLayer.add([features[i]]);
						}
					}
				}
			}
		}
		
		public function paintFeaturesAdd(value:int):void
		{
			this.clear();
			for(var i:int = 0; i <= value; i++)
			{
				this.paintFeatures(i, false);
			}
		}
		
		public function paint(sliderValue:int, isAccumulatedDisplay:Boolean = true):void
		{ 
			if(!isAccumulatedDisplay)//不积累显示
			{
				paintFeatures(sliderValue,true);
			}
			else
			{ 
				this.paintFeaturesAdd(sliderValue); 
			}
		}
		/**
		 * 清除
		 */
		public function clear():void
		{
			if(this._useFeature && this._featuresLayer)
			{
				this._featuresLayer.clear();
			}
			else if(!this._useFeature && this._graphicsLayer)
			{
				this._graphicsLayer.removeAll();
			}
		}
	}
}