package com.supermap.web.clustering
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.events.*;
	import com.supermap.web.sm_internal;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	
	import mx.events.*;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */	
	internal class SparkClusterElement extends Sprite
	{
		private var _feature:Feature;
		private var _radius:Number;
		private var _distance:Number;
		private var m_distance:Number;
		private var clusterElementStyle:SparkElementStyle = null;
		
		//构造函数里对feature的_clusterElementStyle判断 并取出来
		function SparkClusterElement(feature:Feature, angle:Number, distance:Number, radius:Number)
		{
			this._feature = feature;
			this._distance = distance;
			this._radius = radius;
			rotation = angle;
			clusterElementStyle = feature.sparkElementStyle;
			this.addEventListener(Event.ADDED, this.addedHandler, false, 0, true);
			this.addEventListener(Event.REMOVED, this.removedHandler, false, 0, true);
		}
		
		public function get feature():Feature
		{
			return _feature;
		}

		public function set feature(value:Feature):void
		{
			_feature = value;
		}

		private function addedHandler(event:Event) : void
		{
			addEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
		}
		
		private function mouseDownHandler(event:MouseEvent) : void
		{
			var local:Point = globalToLocal(new Point(event.stageX, event.stageY));
			if (local.x < this._distance - this._radius)
			{
				return;
			}
			if (event.eventPhase === EventPhase.AT_TARGET)
			{
				addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
				addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
			}
		}
		
		private function mouseMoveHandler(event:MouseEvent) : void
		{
			if (event.eventPhase === EventPhase.AT_TARGET)
			{
				removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
				removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
			}
		}
		
		private function mouseUpHandler(event:MouseEvent) : void
		{
			if (event.eventPhase === EventPhase.AT_TARGET)
			{
				event.stopPropagation();
				removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
				removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
				this.dispatchSparkMouseEvent(SparkClusterMouseEvent.SPARK_CLICK, event, SparkClusterContainer(parent));
			}
		}
		
		private function dispatchSparkMouseEvent(type:String, event:MouseEvent, sparkClusterContainer:SparkClusterContainer) : void
		{
			var sparkClusterMouseEvent:SparkClusterMouseEvent = new SparkClusterMouseEvent(type, sparkClusterContainer.cluster, this._feature);
			sparkClusterMouseEvent.copyProperties(event);
			dispatchEvent(sparkClusterMouseEvent);
		}
		
		private function rollOverHandler(event:MouseEvent) : void
		{
			var sparkClusterContainer:SparkClusterContainer = null;
			if (hasEventListener(MouseEvent.ROLL_OUT))
			{
				removeEventListener(MouseEvent.ROLL_OUT, this.rollOutHandler);
			}
			var local:Point = globalToLocal(new Point(event.stageX, event.stageY));
			if (local.x < this._distance - this._radius)
			{
				return;
			}
			sparkClusterContainer = SparkClusterContainer(parent);
			var sparkClusterStyle:SparkClusterStyle = sparkClusterContainer.sparkClusterStyle;
			this._radius += sparkClusterStyle.sparkSizeOnRollOver;
			this.updateDisplayList((event.target as SparkClusterElement).feature);
			event.updateAfterEvent();
			addEventListener(MouseEvent.ROLL_OUT, this.rollOutHandler);
			this.dispatchSparkMouseEvent(SparkClusterMouseEvent.SPARK_OVER, event, sparkClusterContainer);
		}
		
		private function rollOutHandler(event:MouseEvent) : void
		{
			var sparkClusterContainer:SparkClusterContainer = null;
			removeEventListener(MouseEvent.ROLL_OUT, this.rollOverHandler);
			sparkClusterContainer = SparkClusterContainer(parent);
			var sparkClusterStyle:SparkClusterStyle = sparkClusterContainer.sparkClusterStyle;
			this._radius -= sparkClusterStyle.sparkSizeOnRollOver;
			this.updateDisplayList((event.target as SparkClusterElement).feature);
			event.updateAfterEvent();
			this.dispatchSparkMouseEvent(SparkClusterMouseEvent.SPARK_OUT, event, sparkClusterContainer);
		}
		
		private function removedHandler(event:Event) : void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
			removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
			removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
			removeEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
			removeEventListener(MouseEvent.ROLL_OUT, this.rollOutHandler);
		}
		
		public function updateDisplayList(elementFeature:Feature) : void
		{
			var sparkClusterContainer:SparkClusterContainer = null;
			sparkClusterContainer = SparkClusterContainer(parent);
			var sparkClusterStyle:SparkClusterStyle = sparkClusterContainer.sparkClusterStyle;
			graphics.clear();
			if(clusterElementStyle)
			{
				clusterElementStyle.backgroundAlpha = isNaN(clusterElementStyle.backgroundAlpha) ?  sparkClusterStyle.backgroundAlpha : clusterElementStyle.backgroundAlpha;
				clusterElementStyle.backgroundColor = (clusterElementStyle.isSetBackgroundColor) ? clusterElementStyle.backgroundColor : sparkClusterStyle.backgroundColor;
				clusterElementStyle.borderAlpha = isNaN(clusterElementStyle.borderAlpha) ? sparkClusterStyle.borderAlpha : clusterElementStyle.borderAlpha;
				clusterElementStyle.borderColor = (clusterElementStyle.isSetBorderColor) ? clusterElementStyle.borderColor : sparkClusterStyle.borderColor;
				clusterElementStyle.borderThickness = isNaN(clusterElementStyle.borderThickness) ? sparkClusterStyle.borderThickness : clusterElementStyle.borderThickness;
				clusterElementStyle.radius = isNaN(clusterElementStyle.radius) ? sparkClusterStyle.sparkSize : clusterElementStyle.radius;
				
				graphics.lineStyle(clusterElementStyle.borderThickness, clusterElementStyle.borderColor, clusterElementStyle.borderAlpha);
			}
			else
				graphics.lineStyle(sparkClusterStyle.borderThickness, sparkClusterStyle.borderColor, sparkClusterStyle.borderAlpha);
			graphics.moveTo(0, 0);
			graphics.lineTo(this.m_distance, 0);
			
			//填充样式
			if(clusterElementStyle)
			{
				graphics.beginFill(clusterElementStyle.backgroundColor, clusterElementStyle.backgroundAlpha);
				graphics.drawCircle(this.m_distance, 0, clusterElementStyle.radius);
			}
			else
			{
				graphics.beginFill(sparkClusterStyle.backgroundColor, sparkClusterStyle.backgroundAlpha);
				graphics.drawCircle(this.m_distance, 0, this._radius);
			}
			graphics.endFill();
//			
			
//			var geopoint:GeoPoint = elementFeature.geometry as GeoPoint;
//			var clusterElementStyle:ClusterElementStyle = new ClusterElementStyle();
//			clusterElementStyle.draw(this,geopoint,this.m_distance);
			
		}
		
		public function updateFactor(factor:Number) : void
		{
			this.m_distance = SparkClusterContainer.sparkEasing(factor, 0, this._distance, 1);
		}
	}
	
	
}