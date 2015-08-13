package com.supermap.web.mapping
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal; 

	/**
	 * @private
	 * ${mapping_WMSParams_Title}.
	 * ${mapping_WMSParams_Description}
	 * author zyn
	 * 
	 */	
	internal class WMSParams extends OGCParams
	{
		private var _format:String;
		private var _exceptions:String;
		private var _layers:String;
		private var _styles:String;
		private var _width:Number;
		private var _height:Number;
		private var _transparent:Boolean;
		private var _bgcolor:String;
		private var _tiled:Boolean;
		private var _sld:String;
		
		public static const SUPPORTED_VERSIONS:Array = ["1.1.0", "1.1.1", "1.3.0"];
		
		/**
		 * ${mapping_TiledGoogleMapsLayer_constructor_D} 
		 * 
		 */		
		public function WMSParams(layers:String = null,
								  service:String = "WMS", 
								  version:String = "1.1.1", 
								  request:String = "GetMap",
								  bbox:String = null,
								  crs:String = null,
								  format:String = "image/png",
								  width:Number = 256,
								  height:Number = 256,
								  transparent:Boolean = false,
								  tiled:Boolean = false,
								  styles:String = "",
								  bgcolor:String = null,
								  sld:String = null,
								  exceptions:String = null)
		{
			super(service, version, request);
			this._exceptions = exceptions;	
			this.layers = layers;
			this._format = format;
			this._transparent = transparent;
			this._tiled = tiled;
			this._styles = styles;	
			this._bgcolor = bgcolor;
			this._sld = sld;
			this._width = width;
			this._height = height;
			this.crs = crs;
			this.bbox = bbox;
		}
		
		override public function toGETString():String {
			var str:String = super.toGETString();
			if (this._format != null)
				str += "FORMAT=" + this._format + "&";
			
			if (this._exceptions != null)
				str += "EXCEPTIONS=" + this._exceptions + "&";
			
			if (this._layers != null)
				str += "LAYERS=" + encodeURI(this._layers) + "&";
			
			if (this._styles != null)
				str += "STYLES=" + this._styles + "&";
			
			str += "WIDTH=" + this._width + "&";
			str += "HEIGHT=" + this._height + "&";
			str += "TILED=" + this._tiled + "&";
			str += "TRANSPARENT=" + this._transparent.toString().toUpperCase() + "&";
			
			if (this._bgcolor != null)
				str += "BGCOLOR=" + this._bgcolor + "&";
			
			if (this._sld != null)
				str += "SLD=" + this._sld + "&";
			
			return str.substr(0, str.length-1);
		}
		
		//Getters & setters
		/**
		 * ${mapping_WMSParams_attribute_format_D} 
		 * @return 
		 * 
		 */		
		public function get format():String 
		{
			return _format;
		}
		
		public function set format(format:String):void 
		{
			_format = format;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_exceptions_D} 
		 * @return 
		 * 
		 */		
		public function get exceptions():String 
		{
			return _exceptions;
		}
		
		public function set exceptions(exceptions:String):void 
		{
			_exceptions = exceptions;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_layers_D} 
		 * @return 
		 * 
		 */		
		public function get layers() : String
		{
			return this._layers;
		}
		public function set layers(value:String) : void
		{
			this._layers = value;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_styles_D} 
		 * @return 
		 * 
		 */		
		public function get styles():String 
		{
			return _styles;
		}
		
		public function set styles(styles:String):void 
		{
			_styles = styles;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_width_D} 
		 * @return 
		 * 
		 */		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(width:Number):void 
		{
			_width = width;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_height_D} 
		 * @return 
		 * 
		 */		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(height:Number):void 
		{
			_height = height;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_transparent_D} 
		 * @return 
		 * 
		 */		
		public function get transparent():Boolean 
		{
			return _transparent;
		}
		
		public function set transparent(transparent:Boolean):void 
		{
			_transparent = transparent;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_tiled_D} 
		 * @return 
		 * 
		 */		
		public function get tiled():Boolean 
		{
			return _tiled;
		}
		
		public function set tiled(tiled:Boolean):void 
		{
			_tiled = tiled;
		}
		
		/**
		 * ${mapping_WMSParams_attribute_bgcolor_D} 
		 * @return 
		 * 
		 */		
		public function get bgcolor():String 
		{
			return _bgcolor;
		}
		
		public function set bgcolor(bgcolor:String):void 
		{
			_bgcolor = bgcolor;
		}
		
		/**
		 * @private
		 * ${mapping_WMSParams_attribute_sld_D} 
		 * @return 
		 * 
		 */		
		public function get sld():String 
		{
			return this._sld;
		}
		
		public function set sld(value:String):void 
		{
			this._sld = value;
		}
		
		/**
		 * ${mapping_WMSParams_method_fromXML_D} 
		 * @param xml
		 * 
		 */		
		public function fromXML(xml:XML):void
		{		
			this.version = xml.@version[0];
			var srsAndBBox:Array;
			switch(this.version)
			{
				case "1.1.1":
					srsAndBBox = this.parseXML1_1_1(xml);
					break;
				case "1.3.0":				
					srsAndBBox = this.parseXML1_3_0(xml);
					break;
				default:
					srsAndBBox = this.parseXML1_1_1(xml);
					break;
			}
			if(srsAndBBox)
			{
				if(!this.crs) 
					this.crs = srsAndBBox[0].crs;
				for(var i:int = 0; i < srsAndBBox.length; i++)
				{
					if(srsAndBBox[i].crs == this.crs)
					{
						this.bbox = srsAndBBox[i].bbox;
						break;
					}
				}
			}		
		}
		
		private function parseXML1_1_1(xml:XML):Array
		{		
			var srsAndBBox:Array = [];
			for　each　(var　item:XML in　xml.elements())　
			{
				if(item.name().localName == "Capability")
				{
					for　each　(var　cap_item:XML in　item.elements())　
					{
						if(cap_item.name().localName == "Layer")
						{
							for　each　(var　lay_item:XML in　cap_item.elements())　
							{
								var crsAndBoundingBox:Object = {};
								if(lay_item.name().localName == "SRS")
								{
									var crs:String = lay_item.toString();
									if(crs.search("EPSG") >= 0)
									{
										crsAndBoundingBox.crs = crs;
										srsAndBBox.push(crsAndBoundingBox);
									}
								}
								if(lay_item.name().localName == "BoundingBox")
								{	
									var bboxcrs:String = lay_item.@SRS;
									for(var i:int = 0; i < srsAndBBox.length; i++){
										if(bboxcrs.search("EPSG") >= 0 && srsAndBBox[i].crs == bboxcrs)
										{
											srsAndBBox[i].bbox = lay_item.@minx + "," +　lay_item.@miny +  "," + lay_item.@maxx + "," +　lay_item.@maxy;
										}	
									}
								}								
							}
						}
					}
				}	
			}
			return srsAndBBox;
		}
		
		/**
		 *  此处没有针对3857与4326进行分别对待 遍历有误 修改为EPSG对应一个bbox
		 * @private
		 */
		sm_internal var srsAndBBox:Array;
		private function parseXML1_3_0(xml:XML):Array
		{		
			srsAndBBox = [];
			var crss:Array = [];
			for　each　(var　item:XML in　xml.elements())　
			{
				if(item.name().localName == "Capability")
				{
					for　each　(var　cap_item:XML in　item.elements())　
					{
						if(cap_item.name().localName == "Layer")
						{
							for　each　(var　lay_item:XML in　cap_item.elements())　
							{
								var crsAndBoundingBox:Object = {};
								if(lay_item.name().localName == "CRS")
								{
									var crs:String = lay_item.toString();
									if(crs.search("EPSG") >= 0)
									{
										crsAndBoundingBox.crs = crs;
										srsAndBBox.push(crsAndBoundingBox);
									}
									crss.push(crs);
								}
								if(lay_item.name().localName == "BoundingBox")
								{
									var bboxcrs:String = lay_item.@CRS;
									for(var i:int = 0; i < srsAndBBox.length; i++){
										if(bboxcrs.search("EPSG") >= 0 && srsAndBBox[i].crs == bboxcrs)
										{
											srsAndBBox[i].bbox = lay_item.@miny + "," +　lay_item.@minx +  "," + lay_item.@maxy + "," +　lay_item.@maxx;
										}	
									}
								}
							}
						}
					}
				}	
			}
			return srsAndBBox;		
		}
		
		sm_internal function srsToCRS() : CoordinateReferenceSystem
		{
			var crs:CoordinateReferenceSystem = new CoordinateReferenceSystem();
			if(this.crs != null && this.crs != "")
			{
				switch(this.version)
				{
					case "1.1.1":
						crs.wkid = parseInt(this.crs.substr(5));
						break;
					case "1.3.0":				
						crs.wkid = parseInt(this.crs.substr(5));
						break;
					default:
						crs.wkid = parseInt(this.crs.substr(5));
						break;
				}
			}
			return crs;
		}
		
		sm_internal static function rectToYXBBox(rect:Rectangle2D, crs:String = "EPSG:4326") : String
		{
			if(rect)
			{
				if(crs == "EPSG:4326")
				{
					return rect.bottom.toString() +"," + rect.left.toString() + "," +
						rect.top.toString() + "," + rect.right.toString();
				}
				if(crs == "EPSG:3857")
				{
					return rect.left.toString() +"," + rect.bottom.toString() + "," +
						rect.right.toString() + "," + rect.top.toString();
				}
			}
			return null;
		}
		
		sm_internal function getBoundsByCRS(crs:String = "EPSG:4326"):String
		{
			var bbox:String;
			if(srsAndBBox)
			{
				for(var i:int = 0; i < srsAndBBox.length; i++)
				{
					var obj:Object = srsAndBBox[i];
					if(obj.crs == crs)
						bbox =  obj.bbox;
				}
				return bbox;
			}
			return null;
		}
		
		public function clone():WMSParams
		{
			var wmsParas:WMSParams = new WMSParams;
			wmsParas.bgcolor = this.bgcolor;
			wmsParas.bbox = this.bbox;
			wmsParas.crs = this.crs;
			wmsParas.exceptions = this.exceptions;
			wmsParas.format = this.format;
			wmsParas.height = this.height;
			wmsParas.width = this.width;
			wmsParas.layers = this.layers;
			wmsParas.request = this.request;
			wmsParas.service = this.service;
			wmsParas.sld = this.sld;
			wmsParas.styles = this.styles;
			wmsParas.tiled = this.tiled;
			wmsParas.transparent = this.transparent;
			wmsParas.version = this.version;
			return wmsParas;
		}
	}
}