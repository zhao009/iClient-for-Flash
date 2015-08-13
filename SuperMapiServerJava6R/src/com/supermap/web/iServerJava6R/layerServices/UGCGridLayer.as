package com.supermap.web.iServerJava6R.layerServices
{ 
	import com.supermap.web.utils.serverTypes.ServerColor;
	import com.supermap.web.utils.serverTypes.ServerStyle;

	/**
	 * ${iServerJava6R_UGCGridLayer_Title}.
	 * <p>${iServerJava6R_UGCGridLayer_Description}</p> 
	 * 
	 */	
	public class UGCGridLayer extends UGCLayer
	{  
		private var _colors:Array;
		private var _dashStyle:ServerStyle;
		private var _gridType:String;
		private var _horizontalSpacing:Number;
		private var _sizeFixed:Boolean;
		private var _solidStyle:ServerStyle;
		private var _specialColor:ServerColor;
		private var _specialValue:Number;
		private var _verticalSpacing:Number;
		
		/**
		 * ${iServerJava6R_UGCGridLayer_constructor_D} 
		 * 
		 */		
		public function UGCGridLayer()
		{
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_VerticalSpacing_D} 
		 * @return 
		 * 
		 */		
		public function get verticalSpacing():Number
		{
			return _verticalSpacing;
		}

		public function set verticalSpacing(value:Number):void
		{
			_verticalSpacing = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_SpecialValue_D} 
		 * @return 
		 * 
		 */		
		public function get specialValue():Number
		{
			return _specialValue;
		}

		public function set specialValue(value:Number):void
		{
			_specialValue = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_SpecialColor_D} 
		 * @return 
		 * 
		 */		
		public function get specialColor():ServerColor
		{
			return _specialColor;
		}

		public function set specialColor(value:ServerColor):void
		{
			_specialColor = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_SolidStyle_D} 
		 * @return 
		 * 
		 */		
		public function get solidStyle():ServerStyle
		{
			return _solidStyle;
		}

		public function set solidStyle(value:ServerStyle):void
		{
			_solidStyle = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_SizeFixed_D} 
		 * @return 
		 * 
		 */		
		public function get sizeFixed():Boolean
		{
			return _sizeFixed;
		}

		public function set sizeFixed(value:Boolean):void
		{
			_sizeFixed = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_HorizontalSpacing_D} 
		 * @return 
		 * 
		 */		
		public function get horizontalSpacing():Number
		{
			return _horizontalSpacing;
		}

		public function set horizontalSpacing(value:Number):void
		{
			_horizontalSpacing = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_GridType_D} 
		 * @see GridType
		 * @return 
		 * 
		 */		
		public function get gridType():String
		{
			return _gridType;
		}

		public function set gridType(value:String):void
		{
			_gridType = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_DashStyle_D} 
		 * @return 
		 * 
		 */		
		public function get dashStyle():ServerStyle
		{
			return _dashStyle;
		}

		public function set dashStyle(value:ServerStyle):void
		{
			_dashStyle = value;
		}

		/**
		 * ${iServerJava6R_UGCGridLayer_attribute_Colors_D} 
		 * @return 
		 * 
		 */		
		public function get colors():Array
		{
			return _colors;
		}

		public function set colors(value:Array):void
		{
			_colors = value;
		}

	}
}