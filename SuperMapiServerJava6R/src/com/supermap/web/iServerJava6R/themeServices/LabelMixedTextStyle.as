package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_LabelMixedTextStyle_Title}.
	 * <p>${iServerJava6R_LabelMixedTextStyle_Description}</p> 
	 * 
	 */	
	public class LabelMixedTextStyle
	{
		private var _defaultStyle:ServerTextStyle = new ServerTextStyle();
		private var _separator:String = "";
		private var _separatorEnabled:Boolean = false;
		private var _splitIndexes:Array = new Array();
		private var _styles:Array = new Array();

		/**
		 * ${iServerJava6R_LabelMixedTextStyle_constructor_D} 
		 * 
		 */		
		public function LabelMixedTextStyle():void
		{
			
		}
		
		/**
		 * ${iServerJava6R_LabelMixedTextStyle_attribute_styles_D}.
		 * <p>${iServerJava6R_LabelMixedTextStyle_attribute_styles_remarks}</p> 
		 * @see #defaultStyle
		 * @return 
		 * 
		 */		
		public function get styles():Array
		{
			return _styles;
		}

		public function set styles(value:Array):void
		{
			_styles = value;
		}

		/**
		 * ${iServerJava6R_LabelMixedTextStyle_attribute_splitIndexes_D}.
		 * <p>${iServerJava6R_LabelMixedTextStyle_attribute_splitIndexes_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get splitIndexes():Array
		{
			return _splitIndexes;
		}

		public function set splitIndexes(value:Array):void
		{
			_splitIndexes = value;
		}

		/**
		 * ${iServerJava6R_LabelMixedTextStyle_attribute_separatorEnabled_D}.
		 * <p>${iServerJava6R_LabelMixedTextStyle_attribute_separatorEnabled_remarks}</p> 
		 * @see #separator
		 * @see #splitIndexes
		 * @return 
		 * 
		 */		
		public function get separatorEnabled():Boolean
		{
			return _separatorEnabled;
		}

		public function set separatorEnabled(value:Boolean):void
		{
			_separatorEnabled = value;
		}

		/**
		 * ${iServerJava6R_LabelMixedTextStyle_attribute_sparator_D}.
		 * <p>${iServerJava6R_LabelMixedTextStyle_attribute_sparator_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get separator():String
		{
			return _separator;
		}

		public function set separator(value:String):void
		{
			_separator = value;
		}

		/**
		 * ${iServerJava6R_LabelMixedTextStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public function get defaultStyle():ServerTextStyle
		{
			return _defaultStyle;
		}

		public function set defaultStyle(value:ServerTextStyle):void
		{
			_defaultStyle = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"defaultStyle\":" + this.defaultStyle.toJSON() + "," ;
			
			json += "\"separator\":" + "\"" + this.separator + "\"" + "," ;
			
			json += "\"separatorEnabled\":" + this.separatorEnabled + "," ;
			
			if(this.splitIndexes.length)
			{			
				json += "\"splitIndexes\":" + "["　+　this.splitIndexes + "]" + "," ;	
			}
			else
			{
				json += "\"splitIndexes\":" + "[]" + "," ;	
			}
			
			if(this.styles.length)
			{		
				json += "\"styles\":" + "[";
				var stylesLength:int = this.styles.length;
				for(var i:int = 0; i< stylesLength; i++)
				{	
					var serverTextStyle:ServerTextStyle = this.styles[i] as ServerTextStyle;
					
					if(i == this.styles.length - 1)						
						json += serverTextStyle.toJSON();						
					else						
						json += serverTextStyle.toJSON() + ",";	
				}
				json += "]";				
			}
			else
			{
				json += "\"styles\":" + "[]" ;
			}			
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}

	}
}