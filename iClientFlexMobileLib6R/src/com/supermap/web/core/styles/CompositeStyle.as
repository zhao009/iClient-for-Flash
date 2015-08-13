package com.supermap.web.core.styles
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	use namespace sm_internal;

	[DefaultProperty("styles")]
	/**
	 * ${core_styles_CompositeStyle_Title}.
	 * <p>${core_styles_CompositeStyle_Description}</p> 
	 * 
	 */	
	public class CompositeStyle extends Style
	{
		private var _styles:ArrayCollection;
		
		/**
		 * ${core_styles_CompositeStyle_constructor_D} 
		 * @param styles ${core_styles_CompositeStyle_constructor_param_styles}
		 * 
		 */		
		public function CompositeStyle(styles:Object = null)
		{
			if (styles)
			{
				this.styles = styles;
			}			
		}
		
		/**
		 * ${core_styles_CompositeStyle_attribute_styles_D} 
		 * @return 
		 * 
		 */		
		public function get styles() : Object
		{
			if (this._styles == null)
			{
				this._styles = new ArrayCollection();
				this._styles.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
			return this._styles;
		}
		
		public function set styles(value:Object) : void
		{
			var ary:Array = null;
			if (this._styles)
			{
				this._styles.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
			if (value is Array)
			{
				this._styles = new ArrayCollection(value as Array);
			}
			else if (value is ArrayCollection)
			{
				this._styles = value as ArrayCollection;
			}
			else
			{
				ary = [];
				if (value != null)
				{
					ary.push(value);
				}
				this._styles = new ArrayCollection(ary);
			}
			this._styles.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			dispatchEventChange();
			dispatchEvent(new Event("stylesChange"));
			
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
			var boundingRectangle1:Rectangle;
			var count:Number;
			var numPictureMarkerSymbol:Number = 0;
			var k:int;
			var child:CompositeStyleComponent;
			var style:Style;
			var drawSprite:Sprite;
			var loadPictureMarker:Boolean;
			var dSprite:Sprite;
			var loadCompleteHandler:Function = function (event:PictureMarkerStyleEvent) : void
			{
				event.target.removeEventListener(PictureMarkerStyleEvent.COMPLETE, loadCompleteHandler);
				count--;
				event.target.visible = true;
				if (count == 0)
				{
					positionSprite(false);
				}
				
			}
				
			var loadCompleteHandler2:Function = function (event:PictureMarkerStyleEvent) : void
			{
				event.target.removeEventListener(PictureMarkerStyleEvent.COMPLETE, loadCompleteHandler2);
				count--;
				if (count == 0)
				{
					sprite.visible = true;
					positionSprite(false);
				}
				
			}

			var positionSprite:Function = function (redrawSymbol:Boolean) : void
			{
				var style:Style = null;
				var spriteComponment:Sprite = null;
				var bolLoadPicture:Boolean = false;
				var i:int = 0;
				var spriteChild:Sprite = null;
				var rectangle:Rectangle = new Rectangle();
				var j:int = 0;
				while (j < _styles.length)
				{		
					style = Style(_styles.getItemAt(j));//取出每一个symbol
					if(style == null)
					{
						continue;
					}
					spriteComponment = sprite.getChildAt(j) as CompositeStyleComponent;
					if (redrawSymbol)
					{
						if (style is PictureMarkerStyle)
						{
							bolLoadPicture = PictureMarkerStyle(style).doNotLoad(spriteComponment, geometry);
							if (bolLoadPicture)
							{
								numPictureMarkerSymbol++;
								count = numPictureMarkerSymbol;
								sprite.visible = false;
								spriteComponment.addEventListener(PictureMarkerStyleEvent.COMPLETE, loadCompleteHandler2, false, 0, false);
								style.draw(spriteComponment, geometry, attributes, map);
							}
							else
							{
								style.draw(spriteComponment, geometry, attributes, map);
								rectangle = rectangle.union(spriteComponment.getBounds(sprite));
							}
						}
						else
						{
							style.draw(spriteComponment, geometry, attributes, map);
							rectangle = rectangle.union(spriteComponment.getBounds(sprite));
						}
					}
					else if (sprite.visible)
					{
						rectangle = rectangle.union(spriteComponment.getBounds(sprite));
					}
					j++;
				}
				if (numPictureMarkerSymbol == 0)
				{
					sprite.x = rectangle.x;
					sprite.y = rectangle.y;
					sprite.width = rectangle.width;
					sprite.height = rectangle.height;
					i = 0;
					while (i < sprite.numChildren)
					{				
						spriteChild = sprite.getChildAt(i) as Sprite;
						spriteChild.x -= sprite.x;
						spriteChild.y -= sprite.y;
						i++;
					}
				}
				
			}	
				
				
				
			if (sprite.numChildren != this._styles.length && this._styles)
			{
				removeAllChildren(sprite);
			}			
			else if (this._styles)				
			{				
				while (k < this._styles.length)
				{			
					child = sprite.getChildAt(k) as CompositeStyleComponent;
					if(this._styles[k] is PictureMarkerStyle)
					{
						if (child.source !== PictureMarkerStyle(this._styles[k]).source)
						{				
							removeAllChildren(sprite);
							break;
						}
					}
					if (child.symbol !== this._styles[k])
					{				
						removeAllChildren(sprite);
						break;
					}
					k++;
				}
				
			}
			if (sprite.numChildren == 0)
			{
				if (this._styles)
				{
					boundingRectangle1 = new Rectangle();
					var aryStyles:ArrayCollection = this._styles;
					var len:int = aryStyles.length;
					for(var i:int = 0; i < len; i++)
					{				
						style = aryStyles[i];
						if(style == null)
						{
							continue;
						}
						drawSprite = new CompositeStyleComponent();
						CompositeStyleComponent(drawSprite).symbol = style;
						sprite.addChild(drawSprite);
						if (style is PictureMarkerStyle)
						{
							loadPictureMarker = PictureMarkerStyle(style).doNotLoad(drawSprite, geometry);
							if (loadPictureMarker)
							{
								numPictureMarkerSymbol++;
								count = numPictureMarkerSymbol;
								drawSprite.visible = false;
								drawSprite.addEventListener(PictureMarkerStyleEvent.COMPLETE, loadCompleteHandler, false, 0, true);
								style.draw(drawSprite, geometry, attributes, map);
							}
							else
							{
								style.draw(drawSprite, geometry, attributes, map);
								boundingRectangle1 = boundingRectangle1.union(drawSprite.getBounds(sprite));
							}
							continue;
						}
						style.draw(drawSprite, geometry, attributes, map);
						boundingRectangle1 = boundingRectangle1.union(drawSprite.getBounds(sprite));
					}
					if (numPictureMarkerSymbol == 0)
					{
						sprite.x = boundingRectangle1.x;
						sprite.y = boundingRectangle1.y;
						sprite.width = boundingRectangle1.width;
						sprite.height = boundingRectangle1.height;
						var n:int = 0;
						while (n < sprite.numChildren)
						{			
							dSprite = sprite.getChildAt(n) as Sprite;
							dSprite.x -= sprite.x;
							dSprite.y -= sprite.y;
							n++;
						}
					}
				}
			}
			else
			{
				if (this._styles && sprite.numChildren == this._styles.length)
				{
					positionSprite(true);
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
			var i:int = 0;
			var style:Style = null;
			if (this._styles && sprite.numChildren == this._styles.length)
			{
				i = 0;
				while (i < this._styles.length)
				{		
					style = Style(this._styles.getItemAt(i));
					style.clear(Sprite(sprite.getChildAt(i)));
					i++;
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
			sprite.x = 0;
			sprite.y = 0;
			
		}
		
		/**
		 * ${core_styles_CompositeStyle_method_clone_D} 
		 * @return 
		 * 
		 */		
		override public function clone() :Style
		{
			var compositeStyle:CompositeStyle = new CompositeStyle(this._styles);
			return compositeStyle;
		}
				
		/**
		 * ${core_styles_CompositeStyle_method_collectionChangeHandler_D} 
		 * 
		 */		
		protected function collectionChangeHandler(event:CollectionEvent) : void
		{
			dispatchEventChange();			
		}

	}
}