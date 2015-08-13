package com.supermap.web.utils.serverTypes
{
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.sm_internal;
	
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServerTextStyle_Title} 
	 * 
	 */	
	public class ServerTextStyle
	{
		private var _align:String = TextAlignment.BASELINECENTER;
		private var _backColor:ServerColor = new ServerColor(0,0,255);
		private var _foreColor:ServerColor = new ServerColor(255,0,0);
		private var _backOpaque:Boolean = false;
		private var _sizeFixed:Boolean = true;//false
//		private var _fixedTextSize:int = 0;
		private var _fontHeight:Number = 10;//3
		private var _fontWidth:Number = 0;//3
		private var _fontWeight:Number = 400;//1
		private var _fontName:String = "Times New Roman";
		private var _bold:Boolean = false;
		private var _italic:Boolean = false;
		private var _italicAngle:Number = 0;
		private var _shadow:Boolean = false;
		private var _strikeout:Boolean = false;
		private var _outline:Boolean = false;
		private var _fontScale:Number = 1;
		private var _opaqueRate:int = 0;
		private var _underline:Boolean = false;
		private var _rotation:Number = 0;

		/**
		 * ${iServerJava6R_ServerTextStyle_constructor_None_D} 
		 * 
		 */		
		public function ServerTextStyle()
		{
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_rotation_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_underline_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_opaqueRate_D} 
		 * @return 
		 * 
		 */		
		public function get opaqueRate():int
		{
			return _opaqueRate;
		}

		public function set opaqueRate(value:int):void
		{
			_opaqueRate = value;
		}

		public function get fontScale():Number
		{
			return _fontScale;
		}

		public function set fontScale(value:Number):void
		{
			_fontScale = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_outline_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_strikeout_D} 
		 * @return 
		 * 
		 */		
		public function get strikeout():Boolean
		{
			return _strikeout;
		}

		public function set strikeout(value:Boolean):void
		{
			_strikeout = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_shadow_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_italicAngle_D}.
		 * <p>${iServerJava6R_ServerTextStyle_attribute_italicAngle_remarks}</p> 
		 * @see #italic
		 * @return 
		 * 
		 */		
		public function get italicAngle():Number
		{
			return _italicAngle;
		}

		public function set italicAngle(value:Number):void
		{
			_italicAngle = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_italic_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_bold_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_fontName_D} 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_fontWeight_D} 
		 * <p>${iServerJava6R_ServerTextStyle_attribute_fontWeight_remarks}</p>
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
		 * ${iServerJava6R_ServerTextStyle_attribute_fontWidth_D}.
		 * <p>${iServerJava6R_ServerTextStyle_attribute_fontWidth_remarks}</p> 
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
		 * ${iServerJava6R_ServerTextStyle_attribute_fontHeight_D}.
		 * <p>${iServerJava6R_ServerTextStyle_attribute_fontHeight_remarks}</p> 
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

