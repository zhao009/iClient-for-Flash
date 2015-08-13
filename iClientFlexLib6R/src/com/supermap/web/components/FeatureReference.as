package com.supermap.web.components
{
	import com.supermap.web.mapping.FeaturesLayer;
	
	import mx.collections.ArrayCollection;
	/**
	 * @private 
	 * 
	 */	
	internal class FeatureReference
	{ 
		private var fl:FeaturesLayer;   
		private var _timeData:TimeData; 
		 
		public function FeatureReference(value:FeaturesLayer)
		{
		  	this.fl = value;   
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
			if(this._timeData.features && this._timeData.timeStops && value < this._timeData.timeStops.length && fl)
			{ 
				var length:int = this._timeData.features.length;
				var features:ArrayCollection = this.timeData.features;
				for(var i:int = 0; i < length; i++)//在整个数组中循环，首次测试，将改进
				{
					var isEqual:Boolean = (features[i].attributes[this.timeData.timeField] as Date).time == (this.timeData.timeStops[value] as Date).time;
				 	if(isEqual)
					{
						this.fl.addFeature(features[i]);//累积添加图形要素
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
 
		public function clear():void
		{
			if(this.fl)
			{
				this.fl.clear();
			}
		}
	}
}