package com.supermap.web.clustering
{
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.text.*;
	
	import mx.core.*;
	import mx.events.*;

	
	use namespace sm_internal;
	
	/**
	 * ${clustering_SimpleClusterStyle_Title}.
	 * <p>${clustering_SimpleClusterStyle_Description}</p>
	 * 
	 */	
	public class SimpleClusterStyle extends Style
	{
		private var _alpha:Number = 0.75;
		private var _color:Number = 0xff0000;
		private var _borderThickness:Number = 2;
		private var _borderColor:Number = 0xffffff;
		private var _borderAlpha:Number = 0.8;
		private var _size:Number = 70;
		private var _isSizeWithWeightFactor:Boolean = true;
		private var _textFormat:TextFormat;
		private static var _instance:SimpleClusterStyle;
		
		/**
		 * ${clustering_SimpleClusterStyle_constructor_D} 
		 * 
		 */		
		public function SimpleClusterStyle()
		{
		}
		
		
		/**
		 * ${clustering_SimpleClusterStyle_attribute_alpha_D} 
		 * @default 0.75
		 * @return 
		 * 
		 */		
		public function get alpha() : Number
		{
			return this._alpha;
		}	
		public function set alpha(value:Number) : void
		{
			var old_value:Number = this.alpha;
			if (old_value !== value)
			{
				this._alpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alpha", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SimpleClusterStyle_attribute_color_D}
		 * @default 7786752 
		 * @return 
		 * 
		 */		
		public function get color() : Number
		{
			return this._color;
		}	
		public function set color(value:Number) : void
		{
			var old_value:Number = this.color;
			if (old_value !== value)
			{
				this._color = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "color", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_SimpleClusterStyle_attribute_borderAlpha_D} 
		 * @return 
		 * 
		 */			
		public function get borderAlpha() : Number
		{
			return this._borderAlpha;
		}	
		public function set borderAlpha(value:Number) : void
		{
			var old_value:Number = this.borderAlpha;
			if (old_value !== value)
			{
				this._borderAlpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderAlpha", old_value, value));
				}
			}
		}
		
	
		/**
		 * ${clustering_SimpleClusterStyle_attribute_borderColor_D} 
		 * @return 
		 * 
		 */		
		public function get borderColor() : Number
		{
			return this._borderColor;
		}	
		public function set borderColor(value:Number) : void
		{
			var old_value:Number = this.borderColor;
			if (old_value !== value)
			{
				this._borderColor = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderColor", old_value, value));
				}
			}
		}
		
	
		/**
		 * ${clustering_SimpleClusterStyle_attribute_borderThickness_D} 
		 * @return 
		 * 
		 */		
		public function get borderThickness() : Number
		{
			return this._borderThickness;
		}	
		public function set borderThickness(value:Number) : void
		{
			var old_value:Number = this.borderThickness;
			if (old_value !== value)
			{
				this._borderThickness = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "borderThickness", old_value, value));
				}
			}
		}
		
		sm_internal static function get instance() : SimpleClusterStyle
		{
			if (_instance === null)
			{
				_instance = new SimpleClusterStyle;
			}
			return _instance;
		}
		
		/**
		 * ${clustering_SimpleClusterStyle_attribute_size_D}
		 * @return 
		 * 
		 */		
		public function get size() : Number
		{
			return this._size;
		}	
		public function set size(value:Number) : void
		{
			var old_value:Number = this.size;
			if (old_value !== value)
			{
				this._size = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "size", old_value, value));
				}
			}
			
		}
		
		/**
		 * ${clustering_SimpleClusterStyle_attribute_isSizeWithWeightFactor_D} 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get isSizeWithWeightFactor() : Boolean
		{
			return this._isSizeWithWeightFactor;
		}	
		public function set isSizeWithWeightFactor(value:Boolean) : void
		{
			var old_value:Boolean = this.isSizeWithWeightFactor;
			if (old_value !== value)
			{
				this._isSizeWithWeightFactor = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isSizeWithWeightFactor", old_value, value));
				}
			}
			
		}
		
		/**
		 * ${clustering_SimpleClusterStyle_attribute_textFormat_D} 
		 * @return 
		 * 
		 */		
		public function get textFormat() : TextFormat
		{
			return this._textFormat;
		}	
		public function set textFormat(value:TextFormat) : void
		{
			var old_value:TextFormat = this.textFormat;
			if (old_value !== value)
			{
				this._textFormat = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "textFormat", old_value, value));
				}
			}
		}
			
		/**
		 * @inheritDoc  
		 * @param sprite
		 * 
		 */		
		override public function clear(sprite:Sprite) : void
		{
			sprite.graphics.clear();
		}
		/**
		 * @inheritDoc  
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */		
		override sm_internal function createSwatch(width:Number = 50, height:Number = 50) : UIComponent
		{
			var com:UIComponent = new UIComponent();
			com.width = width;
			com.height = height;
			var halfWidth:Number = width * 0.5;
			var halfHeight:Number = height * 0.5;
			com.graphics.beginFill(this._color, this._alpha);
			com.graphics.drawCircle(halfWidth, halfHeight, Math.min(halfWidth, halfHeight));
			com.graphics.endFill();
			return com;
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
			var tf:TextField = null;
			var geoPoint:GeoPoint = null;
			var clusterFeature:ClusterFeature = sprite as ClusterFeature;
			if (clusterFeature)
			{
				var weight:Number = clusterFeature.cluster.weight;
				var weightFactor:Number = clusterFeature.cluster.weightFactor;
				tf = sprite.getChildByName("textField") as TextField;
				tf.text = weight.toString();
				if (this._textFormat)
				{
					tf.embedFonts = FlexGlobals.topLevelApplication.systemManager.isFontFaceEmbedded(this._textFormat);
					tf.setTextFormat(this._textFormat);
				}
				tf.x = -1 - (tf.textWidth >> 1);
				tf.y = -2 - (tf.textHeight >> 1);
				geoPoint = clusterFeature.geoPoint;
				sprite.x = toScreenX(map, geoPoint.x);
				sprite.y = toScreenY(map, geoPoint.y);		
				var circleSize:Number = this.isSizeWithWeightFactor ? this._size * 0.5 * weightFactor : this._size * 0.5;
				if (this.borderThickness > 0)
				{
					sprite.graphics.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha);
				}
				sprite.graphics.beginFill(this._color, this._alpha);
				sprite.graphics.drawCircle(0, 0, circleSize);
				sprite.graphics.endFill();
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
		}
		/**
		 * @inheritDoc  
		 * @param sprite
		 * @param geometry
		 * @param attributes
		 * @param map
		 * 
		 */		
		override public function initialize(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{
			var tf:TextField = null;
			if (sprite is ClusterFeature)
			{
				tf = new TextField();
				tf.name = "textField";
				tf.mouseEnabled = false; 
				tf.mouseWheelEnabled = false;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				tf.selectable = false;
				tf.autoSize = TextFieldAutoSize.CENTER;
				tf.textColor = 0xffffff;
				sprite.addChild(tf);
			}
		}
		
		
		
	}
}