package com.supermap.web.utils.serverTypes
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServerType_ServerStyle_Tile}.
	 * <p>${iServerJava6R_ServerType_ServerStyle_Description}</p> 
	 * 
	 */	
	public class ServerStyle
	{
		private var _fillBackColor:ServerColor = new ServerColor(255, 255, 255);
		private var _fillForeColor:ServerColor = new ServerColor(255, 0, 0);
		private var _fillBackOpaque:Boolean;
		private var _fillGradientMode:String = FillGradientMode.NONE;
		private var _fillGradientAngle:Number = 0;
		private var _fillGradientOffsetRatioX:Number = 0;
		private var _fillGradientOffsetRatioY:Number = 0;
		private var _fillOpaqueRate:int = 100;
		
		private var _fillSymbolID:int = 0;
		private var _lineColor:ServerColor = new ServerColor(0, 0, 0);
		private var _lineSymbolID:int = 0;
		private var _lineWidth:Number = 1;
		private var _markerAngle:Number = 0;
		private var _markerSize:Number = 1;
		private var _markerSymbolID:int = -1;
		
		/**
		 * ${iServerJava6R_ServerType_ServerStyle_constructor_None_D} 
		 * 
		 */		
		public function ServerStyle()
		{
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_MarkerSymbolID_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_MarkerSymbolID_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get markerSymbolID():int
		{
			return _markerSymbolID;
		}

		public function set markerSymbolID(value:int):void
		{
			_markerSymbolID = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_MarkerSize_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_MarkerSize_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get markerSize():Number
		{
			return _markerSize;
		}

		public function set markerSize(value:Number):void
		{
			_markerSize = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_MarkerAngle_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_MarkerAngle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get markerAngle():Number
		{
			return _markerAngle;
		}

		public function set markerAngle(value:Number):void
		{
			_markerAngle = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_LineWidth_D} 
		 * @return 
		 * 
		 */		
		public function get lineWidth():Number
		{
			return _lineWidth;
		}

		public function set lineWidth(value:Number):void
		{
			_lineWidth = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_LineSymbolID_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_LineSymbolID_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get lineSymbolID():int
		{
			return _lineSymbolID;
		}

		public function set lineSymbolID(value:int):void
		{
			_lineSymbolID = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_LineColor_D} 
		 * @return 
		 * 
		 */		
		public function get lineColor():ServerColor
		{
			return _lineColor;
		}

		public function set lineColor(value:ServerColor):void
		{
			_lineColor = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillSymbolID_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillSymbolID_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fillSymbolID():int
		{
			return _fillSymbolID;
		}

		public function set fillSymbolID(value:int):void
		{
			_fillSymbolID = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillOpaqueRate_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillOpaqueRate_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fillOpaqueRate():int
		{
			return _fillOpaqueRate;
		}

		public function set fillOpaqueRate(value:int):void
		{
			_fillOpaqueRate = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientOffsetRatioY_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientOffsetRatioY_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fillGradientOffsetRatioY():Number
		{
			return _fillGradientOffsetRatioY;
		}

		public function set fillGradientOffsetRatioY(value:Number):void
		{
			_fillGradientOffsetRatioY = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientOffsetRatioX_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientOffsetRatioX_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fillGradientOffsetRatioX():Number
		{
			return _fillGradientOffsetRatioX;
		}

		public function set fillGradientOffsetRatioX(value:Number):void
		{
			_fillGradientOffsetRatioX = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientAngle_D}.
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientAngle_remarks}</p> 
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientAngle_remarks1}</p> 
		 * <p>${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientAngle_remarks2}</p>
		 * @return 
		 * 
		 */		
		public function get fillGradientAngle():Number
		{
			return _fillGradientAngle;
		}

		public function set fillGradientAngle(value:Number):void
		{
			_fillGradientAngle = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillGradientMode_D} 
		 * @see FillGradientMode
		 * @default FillGradientMode.NONE
		 * @return 
		 * 
		 */		
		public function get fillGradientMode():String
		{
			return _fillGradientMode;
		}

		public function set fillGradientMode(value:String):void
		{
			_fillGradientMode = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillBackOpaque_D} 
		 * @return 
		 * 
		 */		
		public function get fillBackOpaque():Boolean
		{
			return _fillBackOpaque;
		}

		public function set fillBackOpaque(value:Boolean):void
		{
			_fillBackOpaque = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_FillForeColor_D} 
		 * @return 
		 * 
		 */		
		public function get fillForeColor():ServerColor
		{
			return _fillForeColor;
		}

		public function set fillForeColor(value:ServerColor):void
		{
			_fillForeColor = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerStyle_attribute_fillBackColor_D} 
		 * @return 
		 * 
		 */		
		public function get fillBackColor():ServerColor
		{
			return _fillBackColor;
		}

		public function set fillBackColor(value:ServerColor):void
		{
			_fillBackColor = value;
		}

		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"fillBackColor\":" + this.fillBackColor.toJSON() + ",";
			
			json += "\"fillForeColor\":" + this.fillForeColor.toJSON() + ",";
			
			json += "\"fillBackOpaque\":" + this.fillBackOpaque + ",";
			
			json += "\"fillGradientMode\":" + "\"" + this.fillGradientMode.toString() + "\"" + ",";
			
			json += "\"fillGradientAngle\":" + this.fillGradientAngle.toString() + ",";
			
			json += "\"fillGradientOffsetRatioX\":" + this.fillGradientOffsetRatioX.toString() + ",";
			
			json += "\"fillGradientOffsetRatioY\":" + this.fillGradientOffsetRatioY.toString() + ",";
			
			
			json += "\"fillOpaqueRate\":" + this.fillOpaqueRate.toString() + ",";
			
			json += "\"fillSymbolID\":" + this.fillSymbolID.toString() + ",";
			
			json += "\"lineColor\":" + this.lineColor.toJSON() + ",";
			
			json += "\"lineSymbolID\":" + this.lineSymbolID.toString() + ",";
			
			json += "\"lineWidth\":" + this.lineWidth.toString() + ",";
			
			json += "\"markerAngle\":" + this.markerAngle.toString() + ",";
			
			
			json += "\"markerSize\":" + this.markerSize.toString() + ",";
			
			json += "\"markerSymbolID\":" + this.markerSymbolID.toString();
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ServerStyle
		{
			var serverStyle:ServerStyle;
			if(object)
			{
				serverStyle = new ServerStyle();
				
				serverStyle.fillBackColor = ServerColor.fromJson(object.fillBackColor);
				serverStyle.fillForeColor = ServerColor.fromJson(object.fillForeColor);
				
				serverStyle.fillGradientMode = object.fillGradientMode;
				serverStyle.fillBackOpaque = object.fillBackOpaque;
				
				serverStyle.fillGradientAngle = object.fillGradientAngle;
				serverStyle.fillGradientOffsetRatioX = object.fillGradientOffsetRatioX;
				
				serverStyle.fillGradientOffsetRatioY = object.fillGradientOffsetRatioY;
				serverStyle.fillOpaqueRate = object.fillOpaqueRate;
				
				serverStyle.fillSymbolID = object.fillSymbolID;
				serverStyle.lineColor = ServerColor.fromJson(object.lineColor);
				
				serverStyle.lineSymbolID = object.lineSymbolID;
				serverStyle.lineWidth = object.lineWidth;
				
				serverStyle.markerAngle = object.markerAngle;
				serverStyle.markerSize = object.markerSize;
				
				serverStyle.markerSymbolID = object.markerSymbolID;
			}
			return serverStyle;
		}
	}
}