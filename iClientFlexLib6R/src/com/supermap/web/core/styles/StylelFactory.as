package com.supermap.web.core.styles
{
	
	import mx.utils.Base64Decoder;
	/**
	 * @private 
	 * 
	 */	
	internal class StylelFactory extends Object
	{
		public function StylelFactory()
		{
			super();
		}
		public static function toSymbol(obj:Object):Style
		{
			var style:Style = null;
			if (obj)
			{
				switch(obj.type)
				{
					case "supermapSMS":
					{
						style = toSMS(obj);
						break;
					}
					case "supermapPMS":
					{
						style = toPMS(obj);
						break;
					}
					case "supermapSLS":
					{
						style = toSLS(obj);
						break;
					}
					case "supermapSFS":
					{
						style = toSFS(obj);
						break;
					}
					case "supermapPFS":
					{
						//_loc_2 = toPFS(obj);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			return style;
		}
		
		public static function toSMS(symObj:Object):PredefinedMarkerStyle
		{
			var markerStyle:PredefinedMarkerStyle = null;
			if (symObj)
			{
				markerStyle = new PredefinedMarkerStyle();
				if (symObj.color)
				{
					markerStyle.alpha = symObj.color[3] / 255;
					markerStyle.color = rgbToUint(symObj.color[0], symObj.color[1], symObj.color[2]);
				}
				markerStyle.angle = symObj.angle;
				markerStyle.border = toSLS(symObj.outline);
				markerStyle.size = ptToPx(symObj.size);
				switch(symObj.style)
				{
					case "supermapSMSCircle":
					{
						markerStyle.symbol = PredefinedMarkerStyle.SYMBOL_CIRCLE;
						break;
					}
					case "supermapSMSSquare":
					{
						markerStyle.symbol = PredefinedMarkerStyle.SYMBOL_SQUARE;
						break;
					}
					case "supermapSMSDiamond":
					{
						markerStyle.symbol = PredefinedMarkerStyle.SYMBOL_DIAMOND;
						break;
					}
					case "supermapSMSCross":
					{
						//_loc_2.symbol = PredefinedMarkerStyle.SYMBOL_CROSS;
						break;
					}
					case "supermapSMSX":
					{
						markerStyle.symbol = PredefinedMarkerStyle.SYMBOL_X;
						break;
					}
					default:
					{
						break;
					}
				}
				markerStyle.xOffset = ptToPx(symObj.xoffset);
				markerStyle.yOffset = ptToPx(symObj.yoffset);
			}
			return markerStyle;
		}
		
		public static function toPMS(symObj:Object):PictureMarkerStyle
		{
			var pictureMarkerStyle:PictureMarkerStyle = null;
			if (symObj)
			{
				pictureMarkerStyle = new PictureMarkerStyle(null);
				pictureMarkerStyle.source = toPictureSource(symObj);
				pictureMarkerStyle.angle = symObj.angle;
				pictureMarkerStyle.width = ptToPx(symObj.width);
				pictureMarkerStyle.height = ptToPx(symObj.height);
				pictureMarkerStyle.xOffset = ptToPx(symObj.xoffset);
				pictureMarkerStyle.yOffset = ptToPx(symObj.yoffset);
			}
			return pictureMarkerStyle;
		}
		
		public static function toSLS(symObj:Object):PredefinedLineStyle
		{
			var predefinedLineStyle:PredefinedLineStyle = null;
			if (symObj)
			{
				predefinedLineStyle = new PredefinedLineStyle();
				if (symObj.color)
				{
					predefinedLineStyle.alpha = symObj.color[3] / 255;
					predefinedLineStyle.color = rgbToUint(symObj.color[0], symObj.color[1], symObj.color[2]);
					switch(symObj.style)
					{
						case "supermapSLSSolid":
						{
							predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_SOLID;
							break;
						}
						case "supermapSLSDash":
						{
							predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_DASH;
							break;
						}
						case "supermapSLSDot":
						{
							predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_DOT;
							break;
						}
						case "supermapSLSDashDot":
						{
							predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_DASHDOT;
							break;
						}
						case "supermapSLSDashDotDot":
						{
							predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_DASHDOTDOT;
							break;
						}
						case "supermapSLSNull":
						{
							predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_NULL;
							break;
						}
						default:
						{
							break;
						}
					}
				}
				else
				{
					predefinedLineStyle.symbol = PredefinedLineStyle.SYMBOL_NULL;
				}
				predefinedLineStyle.weight = ptToPx(symObj.width);
			}
			return predefinedLineStyle;
		}
		
		public static function toSFS(symObj:Object):PredefinedFillStyle
		{
			var predefinedFillStyle:PredefinedFillStyle = null;
			if (symObj)
			{
				predefinedFillStyle = new PredefinedFillStyle();
				if (symObj.color)
				{
					predefinedFillStyle.alpha = symObj.color[3] / 255;
					predefinedFillStyle.color = rgbToUint(symObj.color[0], symObj.color[1], symObj.color[2]);
					switch(symObj.style)
					{
						case "supermapSFSSolid":
						{
							predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_SOLID;
							break;
						}
						case "supermapSFSHorizontal":
						{
							predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_HORIZONTAL;
							break;
						}
						case "supermapSFSVertical":
						{
							predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_VERTICAL;
							break;
						}
						case "supermapSFSForwardDiagonal":
						{
							//_loc_2.symbol = PredefinedFillStyle.SYMBOL_FORWARD_DIAGONAL;
							break;
						}
						case "supermapSFSBackwardDiagonal":
						{
							//_loc_2.symbol = PredefinedFillStyle.SYMBOL_BACKWARD_DIAGONAL;
							break;
						}
						case "supermapSFSCross":
						{
							predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_CROSS;
							break;
						}
						case "supermapSFSDiagonalCross":
						{
							predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_CROSS;
							break;
						}
						case "supermapSFSNull":
						{
							predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_NULL;
							break;
						}
						default:
						{
							break;
						}
					}
				}
				else
				{
					predefinedFillStyle.symbol = PredefinedFillStyle.SYMBOL_NULL;
				}
				predefinedFillStyle.border = toSLS(symObj.border);
			}
			return predefinedFillStyle;
		}
		
		/*static function toPFS(symObj:Object):PicturefillStyle
		{
			var _loc_2:PictureFillSymbol = null;
			if (symObj)
			{
				_loc_2 = new PictureFillSymbol();
				_loc_2.outline = toSLS(symObj.outline);
				_loc_2.height = ptToPx(symObj.height);
				_loc_2.width = ptToPx(symObj.width);
				_loc_2.xoffset = ptToPx(symObj.xoffset);
				_loc_2.yoffset = ptToPx(symObj.yoffset);
				_loc_2.xscale = symObj.xscale;
				_loc_2.yscale = symObj.yscale;
				_loc_2.source = toPictureSource(symObj);
				_loc_2.angle = symObj.angle;
			}
			return _loc_2;
		}*/
		
		public static function rgbToUint(r:int, g:int, b:int) : uint
		{
			return r << 16 | g << 8 | b << 0;
		}
		
		public static function ptToPx(pt:Number) : Number
		{
			return pt / 72 * 96;
		}
		
		public static function toPictureSource(symObj:Object) : Object
		{
			var result:Object;
			var url:String;
			var base64Decoder:Base64Decoder;
			var symObj:* = symObj;
			var imageData:* = symObj.imageData;
			url = symObj.url;
			if (imageData)
			{
				base64Decoder = new Base64Decoder();
				try
				{
					base64Decoder.decode(imageData);
					result = base64Decoder.toByteArray();
				}
				catch (error:Error)
				{
					result = url;
				}
			}
			else
			{
				result = url;
			}
			return result;
		}
	}
}