//		public function get fixedTextSize():int
//		{
//			return _fixedTextSize;
//		}
//
//		public function set fixedTextSize(value:int):void
//		{
//			_fixedTextSize = value;
//		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_sizeFixed_D}.
		 * <p>${iServerJava6R_ServerTextStyle_attribute_sizeFixed_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get sizeFixed():Boolean
		{
			return _sizeFixed;
		}

		public function set sizeFixed(value:Boolean):void
		{
			_sizeFixed = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_backOpaque_D} 
		 * @return 
		 * 
		 */		
		public function get backOpaque():Boolean
		{
			return _backOpaque;
		}

		public function set backOpaque(value:Boolean):void
		{
			_backOpaque = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_foreColor_D} 
		 * @return 
		 * 
		 */		
		public function get foreColor():ServerColor
		{
			return _foreColor;
		}

		public function set foreColor(value:ServerColor):void
		{
			_foreColor = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_bgColor_D} 
		 * @return 
		 * 
		 */		
		public function get backColor():ServerColor
		{
			return _backColor;
		}

		public function set backColor(value:ServerColor):void
		{
			_backColor = value;
		}

		/**
		 * ${iServerJava6R_ServerTextStyle_attribute_align_D} 
		 * @see TextAlignment
		 * @return 
		 * 
		 */		
		public function get align():String
		{
			return _align;
		}

		public function set align(value:String):void
		{
			_align = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"align\":" + "\"" + this.align + "\"" + "," ;
			
			json += "\"backColor\":" + this.backColor.toJSON() + "," ;
			
			json += "\"foreColor\":" + this.foreColor.toJSON() + "," ;
			
			json += "\"backOpaque\":" + this.backOpaque + "," ;
			
			json += "\"sizeFixed\":" + this.sizeFixed + ",";
			
//			json += "\"fixedTextSize\":" + this.fixedTextSize + ",";
			
			json += "\"fontHeight\":" + this.fontHeight + ",";
			
			json += "\"fontWidth\":" + this.fontWidth + ",";
			
			json += "\"fontWeight\":" + this.fontWeight + ",";
			
			json += "\"fontName\":" + "\"" + this.fontName + "\",";
			
			json += "\"fontScale\":" +  this.fontScale +",";
			
			json += "\"bold\":" + this.bold + ",";
			
			json += "\"italic\":" + this.italic + ",";
			
			json += "\"italicAngle\":" + this.italicAngle + ",";
			
			json += "\"shadow\":" + this.shadow + ",";
			
			json += "\"strikeout\":" + this.strikeout + ",";
			
			json += "\"opaqueRate\":" + this.opaqueRate + ",";
			
			json += "\"outline\":" + this.outline + ",";		
			
			json += "\"underline\":" + this.underline + ",";
			
			json += "\"rotation\":" + this.rotation;
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ServerTextStyle
		{
			var serverTextStyle:ServerTextStyle;
			if(object)
			{
				serverTextStyle = new ServerTextStyle();				
				serverTextStyle.align = object.align;
				serverTextStyle.backColor = ServerColor.fromJson(object.backColor);
				serverTextStyle.backOpaque = object.backOpaque;
				serverTextStyle.bold = serverTextStyle.bold;
				serverTextStyle.fontHeight = object.fontHeight;
				serverTextStyle.fontName = object.fontName;
				serverTextStyle.fontWeight = object.fontWeight;
				serverTextStyle.fontWidth = object.fontWidth;
				serverTextStyle.foreColor = ServerColor.fromJson(object.foreColor);
				serverTextStyle.italic = object.italic;
				serverTextStyle.italicAngle = object.italicAngle;
				serverTextStyle.opaqueRate = object.opaqueRate;
				serverTextStyle.outline = object.outline;
				serverTextStyle.rotation = object.rotation;
				serverTextStyle.shadow = object.shadow;
				serverTextStyle.sizeFixed = object.sizeFixed;
				serverTextStyle.strikeout = object.strikeout;				
				serverTextStyle.underline = object.underline;
				serverTextStyle.fontScale = object.fontScale;
				
			}			
			return serverTextStyle;
		}
		
		sm_internal static function serverStyleToClientStyle(object:ServerTextStyle):TextStyle
		{
			var textStyle:TextStyle = new TextStyle();
			if(object)
			{
				var textFormat:TextFormat = new TextFormat;
				switch(object.align)
				{
					case TextAlignment.BASELINECENTER:
					{
						textStyle.placement = TextStyle.PLACEMENT_BASELINECENTER;
//						textFormat.align = TextFormatAlign.CENTER;
						break;
					}
					case TextAlignment.BASELINELEFT:
					{
						textStyle.placement = TextStyle.PLACEMENT_BASELINELEFT;
//						textFormat.align = TextFormatAlign.LEFT;
						break;
					}
					case TextAlignment.BASELINERIGHT:
					{
						textStyle.placement = TextStyle.PLACEMENT_BASELINERIGHT;
//						textFormat.align = TextFormatAlign.RIGHT;
						break;
					}
					case TextAlignment.BOTTOMCENTER:
					{
						textStyle.placement = TextStyle.PLACEMENT_TOP;
//						textFormat.align = TextFormatAlign.CENTER;
						break;
					}
					case TextAlignment.BOTTOMLEFT:
					{
						textStyle.placement = TextStyle.PLACEMENT_TOPLEFT;
//						textFormat.align = TextFormatAlign.LEFT;
						break;
					}
					case TextAlignment.BOTTOMRIGHT:
					{
						textStyle.placement = TextStyle.PLACEMENT_TOPRIGHT;
//						textFormat.align = TextFormatAlign.RIGHT;
						break;
					}
					case TextAlignment.MIDDLECENTER:
					{
						textStyle.placement = TextStyle.PLACEMENT_MIDDLE;
//						textFormat.align = TextFormatAlign.CENTER;
						break;
					}
					case TextAlignment.MIDDLELEFT:
					{
						textStyle.placement = TextStyle.PLACEMENT_LEFT;
//						textFormat.align = TextFormatAlign.LEFT;
						break;
					}
					case TextAlignment.MIDDLERIGHT:
					{
						textStyle.placement = TextStyle.PLACEMENT_RIGHT;
//						textFormat.align = TextFormatAlign.RIGHT;
						break;
					}
					case TextAlignment.TOPCENTER:
					{
						textStyle.placement = TextStyle.PLACEMENT_BOTTOM;
//						textFormat.align = TextFormatAlign.CENTER;
						break;
					}
					case TextAlignment.TOPLEFT:
					{
						textStyle.placement = TextStyle.PLACEMENT_BOTTOMLEFT;
//						textFormat.align = TextFormatAlign.LEFT;
						break;
					}
					case TextAlignment.TOPRIGHT:
					{
						textStyle.placement = TextStyle.PLACEMENT_BOTTOMRIGHT;
//						textFormat.align = TextFormatAlign.RIGHT;
						break;
					}
					default:
					{
						textStyle.placement = TextStyle.PLACEMENT_MIDDLE;
//						textFormat.align = TextFormatAlign.CENTER;
						break;
					}
				}
				textFormat.bold = object.bold;
				textFormat.font = object.fontName;
				textFormat.italic = object.italic;
				textFormat.size = object.fontHeight >= object.fontWidth ? object.fontHeight : object.fontWeight;
				textFormat.underline = object.underline;
				
				textStyle.textFormat = textFormat;
				textStyle.size = object.fontHeight >= object.fontWidth ? object.fontHeight : object.fontWeight;
				textStyle.angle = object.rotation;
				textStyle.background = object.backOpaque;
				textStyle.backgroundColor = object.backColor.red<<16|object.backColor.green<<8|object.backColor.blue;
				textStyle.color = object.foreColor.red<<16|object.foreColor.green<<8|object.foreColor.blue;
				textStyle.fontScale = object.fontScale;
				textStyle.sizeFixed = object.sizeFixed;
				textStyle.outLine = object.outline;
				textStyle.shadow = object.shadow;
//				textStyle.placement = TextStyle.PLACEMENT_LEFT;
				//还缺少iserver 的样式属性？？？？？？？？？？？？？？？？？？？？？？？？
			}			
			return textStyle;
		}
		
		sm_internal static function clientStyleToServerStyle(object:TextStyle):ServerTextStyle
		{
			var serverTextStyle:ServerTextStyle = new ServerTextStyle();
			if(object)
			{
				switch(object.placement)
				{
					case TextStyle.PLACEMENT_LEFT:
					{
						serverTextStyle.align = TextAlignment.MIDDLELEFT;
						break;
					}
					case TextStyle.PLACEMENT_MIDDLE:
					{
						serverTextStyle.align = TextAlignment.MIDDLECENTER;
						break;
					}
					case TextStyle.PLACEMENT_RIGHT:
					{
						serverTextStyle.align = TextAlignment.MIDDLERIGHT;
						break;
					}
					case TextStyle.PLACEMENT_BOTTOM:
					{
						serverTextStyle.align = TextAlignment.TOPCENTER;
						break;
					}
					case TextStyle.PLACEMENT_BOTTOMLEFT:
					{
						serverTextStyle.align = TextAlignment.TOPLEFT;
						break;
					}
					case TextStyle.PLACEMENT_BOTTOMRIGHT:
					{
						serverTextStyle.align = TextAlignment.TOPRIGHT;
						break;
					}
					case TextStyle.PLACEMENT_TOP:
					{
						serverTextStyle.align = TextAlignment.BOTTOMCENTER;
						break;
					}
					case TextStyle.PLACEMENT_TOPLEFT:
					{
						serverTextStyle.align = TextAlignment.BOTTOMLEFT;
						break;
					}
					case TextStyle.PLACEMENT_TOPRIGHT:
					{
						serverTextStyle.align = TextAlignment.BOTTOMRIGHT;
						break;
					}
					case TextStyle.PLACEMENT_BASELINECENTER:
					{
						serverTextStyle.align = TextAlignment.BASELINECENTER;
						break;
					}
					case TextStyle.PLACEMENT_BASELINELEFT:
					{
						serverTextStyle.align = TextAlignment.BASELINELEFT;
						break;
					}
					case TextStyle.PLACEMENT_BASELINERIGHT:
					{
						serverTextStyle.align = TextAlignment.BASELINERIGHT;
						break;
					}
					default:
					{
						serverTextStyle.align = TextAlignment.MIDDLECENTER;
						break;
					}
				}
				if(object.textFormat)
				{
					serverTextStyle.bold = object.textFormat.bold;
					serverTextStyle.fontName = object.textFormat.font;
					serverTextStyle.italic = object.textFormat.italic;
//					serverTextStyle.fontHeight = object.size;//.getTxtSize();
//					serverTextStyle.fontWidth = object._oldTextSize;
					serverTextStyle.underline = object.textFormat.underline;
					if(object.textFormat.size != null && object.size ==12)
					{
						serverTextStyle.fontHeight  = Number(object.textFormat.size);
					}
					else
						serverTextStyle.fontHeight = object.size;
				}
				else
					serverTextStyle.fontHeight = object.size;
					
//				serverTextStyle.fontHeight = object.size;
				serverTextStyle.rotation = object.angle;
				serverTextStyle.backOpaque = object.background;
				serverTextStyle.backColor = new ServerColor(object.backgroundColor>>16, object.backgroundColor>>8&0xff,object.backgroundColor&0xff);
				serverTextStyle.outline = object.border;
				serverTextStyle.foreColor = new ServerColor(object.color>>16, object.color>>8&0xff,object.color&0xff);
				serverTextStyle.shadow = object.shadow;
				serverTextStyle.outline = object.outLine;
				serverTextStyle.fontScale = object.fontScale;
				serverTextStyle.sizeFixed = object.sizeFixed;
				//还缺少iserver 的样式属性？？？？？？？？？？？？？？？？？？？？？？？？
			}			
			return serverTextStyle;
		}		

	}
}