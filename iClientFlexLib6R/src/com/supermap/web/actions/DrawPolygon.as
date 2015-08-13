package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	
	use namespace sm_internal;

	/**
	 * ${actions_DrawPolygon_Title}.
	 * <p>${actions_DrawPolygon_Deccription}</p> 
	 * 
	 * 
	 */	
	public class DrawPolygon extends DrawAction
	{
		private var _point2Ds:Array;
		private var _geoRegion:GeoRegion;
		//存储多捕捉中间需要加入的节点
		private var _nodeArray:Array = [];
		
		/**
		 * ${actions_DrawPolygon_constructor_D}.
		 * @param map ${actions_DrawPolygon_constructor_param_map}
		 * 
		 */		
		public function DrawPolygon(map:Map)
		{
			super(map); 
			this.style = new PredefinedFillStyle();
		}

		override sm_internal function removeMapListeners():void
		{
			super.removeMapListeners();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseNextClick)
		}
		
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseClick(event:MouseEvent):void
		{
			_point2Ds = [];
			this.actionStarted = true;
			this.map.setFocus();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
			map.layerHolder.addEventListener(MouseEvent.CLICK, this.onMouseNextClick);
			
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			if(this.snap)
			{
				point2D = this.snap.getSnapPoint(point2D,true);
				
			}
			this.tempFeature = new Feature();
			startDraw(point2D);
			this._geoRegion = new GeoRegion();
			
			this._point2Ds.push(point2D, point2D);
			this._geoRegion.parts.push(this._point2Ds.concat([]));    //此处不能直接将this._point2Ds的引用放到this._geoRegion.parts里面，以防止其他地方（比如裁剪算法）对其进行修改，所以必须给它赋一个副本
			this.tempFeature.style = this.style;
			this.tempFeature.geometry = this._geoRegion;
			this.tempLayer.addFeature(this.tempFeature);
		}
		
		private function onMouseNextClick(event:MouseEvent):void
		{
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			if(this.snap)
			{
				point2D = this.snap.getSnapPoint(point2D,true);
			}
			_nodeArray = [];
			this._point2Ds.pop();
			this._point2Ds.push(point2D, point2D);
			//this._point2Ds.push(point2D);
			this._geoRegion.parts = [this._point2Ds.concat([])];      
			this.tempFeature.refresh();
			dispatchEvent(new DrawEvent(DrawEvent.DRAW_UPDATE, this.tempFeature));
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseMove(event:MouseEvent):void
		{
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			if(this.snap)
			{
				point2D = this.snap.getSnapPoint(point2D);
				if(_nodeArray.length>0)
				{
					this._point2Ds.splice(this._point2Ds.length-_nodeArray.length-1,_nodeArray.length);
				}
				_nodeArray = this.snap.nodeArray;

			}
			//必须在snap的后面，不然刚开始绘制的起始点无法使用捕捉
			if (!this.actionStarted)
			{
				return;
			}

			if (this.map.isTweening || this.map.isPanning)
			{
				return;
			}
			
			
//			if(this._point2Ds.length > 2)
//				this._point2Ds.pop();
			this._point2Ds[(this._point2Ds.length - 1)] = point2D;
			if(_nodeArray.length>0)
			{
				var po:Point2D = this._point2Ds.pop() as Point2D;
				this._point2Ds = this._point2Ds.concat(_nodeArray);
				this._point2Ds.push(po);
			}
//			this._point2Ds.push(this._point2Ds[0]);
			this._geoRegion.parts = [this._point2Ds.concat([])];
//			this._geoRegion.parts = this._geoRegion.parts;
			this.tempFeature.refresh();
		}
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseDoubleClick(event:MouseEvent):void
		{
			if (!this.actionStarted)
			{
				return;
			}
			if(this._point2Ds.length <= 2)
			{
				return;
			}
			_nodeArray = [];
			var endPoint:Point2D = this._point2Ds.pop();
			this._point2Ds.push(this._point2Ds[0]);
			
			//删除中间重复的点
			/*var startPoint:Point2D = this._point2Ds.shift();
			this._point2Ds.pop();
			var ary:Array = [];
			ary.push(startPoint);
			var len:int = this._point2Ds.length;
			for(var i:int = 0; i < int(len * .5); i++)
			{
				ary.push(this._point2Ds[2*i]);
			}
			this._point2Ds = ary;
			this._geoRegion.parts = [ary];*/
			//删除完毕
			
			this._geoRegion.parts = [this._point2Ds.concat([])];
			this.actionStarted = false;
			this._point2Ds = [];
			event.stopPropagation();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseNextClick);
			map.layerHolder.addEventListener(MouseEvent.CLICK, this.onMouseClick);
			
			this.endDraw(endPoint);
			
			
		}
	}
}