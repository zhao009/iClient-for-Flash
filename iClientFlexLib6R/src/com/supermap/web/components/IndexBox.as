package com.supermap.web.components
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import mx.core.UIComponent;
	
	internal class IndexBox extends UIComponent
	{
		//填充颜色
		private var _fillColor:uint = 0x0000cc;
		//填充alpha
		private var _fillAlpha:Number = 0.3;
		//边框alpha
		private var _borderAlpha:Number = 0.5;
		//边框宽度，不提供给用户
		private var _borderWeidth:Number = 2;
		
		private var _moveEffectEnable:Boolean = true;
		
		//显示区域
		private var _model:String = OverviewMap.RECT;
		
		public function IndexBox()
		{
		}

		public function get moveEffectEnable():Boolean
		{
			return _moveEffectEnable;
		}

		public function set moveEffectEnable(value:Boolean):void
		{
			_moveEffectEnable = value;
		}

		public function get borderWeidth():Number
		{
			return _borderWeidth;
		}

		public function set borderWeidth(value:Number):void
		{
			_borderWeidth = value;
		}

		public function get model():String
		{
			return _model;
		}

		public function set model(value:String):void
		{
			_model = value;
		}

		public function get fillAlpha():Number
		{
			return _fillAlpha;
		}

		public function set fillAlpha(value:Number):void
		{
			_fillAlpha = value;
		}

		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
		}

		public function get fillColor():uint
		{
			return _fillColor;
		}

		public function set fillColor(value:uint):void
		{
			_fillColor = value;
		}

		public function setCenter(centerX:Number, centerY:Number):void
		{
			var xTo:Number = centerX - this.width/2;
			var yTo:Number = centerY - this.height/2;
			if(_moveEffectEnable)
			{
				var xFrom:Number = this.x;
				var yFrom:Number = this.y;
				var xBy:Number = xTo - xFrom;
				var yBy:Number = yTo - yFrom;
				//动画特效。和map一致
				var time:int = getTimer();
				var enterFrameHandler:Function = function (event:Event) : void
				{
					var duration:int = getTimer() - time;
					if (duration >= 300)
					{
						removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
						instance.move(xTo,yTo);
					}
					else
					{
						var durationRatio:Number = duration / 300;
						var newX:Number = xFrom + xBy * durationRatio;
						var newY:Number = yFrom + yBy * durationRatio;
						instance.move(newX,newY);
					}
				}
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
			else
			{
				this.x = xTo;
				this.y = yTo;
			}
		}
		
		private function get instance():IndexBox
		{
			return this;
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{ 
			super.updateDisplayList(unscaledWidth, unscaledHeight);

			graphics.clear();
			graphics.lineStyle(_borderWeidth, _fillColor, _borderAlpha);
			graphics.beginFill(_fillColor, _fillAlpha);
			if(this._model == OverviewMap.RECT)
			{
				graphics.drawRect(0, 0, width , height);
			}
			else if(this._model == OverviewMap.ELLIPSE)
			{
				graphics.drawEllipse(0, 0, width , height);
			}
			graphics.endFill();
		}
		
		override public function set visible(value:Boolean):void
		{
			if(this.visible != value)
			{
				super.visible = value;
			}
		}
	}
}