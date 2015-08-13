package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_LabelImageCell_Title}.
	 * <p>${iServerJava6R_LabelImageCell_Description}</p> 
	 * @see ThemeLabel
	 * @see LabelSymbolCell
	 * @see LabelThemeCell
	 * 
	 */	
	public class LabelImageCell extends LabelMatrixCell
	{
		private var _height:Number = 10;
		private var _width:Number = 10;
		private var _pathField:String;
		private var _rotation:Number = 0;
		private var _sizeFixed:Boolean = false;
		
		/**
		 * ${iServerJava6R_LabelImageCell_constructor_D} 
		 * 
		 */		
		public function LabelImageCell()
		{
			super();
		}

		/**
		 * ${iServerJava6R_LabelImageCell_attribute_sizeFixed_D} 
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
		 * ${iServerJava6R_LabelImageCell_attribute_rotation_D} 
		 * @return 
		 * 
		 */		
		public function get rotation():Number
		{
			return _rotation;
		}

		public function set rotation(value:Number):void
		{
			_rotation = value;
		}

		/**
		 * ${iServerJava6R_LabelImageCell_attribute_pathField_D} 
		 * @return 
		 * 
		 * @example ${iServerJava6R_LabelImageCell_attribute_pathField_remarks_D}
		 * <listing version = "3.0">
		 *  	//定义图片类型的矩阵标签元素imageCell1
		 * 		var imageCell1:LabelImageCell = new LabelImageCell();
		 * 		with(imageCell1)
		 * 		{
		 * 		    sizeFixed = true;
		 *			pathField = "Path_1";
		 *			type = LabelMatrixCellType.IMAGE;
		 *		};
		 *		//定义图片类型的矩阵标签元素imageCell2
		 *		var imageCell2:LabelImageCell = new LabelImageCell();
		 *		with(imageCell2)
		 *		{
		 *			sizeFixed = true;
		 *			pathField = "Path_2";
		 *			type = LabelMatrixCellType.IMAGE;
		 *		};
		 *		
		 *		//定义标签专题图对象themeLabel
		 *		var themeLabel:ThemeLabel = new ThemeLabel();
		 *		themeLabel.matrixCells = [[themeLabel1],
		 *			[imageCell1,imageCell2],
		 *			[themeLabel2],
		 *			[themeLabel3]];
		 *		themeLabel.background = new ThemeLabelBackground();
		 *		themeLabel.background.labelBackShape = LabelBackShape.RECT;
		 *		themeLabel.background.backStyle.fillSymbolID = 1;
		 *		themeLabel.background.backStyle.lineSymbolID = 5;
		 *		
		 *		return themeLabel;
		 * </listing>
		 */		
		public function get pathField():String
		{
			return _pathField;
		}

		public function set pathField(value:String):void
		{
			_pathField = value;
		}

		/**
		 * ${iServerJava6R_LabelImageCell_attribute_width_D} 
		 * @return 
		 * 
		 */		
		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		/**
		 * ${iServerJava6R_LabelImageCell_attribute_height_D} 
		 * @return 
		 * 
		 */		
		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			json += "\"type\":" + "\"" + this.type + "\",";
			
			json += "\"height\":" + this._height + ",";
			
			json += "\"width\":" + this._width + ",";
			if(this._pathField)
				json += "\"pathField\":" + "\"" + this._pathField + "\",";
			json += "\"rotation\":" + this._rotation + ",";
			
			json += "\"sizeFixed\":" + this._sizeFixed;
			
			json ="{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):LabelImageCell
		{
			var labelImage:LabelImageCell;
			if(object)
			{
				labelImage = new LabelImageCell();
				labelImage._height = object.height;
				labelImage._width = object.width;
				labelImage._pathField = object.pathField;
				labelImage._rotation = object.rotation;
				labelImage._sizeFixed = object.sizeFixed;
				if(object.type)
					labelImage.type = object.type
				
			}
			return labelImage;
		}

	}
}