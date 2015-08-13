package com.supermap.web.core.styles
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.themes.RawTheme;
	import com.supermap.web.utils.GeoUtil;
	import com.supermap.web.utils.StyleUtil;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import mx.events.PropertyChangeEvent;
	import mx.graphics.SolidColorStroke;
	
	import spark.components.mediaClasses.VolumeBar;
	
	use namespace sm_internal;
	
	/**
	 * ${core_styles_PredefineLineStyle_Title}.
	 * <p>${core_styles_PredefineLineStyle_Description}</p>
	 * 
	 */	
	public class PredefinedLineStyle extends LineStyle
	{
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_NULL_D} 
		 */		
		public static const SYMBOL_NULL:String= "null";	
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_SOLID_D} 
		 */		
		public static const SYMBOL_SOLID:String= "solid";	
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DASH_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_STYLE_DASH_remarks}</p> 
		 */		
		public static const SYMBOL_DASH:String= "dash";		
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DOT_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_STYLE_DOT_remarks}</p> 
		 */		
		public static const SYMBOL_DOT:String = "dot";	 
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DASHDOT_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_STYLE_DASHDOT_remarks}</p> 
		 */		
		public static const SYMBOL_DASHDOT:String= "dashdot";
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DASHDOTDOT_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_STYLE_DASHDOTDOT_remarks}</p> 
		 */		
		public static const SYMBOL_DASHDOTDOT:String = "dashdotdot";				
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_COUSTOM_D} 
		 */	
		public static const SYMBOL_COUSTOM:String = "coustom";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_CAP_NONE_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_CAP_CAP_NONE_remarks}</p> 
		 */		
		public static const CAP_NONE:String = "none";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_ROUND_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_CAP_ROUND_remarks}</p> 
		 */		
		public static const CAP_ROUND:String = "round";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_SQUARE_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_CAP_SQUARE_remarks}</p> 
		 */		
		public static const CAP_SQUARE:String = "square";
		
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_JOIN_MITER_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_CAP_JOIN_MITER_remarks}</p> 
		 */	
		public static const JOIN_MITER:String = "miter";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_JOIN_ROUND_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_CAP_JOIN_ROUND_remarks}</p> 
		 */		
		public static const JOIN_ROUND:String = "round";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_JOIN_BEVEL_D}.
		 * <p>${core_styles_PredefinedLineStyle_const_CAP_JOIN_BEVEL_remarks}</p> 
		 */		
		public static const JOIN_BEVEL:String = "bevel";
		
		private static var _defaultStyle:Style;
		
		private var _cap:String;
		private var _join:String;
		private var _miterLimit:Number;
		private var _symbol:String;		
		private var _stroke:SolidColorStroke;
		private var _pattern:Array;
		
		private var _weightFlag:Number;
		private var _oldPattern:Array;
		private var _customPatternChanged:Boolean;
		
		/**
		 * ${core_styles_PredefinedLineStyle_constructor_D} 
		 * @param symbol ${core_styles_PredefinedLineStyle_constructor_param_symbol_D}
		 * @param color ${core_styles_PredefinedLineStyle_constructor_param_color_D}
		 * @param alpha ${core_styles_PredefinedLineStyle_constructor_param_alpha_D}
		 * @param weight ${core_styles_PredefinedLineStyle_constructor_param_weight_D}
		 * @param cap ${core_styles_PredefinedLineStyle_constructor_param_cap_D}
		 * @param join ${core_styles_PredefinedLineStyle_constructor_param_join_D}
		 * @param miterLimit ${core_styles_PredefinedLineStyle_constructor_param_miterLimit_D}
		 * 
		 */		
		public function PredefinedLineStyle(symbol:String = SYMBOL_SOLID, color:Number = 0x5082e5, alpha:Number = 1, weight:Number = 2,cap:String = null,join:String = null,miterLimit:Number = 3)
		{	  
			this._cap = cap;
			this._join = join;
			this._miterLimit = miterLimit;
			this._symbol = symbol;
			_stroke = new SolidColorStroke();
			if(!(Map.theme))
			{
				this.alpha = alpha;
				this.color = color;
				this.weight = weight;
			}
			else
			{
				this.color = (color == 0x5082e5) ? Map.theme.lineColor : color;
				this.weight =(weight == 2) ? Map.theme.weight : weight;
				this.alpha = (alpha == 1) ? Map.theme.alpha : alpha;
			}
			
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, propertyChangeHandler);
		}
		
		
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_cap_D} 
		 * @return 
		 * 
		 */		
		public function get cap() : String
		{
			return this._cap;
		}
		
		public function set cap(value:String) : void
		{
			var arguments:String = this.cap;
			if (arguments != value)
			{
				this._cap = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cap", arguments, value));
				}
			}
			
		}
		
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_join_D} 
		 * @return 
		 * 
		 */		
		public function get join() : String
		{
			return this._join;
		}	
		
		public function set join(value:String) : void
		{
			var arguments:String = this.join;
			if (arguments !== value)
			{
				this._join = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "join", arguments, value));
				}
			}
		}
		
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_miterLimit_D}.
		 * <p>${core_styles_PredefinedLineStyle_attribute_miterLimit_remarks}</p> 
		 * @see #join
		 * @return 
		 * 
		 */		
		public function get miterLimit() : Number
		{
			return this._miterLimit;
		}
		
		public function set miterLimit(value:Number) : void
		{
			var arguments:Number = this.miterLimit;
			if (arguments !== value)
			{
				
				this._miterLimit = value;
				dispatchEventChange();				
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "miterLimit", arguments, value));
				}
			}			
		}
		
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_pattern_D}.
		 * <p>${core_styles_PredefinedLineStyle_attribute_pattern_remarks}</p> 
		 * @return
		 * 
		 */		
		public function get pattern():Array
		{
			this._weightFlag = this.weight * 0.618;
			
			if(!this._weightFlag)
				_weightFlag = 1;
			
			switch(this._symbol)
			{
				case SYMBOL_SOLID:
				{
					this._pattern = [1, 0];
					break;
				}
				case SYMBOL_DASH:
				{
					this._pattern = [6 * this._weightFlag, 3.7 * this._weightFlag];
					break;
				}
				case SYMBOL_DOT:
				{
					this._pattern = [2.3 * this._weightFlag, 3.7 * this._weightFlag];					
					break;
				}
				case SYMBOL_DASHDOT:
				{
					this._pattern = [6 * this._weightFlag, 3.7 * this._weightFlag, 2.3 * this._weightFlag, 3.7 * this._weightFlag];
					break;
				}
				case SYMBOL_DASHDOTDOT:
				{
					this._pattern = [6 * this._weightFlag, 3.7 * this._weightFlag, 2.3 * this._weightFlag, 3.7 * this._weightFlag, 2.3 * this._weightFlag, 3.7 * this._weightFlag];
					break;
				}		
				case SYMBOL_COUSTOM:
				{				
					if(!_customPatternChanged)
					{
						var newArray:Array = [];
						for(var i:int = 0; i < this._oldPattern.length; i++)
						{
							var newValue:Number = this._oldPattern[i] * this._weightFlag;
							newArray.push(newValue);
						}
						this._pattern = newArray;
						_customPatternChanged = true;
					}
					break;
				}
				default:
				{
					if(!this._pattern)
					{
						this._pattern = [1, 0];
					}
					break;
				}
			}
			return this._pattern;
		}	
		public function set pattern(pattern:Array) : void
		{		
			if(pattern && pattern.length > 0)
			{
				this._pattern = pattern;
				this._oldPattern = pattern;
				dispatchEventChange();				
			}	
		}		
		
		/**
		 * ${core_styles_PredefinedLineStyle_method_setLineStyle_D} 
		 * @param graphics ${core_styles_PredefinedLineStyle_method_setLineStyle_param_Graphics}
		 * 
		 */		
		protected function setLineStyle(graphics:Graphics) : void
		{			
			graphics.lineStyle(weight, color, alpha, false, "normal", this.cap, this.join, this.miterLimit);		
		}
		
		[Inspectable(category = "iClient", enumeration = "SYMBOL_NULL,SYMBOL_SOLID,SYMBOL_DASH,SYMBOL_DOT,SYMBOL_DASHDOT,SYMBOL_DASHDOTDOT,SYMBOL_COUSTOM", defaultValue = "SYMBOL_SOLID")] 
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_symbol_D} 
		 * @return 
		 * 
		 */		
		public function get symbol():String
		{
			return _symbol;
		}
		
		public function set symbol(value:String):void
		{
			var oldValue:String=this._symbol;
			if(oldValue!=value)
			{
				this._symbol=value;
				dispatchEvent(new Event(Event.CHANGE));
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "symbol", oldValue, value));
				}
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
		public override function  draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if(!geometry)
			{
				return;				
			}	
			
			var clipRect:Rectangle2D = map.viewBounds.expand(3);
			
			var geoBounds:Rectangle2D = geometry.bounds;
			var ptMinX:Number = this.toScreenX(map, geoBounds.left);
			var ptMaxY:Number = this.toScreenY(map, geoBounds.bottom);
			var ptMaxX:Number = this.toScreenX(map, geoBounds.right);
			var ptMinY:Number = this.toScreenY(map, geoBounds.top);
			
			sprite.x = ptMinX;
			sprite.y = ptMinY;
			sprite.width = ptMaxX - ptMinX;
			sprite.height = ptMaxY - ptMinY;
			
			if(geometry is GeoLine)
			{	
				var geoLine:GeoLine = geometry as GeoLine;	
				switch(this._symbol)
				{
					case SYMBOL_SOLID:	
					{
						drawSolidGeoLine(map, clipRect, sprite, geoLine);
						break;
					}		
					case SYMBOL_NULL:
					{
						drawNullGeoLine(map, clipRect, sprite, geoLine);
						break;
					}	
					default:
					{
						this.drawStyledGeoLine(map, clipRect, sprite, geoLine);
						break;
					}				
				}				
			}
			//面对象中的边框线对象会自己绘制，避免重复
