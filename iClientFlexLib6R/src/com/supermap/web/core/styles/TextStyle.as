package com.supermap.web.core.styles
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextLineMetrics;
	
	import mx.core.FTETextField;
	import mx.core.FlexGlobals;
	import mx.events.PropertyChangeEvent;
	
	use namespace sm_internal;

	/**
	 * ${core_TextStyle_Title}.
	 * <p>${core_TextStyle_Description}</p> 
	 * 
	 */	
	public class TextStyle extends Style
	{
		private var _placement:String;
		private var _angle:Number;
		private var _textFormat:TextFormat;
		private var _text:String;
		private var _textAttribute:String;

		private var _textFunction:Function;
		private var _htmlText:String;
		private var _color:uint;
		private var _alpha:Number;
		private var _background:Boolean;
		private var _backgroundColor:uint;
		private var _border:Boolean;
		private var _borderColor:uint;
		private var _xOffset:Number;
		private var _yOffset:Number;
		private var _textField:FTETextField ;
		private var _rotationSprite:Sprite;
		private var _doRotation:Boolean;
		private var _hasChildren:Boolean;
		private var _shadow:Boolean;
		private var _outLine:Boolean;
		private var _fontScale:Number = 1;
		private var _sizeFixed:Boolean = true;
		private var _shadowColor:uint = 0;
		private var _shadowDistance:Number = 5;
		private var _shadowAngle:Number = 45;
		private var _shadowAlpha:Number = 0.5;
		private var _size:Number = 12;
		sm_internal var _oldTextSize:Number;
//		private var _isHavaInputText:Boolean;
		
		/**
		 * ${core_TextStyle_const_PLACEMENT_START_D} 
		 */		
		public static const PLACEMENT_LEFT:String = "left";
		/**
		 * ${core_TextStyle_const_PLACEMENT_MIDDLE_D} 
		 */		
		public static const PLACEMENT_MIDDLE:String = "middle";
		/**
		 * ${core_TextStyle_const_PLACEMENT_END_D} 
		 */		
		public static const PLACEMENT_RIGHT:String = "right";
		/**
		 * ${core_TextStyle_const_PLACEMENT_BELOW_D} 
		 */		
		public static const PLACEMENT_BOTTOM:String = "bottom";
		/**
		 * ${core_TextStyle_const_PLACEMENT_PLACEMENT_BOTTOMLEFT_D} 
		 */		
		public static const PLACEMENT_BOTTOMLEFT:String = "bottomLeft";
		/**
		 * ${core_TextStyle_const_PLACEMENT_PLACEMENT_BOTTOMRIGHT_D} 
		 */		
		public static const PLACEMENT_BOTTOMRIGHT:String = "bottomRight";
		/**
		 * ${core_TextStyle_const_PLACEMENT_ABOVE_D} 
		 */		
		public static const PLACEMENT_TOP:String = "top";
		/**
		 * ${core_TextStyle_const_PLACEMENT_PLACEMENT_TOPLEFT_D} 
		 */		
		public static const PLACEMENT_TOPLEFT:String = "topLeft";
		/**
		 * ${core_TextStyle_const_PLACEMENT_PLACEMENT_TOPRIGHT_D} 
		 */		
		public static const PLACEMENT_TOPRIGHT:String = "topRight";
		/**
		 * ${core_TextStyle_const_PLACEMENT_BASELINECENTER_D} 
		 */		
		public static const PLACEMENT_BASELINECENTER:String = "baselineCenter";
		/**
		 * ${core_TextStyle_const_PLACEMENT_BASELINELEFT_D} 
		 */		
		public static const PLACEMENT_BASELINELEFT:String = "baselineLeft";
		/**
		 * ${core_TextStyle_const_PLACEMENT_BASELINERIGHT_D} 
		 */		
		public static const PLACEMENT_BASELINERIGHT:String = "baselineRight";
		
		private static var _defaultStyle:TextStyle;
		
		/**
		 * ${core_TextStyle_constructor_String_D} 
		 * @param text ${core_TextStyle_constructor_String_param_text_D}
		 * @param color ${core_TextStyle_constructor_String_param_color_D}
		 * @param border ${core_TextStyle_constructor_String_param_border_D}
		 * @param borderColor ${core_TextStyle_constructor_String_param_borderColor_D}
		 * @param background ${core_TextStyle_constructor_String_param_background_D}
		 * @param backgroundColor ${core_TextStyle_constructor_String_param_backgroundColor_D}
		 * @param placement ${core_TextStyle_constructor_String_param_alignment_D}
		 * @param angle ${core_TextStyle_constructor_String_param_angle_D}
		 * @param xOffset ${core_TextStyle_constructor_String_param_offsetX_D}
		 * @param yOffset ${core_TextStyle_constructor_String_param_offsetY_D}
		 * @param textFormat ${core_TextStyle_constructor_String_param_textFormat_D}
		 * @param textAttribute ${core_TextStyle_constructor_String_param_textAttribute_D}
		 * @param textFunction ${core_TextStyle_constructor_String_param_textFunction_D}
		 * 
		 */		
		public function TextStyle(text:String = null, color:uint = 0, border:Boolean = false, borderColor:uint = 0, background:Boolean = false, backgroundColor:uint = 0xffffff, 
								  angle:Number = 0,placement:String = "middle", xOffset:Number = 0, yOffset:Number = 0, htmlText:String = null, textFormat:TextFormat = null, textAttribute:String = null, textFunction:Function = null, size:Number = 12)
		{
			this.text = text;
			this.htmlText = htmlText;
			this.color = color;
			this.border = border;
			this.borderColor = borderColor;
			this.background = background;
			this.backgroundColor = backgroundColor;
			this.placement = placement;
			this.angle = angle;
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			this.textFormat = textFormat;
			this.size = size;
			this.textAttribute = textAttribute;
			this.textFunction = textFunction;
			
		}
		
		sm_internal function getTxtSize():Number
		{
			if(!this._oldTextSize == 0 || !isNaN(this._oldTextSize))
				return _oldTextSize;
			else if(_textFormat)
				return Number(_textFormat.size);
			else
				return Number((_textField.getTextFormat()).size);
		}
		
		/**
		 * ${core_TextStyle_attribute_size_D} 
		 * @see #sizeFixed
		 * @return 
		 * 
		 */		
		public function get size():Number
		{
			return _size;
		}
		
		public function set size(value:Number):void
		{
			var oldValue:Number = this._size;
			if (oldValue !== value)
			{				
				_size = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "size", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_TextStyle_attribute_sizeFixed_D} 
		 * @return 
		 * 
		 */		
		public function get sizeFixed():Boolean
		{
			return _sizeFixed;
		}
		
		public function set sizeFixed(value:Boolean):void
		{
			var oldValue:Boolean = this._sizeFixed;
			if (oldValue !== value)
			{				
				_sizeFixed = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizeFixed", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_fontScale_D} 
		 * @see #size
		 * @return 
		 * 
		 */		
		public function get fontScale():Number
		{
			return _fontScale;
		}
		
		public function set fontScale(value:Number):void
		{
			var oldValue:Number = this._fontScale;
			if (oldValue !== value)
			{				
				_fontScale = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "fontScale", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_outLine_D} 
		 * @return 
		 * 
		 */		
		public function get outLine():Boolean
		{
			return _outLine;
		}
		
		public function set outLine(value:Boolean):void
		{
			var oldValue:Boolean = this._outLine;
			if (oldValue !== value)
			{				
				_outLine = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "outLine", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_TextStyle_attribute_shadow_D} 
		 * @return 
		 * 
		 */		
		public function get shadow():Boolean
		{
			return _shadow;
		}
		
		public function set shadow(value:Boolean):void
		{
			var oldValue:Boolean = this._shadow;
			if (oldValue !== value)
			{				
				_shadow = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "shadow", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_TextStyle_attribute_borderColor_D} 
		 * @default 0
		 * @see #boder
		 * @return 
		 * 
		 */		
		public function get borderColor():uint
		{
			return _borderColor;
		}

		public function set borderColor(value:uint):void
		{
			var oldValue:uint = this._borderColor;
			if (oldValue !== value)
			{				
				this._borderColor= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderColor", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_border_D} 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get border():Boolean
		{
			return _border;
		}

		public function set border(value:Boolean):void
		{
			var oldValue:Boolean = this._border;
			if (oldValue !== value)
			{				
				this._border= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "border", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_backgroundColor_D} 
		 * @default 0xffffff
		 * @return 
		 * 
		 */		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			var oldValue:uint = this._backgroundColor;
			if (oldValue !== value)
			{				
				this._backgroundColor= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundColor", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_background_D} 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get background():Boolean
		{
			return _background;
		}

		public function set background(value:Boolean):void
		{
			var oldValue:Boolean = this._background;
			if (oldValue !== value)
			{				
				this._background= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "background", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_alpha_D} 
		 * @return 
		 * 
		 */		
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(value:Number):void
		{
			var oldValue:Number = this._alpha;
			if (oldValue !== value)
			{				
				this._alpha= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alpha", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_color_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			var oldValue:uint = this._color;
			if (oldValue !== value)
			{				
				this._color= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "color", oldValue, value));
				}
			}
		}		
		
		/**
		 * ${core_TextStyle_attribute_HtmlText_D} 
		 * @return 
		 * 
		 */		
		public function get htmlText():String
		{
			return _htmlText;
		}

		public function set htmlText(value:String):void
		{
			var oldValue:String = this._htmlText;
			if (oldValue !== value)
			{				
				this._htmlText= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "htmlText", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_textAttribute_D}.
		 * <p>${core_TextStyle_attribute_textAttribute_remarks}</p> 
		 * @example
		 * <listing>
		 * var point:GeoPoint = new GeoPoint(-120,30);
		 * var style:TextStyle = new TextStyle();
		 * style.textAttribute = "name";
		 * var feature:Feature = new Feature(point,style);
		 * feature.attributes = {name:"hello",position:"west"};
		 * </listing>
		 * @return 
		 * 
		 */		
		public function get textAttribute():String
		{
			return _textAttribute;
		}

		public function set textAttribute(value:String):void
		{
			var oldValue:String = this._textAttribute;
			if (oldValue !== value)
			{				
				this._textAttribute= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textAttribute", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_textAttribute_D}
		 * @defautl null  
		 * @return 
		 * 
		 */		
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			var oldValue:String = this._text;
			if (oldValue !== value)
			{				
				this._text= value;
//				this._isHavaInputText = true;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "text", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_textFormat_D} 
		 * @see flash.text.TextFormat
		 * @return 
		 * 
		 */		
		public function get textFormat():TextFormat
		{
			if(_textFormat && this._sizeFixed == false && (!this._oldTextSize == 0 || !isNaN(this._oldTextSize)))
				_textFormat.size = this._oldTextSize;
			return _textFormat;
		}

		public function set textFormat(value:TextFormat):void
		{
			var oldValue:TextFormat = this._textFormat;
			if (oldValue !== value)
			{				
				this._textFormat= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textFormat", oldValue, value));
				}
			}
		}

		/**
		 * ${core_TextStyle_attribute_angle_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			var oldValue:Number = this._angle;
			if (oldValue !== value)
			{				
				this._angle= value;
//				this._doRotation = true;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "angle", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_TextStyle_attribute_textFunction_D}.
		 * <p>${core_TextStyle_attribute_textFunction_remarks}</p> 
		 * @example
		 * <listing>
		 * var point:GeoPoint = new GeoPoint(-120,30);
		 * var style:TextStyle = new TextStyle();
		 * style.textFunction = setTextFunction;
		 * var feature1:Feature = new Feature(point,style);
		 * feature1.attributes = {name:"hello",position:"west"};
		 * private function setTextFunction(point:GeoPoint, attribute:Object):String
		 * {
		 *   var str:String = attribute['name'];
		 *   return "坐标:" + point.x.toString() + "," + point.y.toString()+ "|Name:" + str;
		 * }
		 * </listing>
		 * @return 
		 * 
		 */		
		public function get textFunction():Function
		{
			return _textFunction;
		}

		public function set textFunction(value:Function):void
		{
			var oldValue:Function = this._textFunction;
			if (oldValue !== value)
			{				
				this._textFunction= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textFunction", oldValue, value));
				}
			}
		}

		[Inspectable(category = "iClient", enumeration = "PLACEMENT_START,PLACEMENT_MIDDLE,PLACEMENT_END,PLACEMENT_BELOW,PLACEMENT_ABOVE", defaultValue = "PLACEMENT_MIDDLE")] 
		/**
		 * ${core_TextStyle_attribute_alignment_D} 
		 * @default middle
		 * @return 
		 * 
		 */		
		public function get placement():String
		{
			return _placement;
		}

		public function set placement(value:String):void
		{
			var oldValue:String = this._placement;
			if (oldValue !== value)
			{				
				this._placement= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "placement", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_TextStyle_attribute_offsetY_D} 
		 * @default 0
		 * @return 
		 * 
		 */	
		public function get yOffset() : Number
		{
			return this._yOffset;
		}
		
		public function set yOffset(value:Number) : void
		{
			var oldValue:Number = this._yOffset;
			if (oldValue !== value)
			{				
				this._yOffset= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderColor", oldValue, value));
				}
			}
			
		}
		
		/**
		 * ${core_TextStyle_attribute_offsetX_D}
		 * @default 0 
		 * @return 
		 * 
		 */	
		public function get xOffset() : Number
		{
			return this._xOffset;
		}
		
		public function set xOffset(value:Number) : void
		{
			var oldValue:Number = this._xOffset;
			if (oldValue !== value)
			{				
				this._xOffset= value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderColor", oldValue, value));
				}
			}
			
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function destroy(sprite:Sprite) : void
		{
			removeAllChildren(sprite);
			sprite.graphics.clear();
			sprite.x = 0;
			sprite.y = 0;			
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override function clone() : Style
		{
			var textStyle:TextStyle = new TextStyle(this._text,this._color, this._border, this._borderColor, this._background, this._backgroundColor, this._angle, this._placement,  this._xOffset, this._yOffset,  null, this._textFormat, null, this._textFunction);
			textStyle._alpha = this._alpha;
			textStyle._textField = this._textField;
			textStyle._rotationSprite = this._rotationSprite;
			textStyle._doRotation = this._doRotation;
			textStyle._hasChildren = this._hasChildren;
			return textStyle;
		}
		
		private function getChildFromSprite(sprite:Sprite) : void
		{
			var displayObject:DisplayObject = null;
			this._hasChildren = true;
			displayObject = sprite.getChildAt(0);
			if (displayObject is DisplayObjectContainer && displayObject.name == "rotationSprite")
			{
				this._rotationSprite = displayObject as Sprite;
				this._textField = DisplayObjectContainer(displayObject).getChildAt(0) as FTETextField;				
			}			
			else if (this._angle)
			{
				this._textField = sprite.removeChildAt(0) as FTETextField;
				this._rotationSprite = new Sprite();
				this._rotationSprite.name = "rotationSprite";
				this._rotationSprite.addChild(this._textField);
				sprite.addChild(this._rotationSprite);
			}
			else
			{
				this._textField = displayObject as FTETextField;
			}
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * @param geometry
		 * @param attributes
		 * @param map
		 * 
		 */		
		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{
			if (geometry is GeoPoint)
			{
				if (sprite.numChildren > 0)
				{
					this.getChildFromSprite(sprite);
				}
				if (sprite.numChildren == 0)
				{
					this._hasChildren = false;
					this._textField = new FTETextField();
					this._textField.name = "textField";
					this._textField.selectable = false;
					this._textField.autoSize = TextFieldAutoSize.LEFT;
				}
				var myFilters:Array = new Array();
				if(this._shadow)
				{
					var shadowFilter:DropShadowFilter = new DropShadowFilter();
					shadowFilter.color = _shadowColor;
					shadowFilter.alpha = _shadowAlpha;
					shadowFilter.angle = _shadowAngle;
					shadowFilter.blurX = 1;
					shadowFilter.blurY = 1;
					shadowFilter.distance = _shadowDistance;
					myFilters.push(shadowFilter);
				}
				if(this._outLine)
				{
					var glowFilter:GlowFilter = new GlowFilter();
					glowFilter.color = 0xffffff;
					glowFilter.alpha = 1;
					glowFilter.blurX = 2;
					glowFilter.blurY = 2;
					glowFilter.strength = 5;
					glowFilter.inner = false;
					glowFilter.knockout = false;
					myFilters.push(glowFilter);
				}
				this._textField.filters= myFilters;
				this._textField.scaleX = _fontScale;
				this._textField.scaleY = _fontScale;
				this.drawTextPoint(map, sprite, geometry as GeoPoint, attributes);
			}
			
		}
		
		private function drawTextPoint(map:Map, sprite:Sprite, point:GeoPoint, attributes:Object) : void
		{
			var attribute:Object = null;
			var textFunction:Object = null;
			var bol:Boolean = false;
			if (this._text)
			{
				this._textField.text = this._text;
			}	
//			else if(this._isHavaInputText)
//			{
//				this._textField.text = this._text;
//				this._isHavaInputText = false;
//			}
			else if (this._htmlText)
			{
				this._textField.htmlText = this._htmlText;
				//不加以下这个属性的话，flash会给htmlText包一个P标签及Font标签，导致了ICL659这个bug.加上这个后，this._textField.htmlText就等于this._htmlText了。
				this._textField.styleSheet=new StyleSheet();
				
			}
			else if (this._textAttribute)
			{
				attribute = attributes[this._textAttribute];
				if (attribute != null)
				{
					this._textField.text = String(attribute);
					this._textField.visible = true;
				}
				else
				{
					this._textField.visible = false;
				}
			}
			else if (this._textFunction != null)
			{
				textFunction = this._textFunction(point, attributes);
				if (textFunction != null)
				{
					this._textField.text = String(textFunction);
					this._textField.visible = true;
				}
				else
				{
					this._textField.visible = false;
				}
			}
			this._textField.textColor = this._color;
			this._textField.background = this._background;
			this._textField.backgroundColor = this._backgroundColor;
			this._textField.border = this._border;
			this._textField.borderColor = this._borderColor;
			
			if (this._angle)
			{
				this._doRotation = true;
				if (!this._hasChildren)
				{
					this._rotationSprite = new Sprite();
					this._rotationSprite.name = "rotationSprite";
					this._rotationSprite.addChild(this._textField);
					sprite.addChild(this._rotationSprite);
				}				
			}
			else
			{
				this._doRotation = false;
			}
			if (this._alpha)
			{
				this._textField.alpha = this._alpha;
			}
			
			var tempsize:Number;
			if (this._textFormat)
			{
				bol = FlexGlobals.topLevelApplication.systemManager.isFontFaceEmbedded(this._textFormat);
				if (bol)
				{
					this._textField.embedFonts = true;					
					
				}
				this._textField.setTextFormat(this._textFormat);
				//如果设置了_textFormat.size，且未设置_size属性，文本大小取_textFormat.size值，否则取_size
				if(this._textFormat.size != null && _size ==12)
				{
					tempsize = Number(_textFormat.size);
				}
				else
					tempsize = this._size;
				
			}
			else
				tempsize = this._size;
			
			var txtFormat:TextFormat = this._textField.getTextFormat();
			if(!this._sizeFixed)
			{
				var feature:Feature = sprite as Feature;
				var pixelSize:Number = Number(tempsize)/feature.getcurrentResoltuion();
				txtFormat.size = pixelSize;
			}
			else
			{
				txtFormat.size = tempsize;
			}
			this._textField.setTextFormat(txtFormat);
			var size_w:Number = this._textField.width;
			var size_h:Number = this._textField.height;
			var half_w:Number = size_w / 2;
			var half_h:Number = size_h / 2;
			sprite.x = this.toScreenX(map, point.x) - half_w;
			sprite.y = this.toScreenY(map, point.y) - half_h;
			sprite.width = size_w;
			sprite.height = size_h;
			switch(this._placement)
			{
				case PLACEMENT_LEFT:
				{
					sprite.x = sprite.x + half_w;
					break;
				}
				case PLACEMENT_RIGHT:
				{
					sprite.x = sprite.x - half_w;
					break;
				}
				case PLACEMENT_TOP:
				{
					sprite.y = sprite.y - half_h;
					break;
				}
				case PLACEMENT_TOPLEFT:
				{
					sprite.x = sprite.x + half_w;
					sprite.y = sprite.y - half_h;
					break;
				}
				case PLACEMENT_TOPRIGHT:
				{
					sprite.x = sprite.x - half_w;
					sprite.y = sprite.y - half_h;
					break;
				}
				case PLACEMENT_BOTTOM:
				{
					sprite.y = sprite.y + half_h;
					break;
				}
				case PLACEMENT_BOTTOMLEFT:
				{
					sprite.x = sprite.x + half_w;
					sprite.y = sprite.y + half_h;
					break;
				}
				case PLACEMENT_BOTTOMRIGHT:
				{
					sprite.x = sprite.x - half_w;
					sprite.y = sprite.y + half_h;
					break;
				}
				case PLACEMENT_BASELINECENTER:
				{
					sprite.y = sprite.y - (this.getbaselinePosition()-half_h);
					break;
				}
				case PLACEMENT_BASELINELEFT:
				{
					sprite.x = sprite.x + half_w;
					sprite.y = sprite.y - (this.getbaselinePosition()-half_h);
					break;
				}	
				case PLACEMENT_BASELINERIGHT:
				{
					sprite.x = sprite.x - half_w;
					sprite.y = sprite.y - (this.getbaselinePosition()-half_h);
					break;
				}	
				default:
				{
					break;
				}
			}
			if (this._xOffset)
			{
				sprite.x = sprite.x + this._xOffset;
			}
			if (this._yOffset)
			{
				sprite.y = sprite.y - this._yOffset;
			}
			if (!this._angle)
			{	
				if (!this._hasChildren)
				{
					sprite.addChild(this._textField);
				}
				else if (DisplayObject(sprite.getChildAt(0)).name != "textField")					
				{
					sprite.removeChildAt(0);
					sprite.addChild(this._textField);
				}
			}
			else
			{
				if(sprite.contains(this._rotationSprite) && this._rotationSprite.contains(this._textField))
				{
					this._rotationSprite.x = half_w;
					this._rotationSprite.y = half_h;
					this._textField.x = -half_w;
					this._textField.y = -half_h;
					this._rotationSprite.rotation = this._angle;				
				}
				
			}
		}
		
		/**
		 * ${core_TextStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public static function get defaultStyle() : Style
		{
			if (_defaultStyle == null)
			{
				_defaultStyle = new TextStyle();
			}
			return _defaultStyle;
		}
		
		/**
		 * 获取文本字体的基线 byzyn 
		 * @return 
		 * 
		 */		
		private function getbaselinePosition():Number
		{
			var tlm:TextLineMetrics;
			
			// The text styles aren't known until there is a parent.
			if (!_textField)
				return NaN;
			
			// getLineMetrics() returns strange numbers for an empty string,
			// so instead we get the metrics for a non-empty string.
			var isEmpty:Boolean = text == "";
			if (isEmpty)
				_textField.text = "Wj";
			
			tlm = _textField.getLineMetrics(0);
			
			if (isEmpty)
				_textField.text = "";
			
			// TextFields have 2 pixels of padding all around.
			return 2 + tlm.ascent;
		}
	}
}