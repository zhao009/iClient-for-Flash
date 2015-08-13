package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.events.ActionEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import spark.components.TextInput;
	
	
	use namespace sm_internal;
	
	/**
	 * ${actions_DrawText_Title}.
	 * <p>${actions_DrawText_Deccription}</p> 
	 * @see com.supermap.web.core.styles.TextStyle
	 * 
	 * 
	 */	
	public class DrawText extends DrawAction
	{
		private var _startMouseX:Number;
		private var _startMouseY:Number;
		private var _geoPoint:GeoPoint;
		private var _textInputBox:TextInput;
		private var _textStyle:TextStyle;
		private var _isResetKeyboardNavigation:Boolean;
		private var _mapMarker:Point2D;
		
		/**
		 * ${actions_DrawText_constructor_D} 
		 * @param map ${actions_DrawText_constructor_param_map}
		 * 
		 */		
		public function DrawText(map:Map)
		{
			super(map);
		}
		
		/**
		 * ${actions_DrawText_attribute_textStyle_D} 
		 * @return 
		 * 
		 */		
		public function get textStyle():TextStyle
		{
			return this._textStyle;
		}
		
		public function set textStyle(value:TextStyle):void
		{
			this._textStyle = value;
		}
		
		override sm_internal function addMapListeners():void
		{
			super.addMapListeners();
			if(this.map.stage)
				this.map.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		
		override sm_internal function removeMapListeners():void
		{
			super.removeMapListeners();
			if (this.map)
			{
				this._textStyle = null;
				if(this._textInputBox)
					this.commonEndHandler();
			}
			this.map.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function commonEndHandler():void
		{
			this._textInputBox.visible = false;
			this._textInputBox = null;
			this._geoPoint = null;
			actionStarted = false;
		}
				
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseClick(event:MouseEvent):void
		{
			
			if (!actionStarted)
			{
				actionStarted = true;
				if(!this._textStyle)
					this._textStyle = new TextStyle();
				
				var pointLocal:Point = this.tempLayer.globalToLocal(new Point(event.stageX, event.stageY));
				var pointBaseMap:Point = this.map.globalToLocal(new Point(event.stageX, event.stageY));
				
				this._startMouseX = pointBaseMap.x;
				this._startMouseY = pointBaseMap.y;
				
				_mapMarker = map.screenToMap(new Point(this._startMouseX, this._startMouseY));
				
				this.tempFeature = new Feature();
				startDraw(_mapMarker);
				
				_textInputBox = new TextInput();
				_textInputBox.width = 120;
				_textInputBox.height = 20;
				if(this._textStyle.placement == TextStyle.PLACEMENT_MIDDLE)
				{
					_textInputBox.x = pointLocal.x - 60;
					_textInputBox.y = pointLocal.y - 10;
				}
				else if(this._textStyle.placement == TextStyle.PLACEMENT_TOP)
				{
					_textInputBox.x = pointLocal.x - 60;
					_textInputBox.y = pointLocal.y - 20;
				}
				else if(this._textStyle.placement == TextStyle.PLACEMENT_BOTTOM)
				{
					_textInputBox.x = pointLocal.x - 60;
					_textInputBox.y = pointLocal.y;
				}
				else if(this._textStyle.placement == TextStyle.PLACEMENT_LEFT)
				{
					_textInputBox.x = pointLocal.x;
					_textInputBox.y = pointLocal.y - 10;
				}
				else
				{
					_textInputBox.x = pointLocal.x - 120;
					_textInputBox.y = pointLocal.y - 10;
				}

				_textInputBox.setStyle("borderStyle", "none");
				_textInputBox.alpha = 0.7;
				this.tempLayer.addChild(_textInputBox);
				if(this.map.keyboardNavigationEnabled)
				{
					this._isResetKeyboardNavigation = true;
					this.map.keyboardNavigationEnabled = false;
				}
				_textInputBox.setFocus();
			}
			else
			{
				endDrawText();
			}
		}
		
		private function endDrawText():void
		{
			if (_textInputBox)
			{
				if (_textInputBox.text)
				{
					this._textStyle.text = "";
					
					this._geoPoint = new GeoPoint(_mapMarker.x, _mapMarker.y);
					this.tempFeature.geometry = this._geoPoint;
					//text怎能直接作为attributes呢，应该为key-value格式，byzyn
					this.tempFeature.attributes = {
						"TEXT":_textInputBox.text
					}
					var textStyleClone:TextStyle = this._textStyle.clone() as TextStyle;
					textStyleClone.text = _textInputBox.text;
					this.tempFeature.style = textStyleClone;
					
					this.tempLayer.addFeature(this.tempFeature);
					this.endDraw(_mapMarker);
				}
				else
				{
					this.tempFeature = null;
				}
				
				//byzyn0612，添加_textInputBox是否为空的判断，因为用户如果在DrawEnd事件中对Map.action进行了change，调用this.removeMapListeners()方法
				//_textInputBox会被置为null，当执行完成DrawEnd的侦听函数再走到这里时，_textInputBox不存在就会报错
				if(_textInputBox)
					this.commonEndHandler();
				
				if(this._isResetKeyboardNavigation)
					this.map.keyboardNavigationEnabled = true;
				
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			var keyCode:int = event.keyCode;
			if(keyCode === 13)
			{
				endDrawText();
			}
		}
	}
}