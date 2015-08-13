package com.supermap.web.components
{ 
	import com.supermap.web.events.TimeSliderEvent;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.GraphicsLayer;
	import com.supermap.web.mapping.Layer;
	import com.supermap.web.resources.SmResource;
	
	import flash.events.*;
	import flash.utils.*;
	
	import mx.controls.sliderClasses.*;
	import mx.events.*;
	
	import spark.components.supportClasses.*;
	
	/**
	 * ${controls_TimeSlider_events_timeChange} 
	 */	
	[Event(name="timeChange", type="com.supermap.web.events.TimeSliderEvent")]
	
	[IconFile("/designIcon/TimeSlider.png")]
	/**
	 * ${controls_TimeSlider_Title}.
	 * <p>${controls_TimeSlider_Description}</p> 
	 * @see TimeData
	 * 
	 */	
	public class TimeSlider extends SkinnableComponent
	{
		private var _playPauseButton:ToggleButtonBase;
		private var _nextButton:ButtonBase;
		private var _previousButton:ButtonBase;
		private var _slider:Slider; 
		private var _isPlaying:Boolean = false;   
		private var _timeStops:Array; 
		private var _layer:Layer; 
		private var _layerReference:LayerReference;//对GraphicsLayer上的操作 
		private var _timeData:TimeData; 
		private var _time:Timer;//添加一个计时器 
		private var _isAccumulatedDisplay:Boolean;//是否累积显示
		private var _isFirstPlay:Boolean = true;  
		
		private static var _skinParts:Object = {slider:true, nextButton:false, previousButton:false, playPauseButton:false, pauseButton:false, playButton:false};
		
		/**
		 * ${controls_TimeSlider_constructor_None_D} 
		 * 
		 */		
		public function TimeSlider()
		{
			super();      
			this._time = new Timer(1000);  
			this.timeData = new TimeData();
			this.timeStops = this.createTimeStopsByCount(this._timeData.startTime, this._timeData.endTime , 2);  
	
		}
		
		/**
		 * ${controls_TimeSlider_attribute_timeDelay_D} 
		 * @return 
		 * 
		 */		
		public function get timeDelay():Number
		{
			return this._time.delay;
		}

		public function set timeDelay(value:Number):void
		{
			this._time.delay = value;
			this.invalidateProperties();
		}

		[Inspectable(category = "iClient",enumeration = "true,false")] 
		/**
		 * ${controls_TimeSlider_attribute_isAccumulatedDisplay_D}.
		 * <p>${controls_TimeSlider_attribute_isAccumulatedDisplay_remarks}</p> 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get isAccumulatedDisplay():Boolean
		{
			return _isAccumulatedDisplay;
		}
		
		public function set isAccumulatedDisplay(value:Boolean):void
		{
			_isAccumulatedDisplay = value;
		} 
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${controls_TimeSlider_attribute_timeData_D} 
		 * @return 
		 * 
		 */		
		public function get timeData():TimeData
		{
			return _timeData;
		}
		public function set timeData(value:TimeData):void
		{
			_timeData = value;   
			this._layerReference = new LayerReference(_layer);
			this._layerReference.timeData = this._timeData; 
			if(value.timeStops)
			{
				this.timeStops = value.timeStops;//当value.timeStops不存在时，保持构造函数中的timeStops数据
			} 
			if(this.timeStops)
			{
				this.timeStops.sort(this.sortFunction, Array.NUMERIC);
				this.initStartAndEndTime(value);
				if(value.startTime > value.endTime)
				{ 
					this.sortTimeStops(value.endTime, value.startTime, true);
				}
				else
				{
					this.sortTimeStops(value.startTime, value.endTime, false); 
				}  
				this.slider.value = 0;
				this.dispatchTimeSliderEvent(0); //设置首次播发标志位
			} 
			this.refresh(); 
		}
		private function sortFunction(dateOne:Date,dateTwo:Date):int
		{  
			var numberOne:Number = dateOne.time;
			var numberTwo:Number = dateTwo.time;
			if(numberOne > numberTwo)
			{
				return 1;
			}
			else if(numberOne < numberTwo)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		 
		private function sortTimeStops(startTime:Date, endTime:Date, isReverse:Boolean = false):void
		{  
			while(startTime > this.timeStops[0])
			{
				this.timeStops.shift(); 
				if(this._timeStops.length <= 0)
				{
					break;
				}
			}  
			while(endTime < this.timeStops[this.timeStops.length - 1])
			{
				this.timeStops.pop(); 
				if(this._timeStops.length <= 0)
				{
					break;
				}
			}
			if(isReverse == true)
			{
				this.timeStops.reverse();
			}
		}
		   
		private function initStartAndEndTime(value:TimeData):void
		{
			if(value.startTime == null)
			{
				value.startTime = value.timeStops[0];
			}
			if(value.endTime == null)
			{
				value.endTime = value.timeStops[value.timeStops.length - 1];
			} 
		}
 
		/**
		 * ${controls_TimeSlider_attribute_slider_D} 
		 * @return 
		 * 
		 */		
		public function get slider():Slider
		{
			return _slider;
		}
		
		public function set slider(value:Slider):void
		{
			_slider = value;
		}
		
		/**
		 * ${controls_TimeSlider_attribute_previousButton_D} 
		 * @return 
		 * 
		 */		
		public function get previousButton():ButtonBase
		{
			return _previousButton;
		}
		
		public function set previousButton(value:ButtonBase):void
		{
			_previousButton = value;
		}
		
		/**
		 * ${controls_TimeSlider_attribute_nextButton_D} 
		 * @return 
		 * 
		 */		
		public function get nextButton():ButtonBase
		{
			return _nextButton;
		}
		
		public function set nextButton(value:ButtonBase):void
		{
			_nextButton = value;
		}
		
		/**
		 * ${controls_TimeSlider_attribute_playPauseButton_D} 
		 * @return 
		 * 
		 */		
		public function get playPauseButton():ToggleButtonBase
		{
			return _playPauseButton;
		}
		
		public function set playPauseButton(value:ToggleButtonBase):void
		{
			_playPauseButton = value;
		}
	 
		/**
		 * ${controls_TimeSlider_attribute_timeStops_D}  
		 * @return 
		 * 
		 */		
		public function get timeStops():Array
		{
			return this._timeStops;
		}
		
		public function set timeStops(value:Array):void
		{
			this._timeStops = value;
			this.refresh();
		}
		
		[Inspectable(category = "iClient")] 

		/**
		 * ${controls_TimeSlider_attribute_layer_D} 
		 * @param value ${controls_TimeSlider_attribute_layer_param_value}
		 * 
		 */		
		public function set layer(value:Layer):void
		{
			//支持FeaturesLayer和GraphicsLayer两种图层
			this._layer=value;
			this._layerReference=new LayerReference(value);
			this._layerReference.timeData = this._timeData;
		}
		 
		/**
		 * ${controls_TimeSlider_method_createTimeStopsByCount_D} 
		 * @param timeExtent ${controls_TimeSlider_method_createTimeStopsByCount_param_timeExtent}
		 * @param count ${controls_TimeSlider_method_createTimeStopsByCount_param_count}
		 * 
		 */		
		public function createTimeStopsByCount(startDate:Date, endDate:Date, count:int = 10) : Array
		{ 
			if (startDate && endDate)
			{
				var max:int = Math.max(2, count);
				var startTime:Number = startDate.time;
				var endTime:Number = endDate.time;
				var timeLength:Number = endTime - startTime;
				var timeUnit:Number = timeLength / (max - 1);
				var startTimeArray:Array = [new Date(startTime)];
				var i:int = 1;
				while (i < (max - 1))
				{ 
					startTime = startTime + timeUnit;
					startTimeArray.push(new Date(startTime));
					i = i + 1;
				}
				startTimeArray.push(new Date(endTime)); 
				return startTimeArray;
			} 
			return null;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		override public function set enabled(value:Boolean) : void
		{
			super.enabled = value; 
			if (enabled != value)
			{
				invalidateSkinState();
			} 
		}
	 
		/**
		 * @private 
		 * @param partName
		 * @param instance
		 * 
		 */		
		override protected function partAdded(partName:String, instance:Object) : void
		{
			super.partAdded(partName, instance); 
			
			if (instance == this.nextButton)
			{
				this.nextButton.toolTip = resourceManager.getString("SuperMapMessage",SmResource.TS_NEXT);
				this.nextButton.addEventListener(MouseEvent.CLICK, this.nextButton_clickHandler);
			}
			else if (instance == this.playPauseButton)
			{ 
				this.playPauseButton.toolTip = resourceManager.getString("SuperMapMessage",SmResource.TS_PLAY);
				this.playPauseButton.addEventListener(MouseEvent.CLICK, this.playPauseButton_clickHandler);
			}
			else if (instance == this.previousButton)
			{
				this.previousButton.toolTip = resourceManager.getString("SuperMapMessage",SmResource.TS_PREVIOUS);
				this.previousButton.addEventListener(MouseEvent.CLICK, this.previousButton_clickHandler);
			}
			else if (instance == this.slider)
			{   
				this.slider.addEventListener(SliderEvent.CHANGE, this.slider_changeHandler);
				this.slider.addEventListener(SliderEvent.THUMB_PRESS, this.slider_thumbPressHandler);
				this.slider.addEventListener(SliderEvent.THUMB_RELEASE, this.slider_thumbReleaseHandler); 
				this.slider.value = 0;
				this.dispatchTimeSliderEvent(0); //设置首次播发标志位
			} 
		}
	    	   
		private function refresh():void
		{
			if (this.slider)
			{   
				this.slider.minimum = 0;
				this.slider.maximum = this.timeStops ? ((this.timeStops.length - 1)) : (0);
				this.slider.snapInterval= 1; 
			} 
			this.invalidateSkinState(); 
		}
		
		/**
		 * @private 
		 * @param partName
		 * @param instance
		 * 
		 */		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
			if (instance == this.nextButton)
			{
				this.nextButton.removeEventListener(MouseEvent.CLICK, this.nextButton_clickHandler);
			}
			else if (instance == this.playPauseButton)
			{
				this.playPauseButton.removeEventListener(MouseEvent.CLICK, this.playPauseButton_clickHandler);
			}
			else if (instance == this.previousButton)
			{
				this.previousButton.removeEventListener(MouseEvent.CLICK, this.previousButton_clickHandler);
			}
			else if (instance == this.slider)
			{ 
				this.slider.removeEventListener(SliderEvent.THUMB_PRESS, this.slider_thumbPressHandler);
				this.slider.removeEventListener(SliderEvent.THUMB_RELEASE, this.slider_thumbReleaseHandler);
				this.slider.removeEventListener(SliderEvent.CHANGE, this.slider_changeHandler);
			}
		} 
		 
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override protected function getCurrentSkinState() : String	//获取皮肤的状态
		{ 
			return enabled ? ("normal") : ("disabled");
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override protected function get skinParts() : Object
		{
			return _skinParts;
		}
		
		private function nextButton_clickHandler(event:MouseEvent):void
		{ 
			this.next();
		}
		
		private function playPauseButton_clickHandler(event:MouseEvent):void
		{  
			this.play();
		}

		/**
		 * ${controls_TimeSlider_method_play_D} 
		 * 
		 */		
		public function play():void
		{
			if(this._isFirstPlay)
			{
				this.dispatchTimeSliderEvent(0); //设置首次播发标志位
				this._isFirstPlay = false;
			}
			if(this._isPlaying == false)
			{
				
				if(this.slider.value == this.slider.maximum)
				{
					this.toStart(); 
				}				
				this.toContinue();
				this.playPauseButton.toolTip = resourceManager.getString("SuperMapMessage",SmResource.TS_PAUSE);
			}
			else
			{ 
				this.pause(); 
				this.playPauseButton.toolTip = resourceManager.getString("SuperMapMessage",SmResource.TS_PLAY);
			} 
		}
	    	
		/**
		 * ${controls_TimeSlider_method_pause_D} 
		 * 
		 */		
		public function pause():void//暂停
		{
			this._time.stop();
			this._time.removeEventListener(TimerEvent.TIMER, this.timerHandler);
			this.playPauseButton.selected = false;//变换符号
			this._isPlaying = false;
		}
		
		/**
		 * ${controls_TimeSlider_method_next_D} 
		 * 
		 */		
		public function next():void
		{
			if(this.slider.value < this.slider.maximum)
			{
				toNext();
			}
		}
	 
		/**
		 * ${controls_TimeSlider_method_previous_D} 
		 * 
		 */		
		public function previous():void
		{
			if(this.slider.value > 0)
			{
				toPrevious();
			}
		}
	 
		private function previousButton_clickHandler(event:MouseEvent):void
		{ 
			this.previous();
		} 
		
		private function slider_changeHandler(event:SliderEvent):void
		{   
			if(this._isPlaying == false)
			{ 
				dispatchTimeSliderEvent(this.slider.value); 
			}
			else
			{
				dispatchTimeSliderEvent(this.slider.value); 
				this.playPauseButton.selected = true;
				this._isPlaying = true;  
			}
		}
		
		private function slider_thumbPressHandler(event:SliderEvent):void
		{ 
			if(this._isPlaying == false)
			{ 
				
			}
			else
			{
				this.pause();
				this._isPlaying = true;
			}
		}
		
		private function slider_thumbReleaseHandler(event:SliderEvent):void
		{ 
			if(this._isPlaying == false)
			{ 
				
			}
			else
			{ 
				dispatchTimeSliderEvent(this.slider.value);
				this.toContinue();
			} 
		}
		
		private function timerHandler(event:TimerEvent):void
		{  
			if(this.slider.value < this.slider.maximum - 1)
			{  
				toMove(); 
			}
			else if(this.slider.value >= this.slider.maximum - 1)
			{ 
				toEnd();  
			}   
		}
		
		private function toMove():void//动画
		{ 
			if(this.slider.value == 0)
			{ 
				this.dispatchTimeSliderEvent(this.slider.value); 
			} 
			this.slider.value++;   
			dispatchTimeSliderEvent(this.slider.value); 
		}
		
		private function toEnd():void//到终点
		{
			this.pause();	
			this.slider.value = this.slider.maximum;
			this.playPauseButton.toolTip = resourceManager.getString("SuperMapMessage",SmResource.TS_PLAY);
			this.dispatchTimeSliderEvent(this.slider.maximum); //设置首次播发标志位
	 	}
		
		private function toStart():void//好像就一个函数调用
		{
			this.slider.value = 0;  
			this.dispatchTimeSliderEvent(this.slider.value); 
		}
		
		private function toPrevious():void//上一步
		{
			this._time.stop();
			this._time.removeEventListener(TimerEvent.TIMER, this.timerHandler);
			this.playPauseButton.selected = false;//变换符号 
			if(this.slider.value > 0)
			{ 
				this.slider.value--; 
				dispatchTimeSliderEvent(this.slider.value); 
			} 
			this._isPlaying = false;
		}
		
		private function toNext():void//下一步
		{
			this._time.stop();
			this._time.removeEventListener(TimerEvent.TIMER, this.timerHandler);
			this.playPauseButton.selected = false;//变换符号 
			if(this.slider.value < this.slider.maximum )
			{
				this.slider.value++;
				dispatchTimeSliderEvent(this.slider.value); 	
			} 
			this._isPlaying = false;
		}
		 
		private function toContinue():void//继续
		{
			this._time.start();
			this._time.addEventListener(TimerEvent.TIMER, timerHandler);
			this.playPauseButton.selected = true;
			this._isPlaying = true;
		}
		   
		private function dispatchTimeSliderEvent(sliderValue:int):void
		{ 
			if(this.timeStops)
			{ 
				var timeValue:int;
				if(this.slider)
				{
					timeValue = this.slider.value;
				}
				else
				{
					timeValue = 0;
				}
				this.dispatchEvent(new TimeSliderEvent(this.timeData.startTime, this.timeData.endTime, this.timeStops[timeValue], this.timeStops));
				
			}
			if(this._layerReference)
			{ 
				if(this.slider.value == 0)
				{ 
					this._layerReference.paint(sliderValue, this._isAccumulatedDisplay); 
				} 
				else if(this.slider.value > 0)
				{ 
					this._layerReference.paint(sliderValue, this._isAccumulatedDisplay);
				}  
			} 
		} 
	}
}