package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * @private
	 * ${iServerJava6R_NAResultMapImage_Title}.
	 * <p>${iServerJava6R_NAResultMapImage_Description}</p> 
	 * 
	 */	
	internal class NAResultMapImage
	{ 
		private var _imageData:Array;
		private var _imageURL:String;
		private var _mapParameter:NAResultMapParameter;
		
		/**
		 * ${iServerJava6R_NAResultMapImage_constructor_D} 
		 * 
		 */		
		public function NAResultMapImage()
		{
		}
			
		public function get mapParameter():NAResultMapParameter
		{
			return _mapParameter;
		}

		public function set mapParameter(value:NAResultMapParameter):void
		{
			_mapParameter = value;
		}

		public function get imageURL():String
		{
			return _imageURL;
		}

		public function set imageURL(value:String):void
		{
			_imageURL = value;
		}

		public function get imageData():Array
		{
			return _imageData;
		}

		public function set imageData(value:Array):void
		{
			_imageData = value;
		}

		public static function fromJson(json:Object):NAResultMapImage
		{
			if (json)
			{
				var result:NAResultMapImage = new NAResultMapImage();
				result.imageURL = json.imageURL;
				result.mapParameter = NAResultMapParameter.fromJson(json.mapParameter);
				if (json.imageData)
				{
					result.imageData = [];
					var imageDataLength:int = (json.imageData as Array).length;
					for (var i:int = 0; i < imageDataLength; i++)
					{
						result.imageData.push(json.imageData[i]);
					}
				}
				return result;
			} 
			return null;
		}
	}
}