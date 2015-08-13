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
	 * ${clustering_CellClusterStyle_Title}.
	 * <p>${clustering_CellClusterStyle_Description}</p>
	 * 
	 */	
	public class CellClusterStyle extends Style
	{
		private var _backgroundColor:Number = 0xff0000;
		private var _backgroundAlpha:Number = 0.75;
		private var _borderThickness:Number = 2;
		private var _borderColor:Number = 0xffffff;
		private var _borderAlpha:Number = 0.8;
		private var _cornerRadius:Number = 5;
		private var _paddingLeft:Number = 2;
		private var _paddingRight:Number = 2;
		private var _paddingTop:Number = 2;
		private var _paddingBottom:Number = 2;
		private var _size:Number = 70;
		private var _isSizeWithWeightFactor:Boolean = true;
		private var _textFormat:TextFormat;
		private static var _instance:CellClusterStyle;
		
		/**
		 * ${clustering_CellClusterStyle_constructor_D} 
		 * 
		 */		
		public function CellClusterStyle()
		{
		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_backgroundAlpha_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get backgroundAlpha() : Number
		{
			return this._backgroundAlpha;
		}	
		public function set backgroundAlpha(value:Number) : void
		{
			var old_value:Number = this.backgroundAlpha;
			if (old_value !== value)
			{
				this._backgroundAlpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundAlpha", old_value, value));
				}
			}

		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_backgroundColor_D} 
		 * @default 7786752
		 * @return 
		 * 
		 */		
		public function get backgroundColor() : Number
		{
			return this._backgroundColor;
		}	
		public function set backgroundColor(value:Number) : void
		{
			var old_value:Number = this.backgroundColor;
			if (old_value !== value)
			{
				this._backgroundColor = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "backgroundColor", old_value, value));
				}
			}

		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_borderAlpha_D} 
		 * @default 1
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
		 * ${clustering_CellClusterStyle_attribute_borderColor_D} 
		 * @default 0
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
		 * ${clustering_CellClusterStyle_attribute_borderThickness_D}
		 * @default 1 
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
		
		/**
		 * ${clustering_CellClusterStyle_attribute_cornerRadius_D} 
		 * @default 5
		 * @return 
		 * 
		 */		
		public function get cornerRadius() : Number
		{
			return this._cornerRadius;
		}
		public function set cornerRadius(value:Number) : void
		{
			var old_value:Number = this.cornerRadius;
			if (old_value !== value)
			{
				this._cornerRadius = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "cornerRadius", old_value, value));
				}
			}
		}
		
		sm_internal static function get instance() : CellClusterStyle
		{
			if (_instance === null)
			{
				_instance = new CellClusterStyle;
			}
			return _instance;
		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_paddingBottom_D} 
		 * @return 
		 * 
		 */		
		public function get paddingBottom() : Number
		{
			return this._paddingBottom;
		}	
		public function set paddingBottom(value:Number) : void
		{
			var old_value:Number = this.paddingBottom;
			if (old_value !== value)
			{
				this._paddingBottom = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "paddingBottom", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_paddingTop_D} 
		 * @return 
		 * 
		 */		
		public function get paddingTop() : Number
		{
			return this._paddingTop;
		}		
		public function set paddingTop(value:Number) : void
		{
			var old_value:Number = this.paddingTop;
			if (old_value !== value)
			{
				this._paddingTop = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "paddingTop", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_paddingRight_D} 
		 * @return 
		 * 
		 */		
		public function get paddingRight() : Number
		{
			return this._paddingRight;
		}	
		public function set paddingRight(value:Number) : void
		{
			var old_value:Number = this.paddingRight;
			if (old_value !== value)
			{
				this._paddingRight = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "paddingRight", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_paddingLeft_D} 
		 * @return 
		 * 
		 */		
		public function get paddingLeft() : Number
		{
			return this._paddingLeft;
		}		
		public function set paddingLeft(value:Number) : void
		{
			var old_value:Number = this.paddingLeft;
			if (old_value !== value)
			{
				this._paddingLeft = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "paddingLeft", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_CellClusterStyle_attribute_size_D} 
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
		 * ${clustering_CellClusterStyle_attribute_isSizeWithWeightFactor_D} 
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
		 * ${clustering_CellClusterStyle_attribute_textFormat_D} 
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
			if (this.borderThickness > 0)
			{
				com.graphics.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha);
			}
			com.graphics.beginFill(this.backgroundColor, this.backgroundAlpha);
			com.graphics.drawRoundRect(0, 0, width, height, this.cornerRadius, this.cornerRadius);
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

			var geoPoint:GeoPoint = null;
			var tf:TextField = null;
			var clusterFeature:ClusterFeature = sprite as ClusterFeature;
			if (clusterFeature)
			{
				tf = sprite.getChildByName("textField") as TextField;
				tf.text = clusterFeature.cluster.weight.toString();
				
				if (this._textFormat)
				{
					tf.embedFonts = FlexGlobals.topLevelApplication.systemManager.isFontFaceEmbedded(this._textFormat);
					tf.setTextFormat(this._textFormat);
				}
				tf.x = tf.textWidth * -0.5;
				tf.y = tf.textHeight * -0.5;
				var size:Number = this.isSizeWithWeightFactor ? this._size * clusterFeature.cluster.weightFactor : this._size;
				var halfSize:Number = size * -0.5;
				var width:Number = size - this.paddingLeft - this.paddingRight;
				var height:Number = size - this.paddingTop - this.paddingBottom;
				var left:Number = halfSize + this.paddingRight;
				var right:Number = halfSize + this.paddingTop;
				geoPoint = clusterFeature.geoPoint;
				sprite.x = toScreenX(map, geoPoint.x);
				sprite.y = toScreenY(map, geoPoint.y);
				if (this.borderThickness > 0)
				{
					sprite.graphics.lineStyle(this.borderThickness, this.borderColor, this.borderAlpha);
				}
				sprite.graphics.beginFill(this.backgroundColor, this.backgroundAlpha);
				sprite.graphics.drawRoundRect(left, right, width, height, this.cornerRadius, this.cornerRadius);
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
