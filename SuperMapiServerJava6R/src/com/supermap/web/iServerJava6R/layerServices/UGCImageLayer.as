package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.utils.serverTypes.ServerColor;

	/**
	 * ${iServerJava6R_UGCImageLayer_Title}.
	 * <p>${iServerJava6R_UGCImageLayer_Description}</p> 
	 * 
	 */	
	public class UGCImageLayer extends UGCLayer
	{ 
		private var _brightness:int;
		private var _colorSpaceType:String;
		private var _contrast:int;
		private var _displayBandIndexes:Array;
		private var _transparent:Boolean;
		private var _transparentColor:ServerColor;
		
		/**
		 * ${iServerJava6R_UGCImageLayer_constructor_D} 
		 * 
		 */		
		public function UGCImageLayer()
		{
		}

		/**
		 * ${iServerJava6R_UGCImageLayer_attribute_TransparentColor_D} 
		 * @return 
		 * 
		 */		
		public function get transparentColor():ServerColor
		{
			return _transparentColor;
		}

		public function set transparentColor(value:ServerColor):void
		{
			_transparentColor = value;
		}

		/**
		 * ${iServerJava6R_UGCImageLayer_attribute_Transparent_D} 
		 * @return 
		 * 
		 */		
		public function get transparent():Boolean
		{
			return _transparent;
		}

		public function set transparent(value:Boolean):void
		{
			_transparent = value;
		}

		/**
		 * ${iServerJava6R_UGCImageLayer_attribute_DisplayBandIndexes_D} 
		 * @return 
		 * 
		 */		
		public function get displayBandIndexes():Array
		{
			return _displayBandIndexes;
		}

		public function set displayBandIndexes(value:Array):void
		{
			_displayBandIndexes = value;
		}

		/**
		 * ${iServerJava6R_UGCImageLayer_attribute_Contrast_D} 
		 * @return 
		 * 
		 */		
		public function get contrast():int
		{
			return _contrast;
		}

		public function set contrast(value:int):void
		{
			_contrast = value;
		}

		/**
		 * ${iServerJava6R_UGCImageLayer_attribute_ColorSpaceType_D} 
		 * @see ColorSpaceType
		 * @return 
		 * 
		 */		
		public function get colorSpaceType():String
		{
			return _colorSpaceType;
		}

		public function set colorSpaceType(value:String):void
		{
			_colorSpaceType = value;
		}

		/**
		 * ${iServerJava6R_UGCImageLayer_attribute_Brightness_D} 
		 * @return 
		 * 
		 */		
		public function get brightness():int
		{
			return _brightness;
		}

		public function set brightness(value:int):void
		{
			_brightness = value;
		}

	}
}