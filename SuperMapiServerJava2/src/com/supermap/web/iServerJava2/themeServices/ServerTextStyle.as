package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ServerTextStyle_Title} 
	 * 
	 * 
	 */	
	public class ServerTextStyle
	{
		//对齐方式
		private var _align:int = ServerTextAlignment.BASE_LINE_CENTER;		
		private var _bgColor:ServerColor = new ServerColor(255, 0, 0);		
		private var _color:ServerColor = new ServerColor(255, 255, 255);		
		private var _fixedSize:Boolean = false;		
		private var _fixedTextSize:int = 0;		
		private var _fontHeight:Number = 1;		
		private var _fontWidth:Number = 1;		
		private var _fontWeight:Number = 100;		
		private var _fontName:String = "宋体";		
		private var _bold:Boolean = false;		
		private var _italic:Boolean = false; 		
		private var _shadow:Boolean = false;		
		private var _stroke:Boolean = false;		
		private var _outline:Boolean = false;		
		private var _transparent:Boolean = false;		
		private var _underline:Boolean = false;	
		private var _rotation:Number = 0;
		
		/**
		 * ${iServer2_themeServices_ServerTextStyle_constructor_None_D_as} 
		 * 
		 */		
		public function ServerTextStyle()
		{
		}
		
		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_rotation_D}
		 * @default 0 
		 * @return 
		 * 
		 */		
		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_underline_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get underline():Boolean
		{
			return _underline;
		}

		public function set underline(value:Boolean):void
		{
			_underline = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_transparent_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get transparent():Boolean
		{
			return _transparent;
		}

		public function set transparent(value:Boolean):void
		{
			_transparent = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_outline_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get outline():Boolean
		{
			return _outline;
		}

		public function set outline(value:Boolean):void
		{
			_outline = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_stroke_D} 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get stroke():Boolean
		{
			return _stroke;
		}

		public function set stroke(value:Boolean):void
		{
			_stroke = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_shadow_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get shadow():Boolean
		{
			return _shadow;
		}

		public function set shadow(value:Boolean):void
		{
			_shadow = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_italic_D} 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get italic():Boolean
		{
			return _italic;
		}

		public function set italic(value:Boolean):void
		{
			_italic = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_bold_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get bold():Boolean
		{
			return _bold;
		}

		public function set bold(value:Boolean):void
		{
			_bold = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_fontName_D} 
		 * @return 
		 * 
		 */		
		public function get fontName():String
		{
			return _fontName;
		}

		public function set fontName(value:String):void
		{
			_fontName = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_fontWeight_D}
		 * @default 100 
		 * @return 
		 * 
		 */		
		public function get fontWeight():Number
		{
			return _fontWeight;
		}

		public function set fontWeight(value:Number):void
		{
			_fontWeight = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_fontWidth_D}
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get fontWidth():Number
		{
			return _fontWidth;
		}

		public function set fontWidth(value:Number):void
		{
			_fontWidth = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_fontHeight_D}
		 * @default 1 
		 * @return 
		 * 
		 */		
		public function get fontHeight():Number
		{
			return _fontHeight;
		}

		public function set fontHeight(value:Number):void
		{
			_fontHeight = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_fixedTextSize_D} 
		 * @see #fixedSize
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get fixedTextSize():int
		{
			return _fixedTextSize;
		}

		public function set fixedTextSize(value:int):void
		{
			_fixedTextSize = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_fixedSize_D}.
		 * <p>${iServer2_themeServices_ServerTextStyle_attribute_fixedSize_remarks}</p>
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get fixedSize():Boolean
		{
			return _fixedSize;
		}

		public function set fixedSize(value:Boolean):void
		{
			_fixedSize = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_color_D}
		 * @default (255,0,0) 
		 * @return 
		 * 
		 */		
		public function get color():ServerColor
		{
			return _color;
		}

		public function set color(value:ServerColor):void
		{
			_color = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_bgColor_D} 
		 * @default (255,0,0)
		 * @return 
		 * 
		 */		
		public function get bgColor():ServerColor
		{
			return _bgColor;
		}

		public function set bgColor(value:ServerColor):void
		{
			_bgColor = value;
		}

		/**
		 * ${iServer2_themeServices_ServerTextStyle_attribute_align_D}
		 * @default ServerTextAlignment.BASE_LINE_CENTER
		 * @see ServerTextAlignment
		 * @return 
		 * 
		 */		
		public function get align():int
		{
			return _align;
		}

		public function set align(value:int):void
		{
			_align = value;
		}

		sm_internal function toJSON():String
		{
			var json:String = "";
			if(this.align >= 0)
				json += "\"align\":" + this.align + "," ;
			
			json += "\"bgColor\":" + this.bgColor.toJSON() + "," ;
			
			json += "\"color\":" + this.color.toJSON() + "," ;
			
			json += "\"fixedSize\":" + this.fixedSize + ",";
			
			json += "\"fixedTextSize\":" + this.fixedTextSize + ",";
			
			json += "\"fontHeight\":" + this.fontHeight + ",";
			
			json += "\"fontWidth\":" + this.fontWidth + ",";
			
			json += "\"fontWeight\":" + this.fontWeight + ",";
			
			json += "\"fontName\":" + "\"" + this.fontName + "\",";
			
			json += "\"bold\":" + this.bold + ",";
			
			json += "\"italic\":" + this.italic + ",";
			
			json += "\"shadow\":" + this.shadow + ",";
			
			json += "\"stroke\":" + this.stroke + ",";
			
			json += "\"outline\":" + this.outline + ",";
			
			json += "\"transparent\":" + this.transparent + ",";
			
			json += "\"underline\":" + this.underline + ",";
			
			json += "\"rotation\":" + this.rotation;
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toServerTextStyle(object:Object):ServerTextStyle
		{
			var serverTextStyle:ServerTextStyle;
			if(object)
			{
				serverTextStyle = new ServerTextStyle();
				serverTextStyle.align = object.align;
				serverTextStyle.bgColor = ServerColor.toServerColor(object.bgColor);
				serverTextStyle.bold = object.bold;
				serverTextStyle.color = ServerColor.toServerColor(object.color);
				serverTextStyle.fixedSize = object.fixedSize;
				serverTextStyle.fixedTextSize = object.fixedTextSize;
				serverTextStyle.fontHeight = object.fontHeight;
				serverTextStyle.fontName = object.fontName;
				serverTextStyle.fontWeight = object.fontWeight;
				serverTextStyle.fontWidth = object.fontWidth;
				serverTextStyle.italic = object.italic;
				serverTextStyle.outline = object.outline;
				serverTextStyle.rotation = object.rotation;
				serverTextStyle.shadow = object.shadow;
				serverTextStyle.stroke = object.stroke;
				serverTextStyle.transparent = object.transparent;
				serverTextStyle.underline = object.underline;
			}
			
			return serverTextStyle;
		}
	}
}