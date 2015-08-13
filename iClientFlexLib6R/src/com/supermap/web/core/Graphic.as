package com.supermap.web.core
{
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.core.styles.graphicStyles.GraphicFillStyle;
	import com.supermap.web.core.styles.graphicStyles.GraphicLineStyle;
	import com.supermap.web.core.styles.graphicStyles.GraphicMarkerStyle;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;

	/**
	 * ${core_Graphic_Title}.
	 * <p>${core_Graphic_Description}</p> 
	 * @see com.supermap.web.mapping.GraphicsLayer
	 * @see com.supermap.web.core.styles.graphicStyles.GraphicMarkerStyle
	 * @see com.supermap.web.core.styles.graphicStyles.GraphicLineStyle
	 * @see com.supermap.web.core.styles.graphicStyles.GraphicFillStyle
	 * @see com.supermap.web.symbol.clover.CloverStyle
	 * 
	 */	
	public class Graphic
	{
		private var _pickColor:int;
		private var _style:Style;
		private var _geometry:Geometry;
		private var _attributes:Object;
		//用于内部分辨不同的Graphic对象
		private var _soleID:int;

		/**
		 * ${core_Graphic_constructor_D} 
		 * @param geometry ${core_Graphic_constructor_param_geometry}
		 * @param style ${core_Graphic_constructor_param_style}
		 * @param attributes ${core_Graphic_constructor_param_attributes}
		 * 
		 */		
		public function Graphic(geometry:Geometry = null, style:Style = null, attributes:Object = null)
		{
			if (geometry)
			{
				if (!style)
				{
					if (geometry is GeoPoint)
					{
						this._style = new GraphicMarkerStyle;
					}
					else if (geometry is GeoLine)
					{
						this._style = new GraphicLineStyle;
					}
					else if (geometry is GeoRegion)
					{
						this._style = new GraphicFillStyle;
					}
				}
				else
					this._style = style;

				this.geometry = geometry;
			}


			this._attributes = attributes;
		}

		sm_internal function get pickColor():int
		{
			return _pickColor;
		}

		sm_internal function set pickColor(value:int):void
		{
			_pickColor = value;
		}

		/**
		 * ${core_Graphic_attribute_style_D} 
		 * @return 
		 * @see com.supermap.web.core.styles.graphicStyles.GraphicMarkerStyle
		 * @see com.supermap.web.core.styles.graphicStyles.GraphicLineStyle
		 * @see com.supermap.web.core.styles.graphicStyles.GraphicFillStyle
		 * @see com.supermap.web.symbol.clover.CloverStyle
		 */		
		public function get style():Style
		{
			return _style;
		}

		public function set style(value:Style):void
		{
			_style = value;
		}

		/**
		 * ${core_Graphic_attribute_geometry_D} 
		 * @return 
		 * @see com.supermap.web.core.geometry.GeoPoint
		 * @see com.supermap.web.core.geometry.GeoRegion
		 * @see com.supermap.web.core.geometry.GeoLine
		 * 
		 */		
		public function get geometry():Geometry
		{
			return _geometry;
		}

		public function set geometry(value:Geometry):void
		{
			if (value)
			{
				if (!_style)
				{
					if (value is GeoPoint)
					{
						this._style = new GraphicMarkerStyle;
					}
					else if (value is GeoLine)
					{
						this._style = new GraphicLineStyle;
					}
					else if (value is GeoRegion)
					{
						this._style = new GraphicFillStyle;
					}
				}
			}
			_geometry = value;
		}

		/**
		 * ${core_Graphic_attribute_attributes_D}.
		 * <p>${core_Graphic_attribute_attributes_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get attributes():Object
		{
			return _attributes;
		}

		public function set attributes(value:Object):void
		{
			_attributes = value;
		}
		
		sm_internal function get soleID():int
		{
			return _soleID;
		}
		
		sm_internal function set soleID(value:int):void
		{
			_soleID = value;
		}


	}
}
