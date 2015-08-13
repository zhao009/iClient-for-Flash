package com.supermap.web.core.styles
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import mx.events.PropertyChangeEvent;
	
	/**
	 * ${core_styles_GradientFillStyle_Title}.
	 * <p>${core_styles_GradientFillStyle_Description}</p> 
	 * 
	 */	
	public class GradientFillStyle extends FillStyle
	{		
		private var _type:String = GradientType.LINEAR;
		private var _colors:Array;
		private var _alphas:Array;
		private var _ratios:Array;
		private var _matrix:Matrix = null;
		private var _spreadMethod:String = "pad";		
		private var _interpolationMethod:String = "rgb";		
		private var _focalPointRatio:Number = 0;
		
		/**
		 * ${core_styles_GradientFillStyle_constructor_D} 
		 * @param type ${core_styles_GradientFillStyle_constructor_param_type}
		 * @param colors ${core_styles_GradientFillStyle_constructor_param_colors}
		 * @param alphas ${core_styles_GradientFillStyle_constructor_param_alphas}
		 * @param ratios  ${core_styles_GradientFillStyle_constructor_param_ratios}
		 * 
		 */		
		public function GradientFillStyle(type:String, colors:Array, alphas:Array, ratios:Array, border:PredefinedLineStyle = null, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0)
		{			
			this.type = type;
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			this.matrix = matrix;
			this.spreadMethod = spreadMethod;
			this.interpolationMethod = interpolationMethod;
			this.focalPointRatio = focalPointRatio;
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_focalPointRatio_D} 
		 * @return 
		 * 
		 */		
		public function get focalPointRatio():Number
		{
			return _focalPointRatio;
		}

		public function set focalPointRatio(value:Number):void
		{			
			var oldValue:Number = this._focalPointRatio;
			if (oldValue !== value)
			{
				this._focalPointRatio = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "focalPointRatio", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_interpolationMethod_D} 
		 * @return 
		 * 
		 */		
		public function get interpolationMethod():String
		{
			return _interpolationMethod;
		}

		public function set interpolationMethod(value:String):void
		{			
			var oldValue:String = this._interpolationMethod;
			if (oldValue !== value)
			{
				this._interpolationMethod = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "interpolationMethod", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_spreadMethod_D} 
		 * @return 
		 * 
		 */		
		public function get spreadMethod():String
		{
			return _spreadMethod;
		}

		public function set spreadMethod(value:String):void
		{
			var oldValue:String = this._spreadMethod;
			if (oldValue !== value)
			{
				this._spreadMethod = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "spreadMethod", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_matrix_D} 
		 * @return 
		 * 
		 */		
		public function get matrix():Matrix
		{
			return _matrix;
		}

		public function set matrix(value:Matrix):void
		{
			var oldValue:Matrix = this._matrix;
			if (oldValue !== value)
			{
				this._matrix = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "matrix", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_ratios_D} 
		 * @return 
		 * 
		 */		
		public function get ratios():Array
		{
			return _ratios;
		}

		public function set ratios(value:Array):void
		{
			var oldValue:Array = this._ratios;
			if (oldValue !== value)
			{
				this._ratios = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "ratios", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_alphas_D} 
		 * @return 
		 * 
		 */		
		public function get alphas():Array
		{
			return _alphas;
		}

		public function set alphas(value:Array):void
		{
			var oldValue:Array = this._alphas;
			if (oldValue !== value)
			{
				this._alphas = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alphas", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_colors_D} 
		 * @return 
		 * 
		 */		
		public function get colors():Array
		{
			return _colors;
		}

		public function set colors(value:Array):void
		{
			var oldValue:Array = this._colors;
			if (oldValue !== value)
			{
				this._colors = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "colors", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_GradientFillStyle_attribute_type_D}.
		 * <p>${core_styles_GradientFillStyle_attribute_type_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			var oldValue:String = this._type;
			if (oldValue !== value)
			{
				this._type = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", oldValue, value));
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{					
			if (geometry is GeoRegion)
			{
				var clipRect:Rectangle2D = map.viewBounds;
				
				var drawBounds:Rectangle2D = map.viewBounds;
				var isContain:Boolean = drawBounds.containsRect(geometry.bounds);
				var isInterset:Boolean = drawBounds.intersects(geometry.bounds);
				if (isContain || isInterset)
				{
					this.drawGradientFillSymbol(map,sprite, geometry, clipRect);
				}
			}
			
		}
		
		/**
		 * ${core_styles_GradientFillStyle_method_clone_D} 
		 * @return 
		 * 
		 */		
		public override function clone() : Style
		{
			var gradientFillStyle:GradientFillStyle = new GradientFillStyle(this._type, this._colors, this._alphas, this._ratios, this.border, this._matrix, this._spreadMethod, this._interpolationMethod, this._focalPointRatio);
			return gradientFillStyle;
		}
		
		/**
		 * ${core_styles_GradientFillStyle_method_clear_D} 
		 * @param sprite
		 * 
		 */		
		override public function clear(sprite:Sprite):void
		{
			sprite.graphics.clear();
		}
		
		/**
		 * ${core_styles_GradientFillStyle_method_destroy_D} 
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
		
		private function drawGradientFillSymbol(map:Map, sprite:Sprite, geometry:Geometry, clipRect:Rectangle2D):void
		{
			if(geometry is GeoRegion)
			{
				var geoRegion:GeoRegion = geometry as GeoRegion;
				var bounds:Rectangle2D = (geometry as GeoRegion).bounds;
				
				var rectL:Number = this.toScreenX(map, bounds.left);
				var rectR:Number = this.toScreenX(map, bounds.right);
				var rectMin:Number = this.toScreenY(map, bounds.top);
				var rectMax:Number = this.toScreenY(map, bounds.bottom);	
				
				sprite.x = rectL;
				sprite.y = rectMin;
				sprite.width = rectR - rectL;
				sprite.height = rectMax - rectMin;	
				
				var part:Array = geoRegion.getPart(0) as Array;
				
//				sprite.graphics.beginFill(0,1);
//				sprite.graphics.moveTo(this.toScreenX(map,part[0].x) - sprite.x,this.toScreenY(map,part[0].y) - sprite.y);	
//				for(var i:int = 1;i < part.length; i++)
//				{					
//					sprite.graphics.lineTo(this.toScreenX(map,part[i].x) - sprite.x,this.toScreenY(map,part[i].y) - sprite.y);					
//				}
//				
//				sprite.graphics.endFill();
				
				//this.rect(sprite, sprite.x, sprite.y, sprite.width, sprite.height);	
				
				var matr:Matrix = new Matrix();
				matr.createGradientBox(sprite.width, sprite.height, Math.PI/2, this.toScreenX(map,part[0].x) - sprite.x, this.toScreenY(map,part[0].y) - sprite.y);		
				sprite.graphics.beginGradientFill(this.type, this.colors, this.alphas, this.ratios, matr, this.spreadMethod , this.interpolationMethod , this.focalPointRatio);		
				
				var length:int = part.length;
				var star_commands:Vector.<int> = new Vector.<int>(length, true);
				var star_coord:Vector.<Number> = new Vector.<Number>(length*2, true);
				for(var i:int=0;i<length;i++){
					if(i==0){
						star_commands[i] = 1;
					}
					else{
						star_commands[i] = 2;
					}
					
					star_coord[i*2] = this.toScreenX(map,part[i].x) - sprite.x;
					star_coord[i*2+1] = this.toScreenY(map,part[i].y) - sprite.y;
				}
				
				sprite.graphics.drawPath(star_commands,star_coord);
				//sprite.graphics.drawRect(this.toScreenX(map,part[0].x) - sprite.x, this.toScreenY(map,part[0].y) - sprite.y, sprite.width, sprite.height);
				sprite.graphics.endFill();
			}
		}		

		//画矩形
//		private function rect(sprite:Sprite, rectX:Number, rectY:Number, rectWidth:Number, rectHeight:Number):void
//		{
//			sprite.graphics.clear();			
//			var matr:Matrix = new Matrix();
//			matr.createGradientBox(rectWidth, rectHeight, 0, rectX, rectY);		
//			sprite.graphics.beginGradientFill(this.type, this.colors, this.alphas, this.ratios, matr, this.spreadMethod , this.interpolationMethod , this.focalPointRatio);		
//			
//			sprite.graphics.drawRect(rectX, rectY, rectWidth, rectHeight);
//			  
//		}
	}
}