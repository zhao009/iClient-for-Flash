package com.supermap.web.mapping
{
	/**
	 * ${mapping_ImageLayer_Title}.
	 * <p>${mapping_ImageLayer_Description} </p>
	 * 
	 * 
	 */	
	public class ImageLayer extends Layer
	{
		private var _imageFormat:String;
		private var _transparent:Boolean;
		

		/**
		 * ${mapping_ImageLayer_constructor_None_D} 
		 * 
		 */		
		public function ImageLayer()
		{
			_imageFormat = ImageFormat.PNG;
		}
		
		/**
		 * ${mapping_ImageLayer_attribute_transparent_D}
		 * @default false 
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
		 * ${mapping_ImageLayer_attribute_imageFormat_D} 
		 * @return 
		 * 
		 */		
		public function get imageFormat():String
		{
			return this._imageFormat;
		}
		public function set imageFormat(value:String):void
		{
			this._imageFormat = value;
		}
	}
}