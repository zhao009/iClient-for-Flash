package  com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	
	use namespace sm_internal;
	
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class ZoomEffect extends UIComponent
	{
		/**地图放大动画效果*/
		[Embed(source="zoomIn.swf")]
		private static var zoomIn:Class;	
		/**地图缩小动画效果*/
		[Embed(source="zoomOut.swf")]
		private static var zoomOut:Class;	
		/**动画调用类*/
		private var mc:MovieClip;
		/**地图设置*/
		private var _map:Map;
		
		/**鼠标动画时间控制*/
		private var timer:Timer = new Timer(480,1);
		
		public function ZoomEffect(map:Map)
		{
			super();
			this._map = map;
		}
		
		private function removeEffect(e:TimerEvent):void
		{
			this.stop();
			timer.removeEventListener(TimerEvent.TIMER,removeEffect);
			timer.stop();
		}
		
		private function mouse_position():Point
		{
			var mapScreenPoint:Point = this._map.globalToLocal(new Point(this.mouseX, this.mouseY));
			var mousex:Number = mapScreenPoint.x;
			var mousey:Number = mapScreenPoint.y;
			
			var swfwidth:Number = 52;
			var swfheight:Number = 40;
			
			var px:Number = this._map.mouseX - swfwidth;
			var py:Number = this._map.mouseY - swfheight;
			return new Point(px, py);
		}
		
		public function addToMap(isZoomIn:Boolean):void
		{
			if(mc && this.contains(mc))
			{
				this.stop();
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER, removeEffect);
			}
			
			this.mc = new MovieClip();
			var effectPosition:Point = mouse_position();
			this.mc.x = effectPosition.x;
			this.mc.y = effectPosition.y;
			//			this.mc.x = 600;
			//			this.mc.y = 500;
			
			if(isZoomIn)
			{
				mc.addChild(new zoomIn() as DisplayObject);
			}else{
				mc.addChild(new zoomOut() as DisplayObject);
			}
			this.addChild(mc);
			if(!_map.screenContainer.contains(this))
				_map.screenContainer.addElement(this);
			
			timer.addEventListener(TimerEvent.TIMER,removeEffect);
			timer.start();
		}
		
		public function stop():void
		{
			this.mc.stop();
			this.removeChild(mc);
			this.mc = null;
		}
		
	}
}