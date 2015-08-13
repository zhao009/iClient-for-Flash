package com.supermap.web.core.styles
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.mapping.supportClasses.InfoStyleContainer;
	import com.supermap.web.sm_internal;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	
	use namespace sm_internal;
	
	 /**
	  * ${core_styles_InfoStyle_Title}.
	  * <p>${core_styles_InfoStyle_Description}</p> 
	  * @example ${core_styles_InfoStyle_Example}
	  * <listing> 
	  * 	<!--使用 MXML 语言定义 InfoStyle -->
	  * 	&lt;fx:Declarations>
	  *			&lt;ic:InfoStyle id="infoStyle">
	  *				&lt;ic:infoRenderer>
	  *					&lt;fx:Component>
	  *						&lt;s:HGroup gap="5">
	  *							&lt;mx:Image width="100" height="75" source="../assets/pic3.jpg"/>
	  *							&lt;mx:Text text="千岛湖是世界上岛屿最多的湖。位于东经118°58′—119°17′，北纬29°31′—29°41′之间" 
	  *									 color="#255" width="150" height="100%"/>
	  *						&lt;/s:HGroup>
	  *					&lt;/fx:Component>
	  *				&lt;/ic:infoRenderer>
	  *			&lt;/ic:InfoStyle>
	  *		&lt;/fx:Declarations>
	  * 	
	  * 	//使用 InfoStyle
	  * 	var feature:Feature = new Feature();
	  * 	feature.geometry = new GeoPoint(119,29); 
	  * 	feature.style = infoStyle;
	  *		featureLayer.addFeature(feature); 
	  * 	//有关使用 AS 语言定义 InfoStyle 的示例可参见 SuperMap iClient 6R for Flex Samplecode_iServerJava6R
	  * </listing>
	  */	
	 public class InfoStyle extends Style
    {
        private var _infoRenderer:IFactory;
        private var _infoPlacement:String;
		/**
		 * ${core_styles_InfoStyle_attribute_containerStyleName_D}.
		 * <p>${core_styles_InfoStyle_attribute_containerStyleName_remarks}</p>
		 * @see com.supermap.web.mapping.InfoWindow
		 */		
        public var containerStyleName:String;
        
		/**
		 * ${core_styles_InfoStyle_constructor_None_D} 
		 * 
		 */		
        public function InfoStyle()
        {
        }
        
		/**
		 * ${core_styles_InfoStyle_attribute_infoPlacement_D}.
		 * <p>${core_styles_InfoStyle_attribute_infoPlacement_remarks}</p>
		 * @see com.supermap.web.mapping.supportClasses.InfoPlacement 
		 * @return 
		 * 
		 */		
        public function get infoPlacement():String
        {
            return this._infoPlacement;
        }
        
        public function set infoPlacement(value:String) : void
        {
            if (value != this._infoPlacement)
            {
                this._infoPlacement = value;
				dispatchEventChange();
            }
        }
        
		/**
		 * ${core_styles_InfoStyle_attribute_infoRenderer_D} 
		 * @return 
		 * 
		 */		
        public function get infoRenderer():IFactory
        {
            return this._infoRenderer;
        }
        
        public function set infoRenderer(value:IFactory):void
        {
			if (value != this._infoRenderer)
			{
				this._infoRenderer = value;
				dispatchEventChange();
			}
        }
		
		/**
		 * @private 
		 * @param sprite
		 * 
		 */		
		public override function destroy(sprite:Sprite) : void
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
        override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
        {
			if(!map)
			{
				return;
			}
            if (geometry is GeoPoint)
            {
            	var geoPoint:GeoPoint = geometry as GeoPoint;
            	var infoStyleContainer:InfoStyleContainer = null;
        		var renderInstance:Object = null;
        		var currentChildIndex:int = 0;
        		var currentDisObject:DisplayObject = null;
        		var infoContet:DisplayObject = null;
            	if (sprite.numChildren === 0)
                {
                    if (this.infoRenderer)
                    {   
                    	// 在sprite里面新建InfoStyleContainer
                        infoStyleContainer = new InfoStyleContainer(map, this.containerStyleName);
						if(this.infoRenderer is ClassFactory)
                        	renderInstance = this.infoRenderer.newInstance();
						else
							renderInstance = this.infoRenderer
                        if (renderInstance is DisplayObject)
                        {
                            infoStyleContainer.addChild(DisplayObject(renderInstance));
                        }
						infoStyleContainer.geoPoint = geoPoint;
                        sprite.addChild(infoStyleContainer);
                        infoStyleContainer.invalidateSize();
                        infoStyleContainer.invalidateDisplayList();
                    }
                }
                else
                {   // 在sprite里面寻找已经存在的InfoStyleContainer
                    currentChildIndex = 0;
                    while (currentChildIndex < sprite.numChildren)
                    {
                        
                        currentDisObject = sprite.getChildAt(currentChildIndex);
                        if (currentDisObject is InfoStyleContainer)
                        {
                            infoStyleContainer = InfoStyleContainer(currentDisObject);
                            break;
                        }
                        currentChildIndex = currentChildIndex + 1;
                    }
                }
                if (infoStyleContainer)
                {
                    if (this._infoPlacement)
                    {
                        infoStyleContainer.setStyle("infoPlacement", this._infoPlacement);
                    }
                    if (infoStyleContainer.numChildren > 0)
                    {
                        infoContet = infoStyleContainer.getChildAt(0); 
                        if (infoContet.hasOwnProperty("dataProvider"))
                        {
                            infoContet["dataProvider"] = attributes;
                        }
                    }
					infoStyleContainer.data = attributes;
                    this.drawMapPoint(map, sprite, geometry as GeoPoint, infoStyleContainer);
                } 
            }
        }
      
		/**
		 * ${core_styles_InfoStyle_attribute_clone_D} 
		 * @return 
		 * 
		 */		
		public override function clone() : Style
		{
			var infoStyle:InfoStyle = new InfoStyle();
			infoStyle._infoPlacement = this._infoPlacement;
			infoStyle._infoRenderer = this._infoRenderer;
			return infoStyle;
		}
		
        private function drawMapPoint(map:Map, sprite:Sprite, point:GeoPoint, infoContainer:InfoStyleContainer):void
        {
            if (map.viewBounds.containsPoint(new Point2D(point.x, point.y)))
            {
                infoContainer.anchorX = this.toScreenX(map, point.x);
                infoContainer.anchorY = this.toScreenY(map, point.y);
				
                infoContainer.visible = true;
                infoContainer.includeInLayout = true;
            }
            else
            {
                infoContainer.visible = false;
                infoContainer.includeInLayout = false;
            }
        }
    }
}
