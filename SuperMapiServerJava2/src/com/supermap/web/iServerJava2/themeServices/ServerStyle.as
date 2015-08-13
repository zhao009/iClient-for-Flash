package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_themeServices_ServerStyle_Title}.
	 * <p>${iServer2_themeServices_ServerStyle_Description}</p> 
	 * 
	 * 
	 */		
	public class ServerStyle
	{
		private var _fillBackColor:ServerColor = new ServerColor(255, 255, 255);		
		private var _fillForeColor:ServerColor = new ServerColor(255, 0, 0);		
		private var _fillBackOpaque:Boolean;	
		private var _fillGradientMode:int = FillGradientMode.NONE;
		private var _fillGradientAngle:Number = 0;
		private var _fillGradientOffsetRatioX:Number = 0;
		private var _fillGradientOffsetRatioY:Number = 0;
		private var _fillOpaqueRate:int = 100;
		private var _fillSymbolID:int = 0;
		private var _lineColor:ServerColor = new ServerColor(0, 0, 0);	
		private var _lineSymbolID:int = 0;	
		private var _lineWidth:Number = 0.01;	
		private var _markerAngle:Number = 0;	
		private var _markerSize:Number = 1;	
		private var _markerSymbolID:int = -1;
		
		/**
		 * ${iServer2_themeServices_ServerStyle_constructor_None_D} 
		 * 
		 */		
		public function ServerStyle()
		{
		}		
		
		/**
		 * ${iServer2_themeServices_ServerStyle_attribute_markerSymbolID_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_markerSymbolID_remarks}</p>
		 * @default -1
		 *  
		 */
		public function get markerSymbolID():int
		{
			return _markerSymbolID;
		}

		/**
		 * @private
		 */
		public function set markerSymbolID(value:int):void
		{
			_markerSymbolID = value;
		}

		/**
		 * ${iServer2_themeServices_ServerStyle_attribute_markerSize_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_markerSize_remarks}</p>
		 * @default 1 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_markerAngle_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_markerAngle_remarks}</p>
		 * @default 0 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_lineWidth_D} 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_lineSymbolID_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_lineSymbolID_remarks}</p> 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_lineColor_D} 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillSymbolID_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillSymbolID_remarks}</p>
		 * @default 0 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillOpaqueRate_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillOpaqueRate_remarks}</p>
		 * @default 100 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillGradientOffsetRatioY_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillGradientOffsetRatioY_remarks}</p> 
		 * @default 0
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillGradientOffsetRatioX_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillGradientOffsetRatioX_remarks}</p> 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillGradientAngle_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillGradientAngle_remarks}</p> 
		 * @default 0
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillGradientMode_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillGradientMode_remarks}</p>
		 * @see FillGradientMode#NONE  
		 */
		public function get fillGradientMode():int
		{
			return _fillGradientMode;
		}

		public function set fillGradientMode(value:int):void
		{
			_fillGradientMode = value;
		}

		/**
		 * ${iServer2_themeServices_ServerStyle_attribute_fillBackOpaque_D} 
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillForeColor_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillForeColor_remarks}</p>
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
		 * ${iServer2_themeServices_ServerStyle_attribute_fillBackColor_D}.
		 * <p>${iServer2_themeServices_ServerStyle_attribute_fillBackColor_remarks}</p> 
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
			
			json += "\"fillGradientMode\":" + this.fillGradientMode.toString() + ",";
			
			json += "\"fillGradientAngle\":" + this.fillGradientAngle.toString() + ",";
			
			json += "\"fillGradientOffsetRatioX\":" + this.fillGradientOffsetRatioX.toString() + ",";
			
			json += "\"fillGradientOffsetRatioY\":" + this.fillGradientOffsetRatioY.toString() + ",";
			
			
			json += "\"fillOpaqueRate\":" + this.fillOpaqueRate.toString() + ",";
			
			json += "\"fillSymbolID\":" + this.fillSymbolID.toString() + ",";
			
			json += "\"lineColor\":" + this.lineColor.toJSON() + ",";
			
			json += "\"lineSymbolID\":" + this.lineSymbolID.toString() + ",";
			
			json += "\"lineWidth\":" + this.lineWidth.toString() + ",";
			
			json += "\"markerAngle\":" + this.markerAngle.toString() + ",";
			
			if(this.markerSize < 1)
				this.markerSize = 1;
			
			json += "\"markerSize\":" + this.markerSize.toString() + ",";
			
			json += "\"markerSymbolID\":" + this.markerSymbolID.toString();
			
			if(json.length > 0)
				json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toServerStyle(object:Object):ServerStyle
		{
			var serverStyle:ServerStyle;
			if(object)
			{
				serverStyle = new ServerStyle();
				serverStyle.fillBackColor = ServerColor.toServerColor(object.fillBackColor);
				serverStyle.fillBackOpaque = object.fillBackOpaque;
				serverStyle.fillForeColor = ServerColor.toServerColor(object.fillForeColor);
				serverStyle.fillGradientAngle = object.fillGradientAngle;
				serverStyle.fillGradientMode = object.fillGradientMode;
				serverStyle.fillGradientOffsetRatioX = object.fillGradientOffsetRatioX;
				serverStyle.fillGradientOffsetRatioY = object.fillGradientOffsetRatioY;
				serverStyle.fillOpaqueRate = object.fillOpaqueRate;
				serverStyle.fillSymbolID = object.fillSymbolID;
				serverStyle.lineColor = ServerColor.toServerColor(object.lineColor);
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