//			else if(geometry is GeoRegion)
//			{
//				var geoRegion:GeoRegion = geometry as GeoRegion;	
//				switch(this._symbol)
//				{
//					case SYMBOL_SOLID:	
//					{
//						drawSolidGeoRegion(map, clipRect, sprite, geoRegion);
//						break;
//					}		
//					case SYMBOL_NULL:
//					{
//						drawNullGeoRegion(map, clipRect, sprite, geoRegion);
//						break;
//					}	
//					default:
//					{
//						this.drawStyledGeoRegion(map, clipRect, sprite, geoRegion);
//						break;
//					}				
//				}				
//			}
			
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function clear(sprite:Sprite):void
		{
			sprite.graphics.clear();
		}
		
		override public function destroy(sprite:Sprite):void
		{
			sprite.graphics.clear();
			sprite.x=0;
			sprite.y=0;
			
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function clone() :Style
		{
			var lineStyle:PredefinedLineStyle = new PredefinedLineStyle(this._symbol, this.color, this.alpha, this.weight);
			return lineStyle;
			
		}
		
		
		private function propertyChangeHandler(event:PropertyChangeEvent):void
		{
			var proName:String = event.property as String;
			if(proName == "weight")
				this._customPatternChanged = false;
		}
		
		
		/**
		 *  
		 * @param map 地图
		 * @param rect 当前地图可视范围的三倍
		 * @param sprite 绘制面板，面板大小为 geometry.bounds 转换为屏幕坐标的大小
		 * @param line 要素 geometry
		 * 
		 */		
		private function drawSolidGeoLine(map:Map, rect:Rectangle2D, sprite:Sprite, line:GeoLine):void
		{
			var ptStart:Point2D = null;
			var ptEnd:Point2D = null;
			var k:int=0;
			
			this.setLineStyle(sprite.graphics);
			
			var ptCount:int = line.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				var part:Array = line.getPart(i);
				if (part.length >1)
				{
					ptStart = part[0];					
					sprite.graphics.moveTo(this.toScreenX(map, ptStart.x) - sprite.x, this.toScreenY(map, ptStart.y) - sprite.y);					
					k=1;
					while(k < part.length)
					{
						ptEnd = part[k];					
						if(!ptEnd.equals(ptStart))
						{
							this.drawSegmentGeoline(map, rect, sprite, ptStart, ptEnd);
						}
						ptStart = ptEnd;
						k++;
					}
				}
			}
		}
		
		private function drawSolidGeoRegion(map:Map, rect:Rectangle2D, sprite:Sprite, region:GeoRegion):void
		{
			var ptStart:Point2D = null;
			var ptEnd:Point2D = null;
			var k:int=0;
			
			this.setLineStyle(sprite.graphics);
			
			var ptCount:int = region.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				var part:Array = region.getPart(i);
				if (part.length >1)
				{
					ptStart = part[0];					
					sprite.graphics.moveTo(this.toScreenX(map, ptStart.x) - sprite.x, this.toScreenY(map, ptStart.y) - sprite.y);					
					k=1;
					while(k < part.length)
					{
						ptEnd = part[k];					
						if(!ptEnd.equals(ptStart))
						{
							this.drawSegmentGeoline(map, rect, sprite, ptStart, ptEnd);
						}
						ptStart = ptEnd;
						k++;
					}
				}
			}
		}
		
		private function drawSegmentGeoline(map:Map, rect:Rectangle2D, sprite:Sprite, ptStart:Point2D, ptEnd:Point2D):void
		{
			var ptStartX:Number = this.toScreenX(map, ptStart.x);
			var ptStartY:Number = this.toScreenY(map, ptStart.y);
			var ptEndX:Number = this.toScreenX(map, ptEnd.x);
			var ptEndY:Number = this.toScreenY(map, ptEnd.y);
			
			var ptMoveTo:Point2D = null;
			var ptLineTO:Point2D = null;
			var offsetX:Number = ptEndX - ptStartX;
			var offsetY:Number = ptEndY - ptStartY;
			var ptsLength:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
			if(ptsLength >= 32000)
			{
				var ary:Array=[];	
				if(rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
				{
					sprite.graphics.lineTo(ptEndX - sprite.x, ptEndY - sprite.y);
				}
				else
				{
					ary = GeoUtil.clipLineRect(ptStart, ptEnd, rect);	
					if(ary.length == 0)
					{
						return;
					}
					else if(ary.length == 1)
					{
						var ptNew:Point2D = ary[0];						
						if (!rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
						{
							sprite.graphics.moveTo(this.toScreenX(map, ptNew.x) - sprite.x, this.toScreenY(map, ptNew.y) - sprite.y);
							sprite.graphics.lineTo(ptEndX - sprite.x, ptEndY - sprite.y);
						}
						else
						{
							sprite.graphics.lineTo(this.toScreenX(map, ptNew.x) - sprite.x, this.toScreenY(map,ptNew.y) - sprite.y);
						}
					}
					else
					{
						ptMoveTo = ary[0];
						ptLineTO = ary[1];
						sprite.graphics.moveTo(this.toScreenX(map, ptMoveTo.x) - sprite.x, this.toScreenY(map, ptMoveTo.y) - sprite.y);
						sprite.graphics.lineTo(this.toScreenX(map, ptLineTO.x) - sprite.x, this.toScreenY(map, ptLineTO.y) - sprite.y);
					}
					
				}
			}
			else
			{
				sprite.graphics.lineTo(ptEndX - sprite.x, ptEndY - sprite.y);
			}
		}
		
		private function drawNullGeoLine(map:Map,rect:Rectangle2D,sprite:Sprite,line:GeoLine):void
		{
			return;
		}
		private function drawNullGeoRegion(map:Map,rect:Rectangle2D,sprite:Sprite,region:GeoRegion):void
		{
			return;
		}
		
		private function drawStyledGeoLine(map:Map, rect:Rectangle2D, sprite:Sprite, line:GeoLine):void
		{
			var ptStart:Point2D = null;
			var ptEnd:Point2D = null;
			this._stroke.color = this.color;
			this._stroke.weight = this.weight;
			this._stroke.alpha = this.alpha; 
			
			var ptCount:int = line.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				var part:Array = line.getPart(i);
				if (part.length > 1)
				{					
					ptStart = part[0];	
					var j:int = 1;
					while(j < part.length)
					{
						ptEnd = part[j];						
						if(!ptEnd.equals(ptStart))
						{
							this.drawSegmentStyledGeoline(map, rect, sprite, ptStart, ptEnd, this._stroke);
						}
						ptStart = ptEnd;
						j++;						
						
					}					
				}
			}
		}
		
		private function drawStyledGeoRegion(map:Map, rect:Rectangle2D, sprite:Sprite, region:GeoRegion):void
		{
			var ptStart:Point2D = null;
			var ptEnd:Point2D = null;
			this._stroke.color = this.color;
			this._stroke.weight = this.weight;
			this._stroke.alpha = this.alpha; 
			
			var ptCount:int = region.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				var part:Array = region.getPart(i);
				if (part.length > 1)
				{					
					ptStart = part[0];	
					var j:int = 1;
					while(j < part.length)
					{
						ptEnd = part[j];						
						if(!ptEnd.equals(ptStart))
						{
							this.drawSegmentStyledGeoline(map, rect, sprite, ptStart, ptEnd, this._stroke);
						}
						ptStart = ptEnd;
						j++;						
						
					}					
				}
			}
		}
		
		private  function drawSegmentStyledGeoline(map:Map, rect:Rectangle2D, sprite:Sprite, ptStart:Point2D, ptEnd:Point2D, stroke:SolidColorStroke):void
		{		
			var ptStartX:Number = this.toScreenX(map, ptStart.x);
			var ptStartY:Number = this.toScreenY(map, ptStart.y);
			var ptEndX:Number =  this.toScreenX(map, ptEnd.x);
			var ptEndY:Number =  this.toScreenY(map, ptEnd.y);
			var offsetX:Number = ptEndX - ptStartX;
			var offsetY:Number = ptEndY - ptStartY;
			var ptsLength:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
			var ptAry:Array = [];	
			if(ptsLength >= 32000)
			{
				if(rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
				{
					ptAry.push(ptStartX - sprite.x);
					ptAry.push(ptStartY - sprite.y);				
					ptAry.push(ptEndX - sprite.x);
					ptAry.push(ptEndY - sprite.y);
				}
				else
				{
					var ary:Array = GeoUtil.clipLineRect(ptStart, ptEnd, rect);	
					if(ary.length == 0)
					{
						return;
					}
					else if(ary.length == 1)
					{
						var ptNew:Point2D = ary[0];						
						if (!rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
						{
							ptAry.push(this.toScreenX(map, ptNew.x) - sprite.x);
							ptAry.push(this.toScreenY(map, ptNew.y) - sprite.y);
							ptAry.push(ptEndX - sprite.x);
							ptAry.push(ptEndY - sprite.y);
						}
						else
						{
							//sprite.graphics.lineTo(this.toScreenX(map, ptNew.x) - sprite.x, this.toScreenY(map,ptNew.y) - sprite.y);
							ptAry.push(ptStartX - sprite.x);
							ptAry.push(ptStartX - sprite.y);
							ptAry.push(toScreenX(map, ptNew.x) - sprite.x);
							ptAry.push(toScreenY(map, ptNew.y) - sprite.y);
						}
					}
					else
					{
						var ptMoveTo:Point2D = ary[0];
						var ptLineTo:Point2D = ary[1];
						ptAry.push(toScreenX(map, ptMoveTo.x) - sprite.x);
						ptAry.push(toScreenY(map, ptMoveTo.y) - sprite.y);
						ptAry.push(toScreenX(map, ptLineTo.x) - sprite.x);
						ptAry.push(toScreenY(map, ptLineTo.y) - sprite.y);
					}
					
				}
			}
			else
			{
				ptAry.push(ptStartX - sprite.x);
				ptAry.push(ptStartY - sprite.y);				
				ptAry.push(ptEndX - sprite.x);
				ptAry.push(ptEndY - sprite.y);
			}
			
			
			if (ptAry != null)
			{							
				StyleUtil.drawStyledGeoLine(sprite, ptAry, stroke, this.pattern);		
			}
		}
		
		
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public static  function get defaultStyle():Style
		{
			if(_defaultStyle==null)
			{
				_defaultStyle = new PredefinedLineStyle();
			}
			return _defaultStyle;
			
		}	
		
		
	}	
}