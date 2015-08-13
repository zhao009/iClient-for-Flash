package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.iServerJava2.ParametersBase;
	import com.supermap.web.sm_internal;
	
	/**
	 * ${iServer2_themeServices_RemoveThemesParameters_Title}.
	 * <p>${iServer2_themeServices_RemoveThemesParameters_Description}</p> 
	 * 
	 * 
	 */	
	public class RemoveThemesParameters extends ParametersBase
	{
		private var _layerNames:Array;
		
		/**
		 * ${iServer2_themeServices_RemoveThemesParameters_constructor_D} 
		 * @param mapName ${iServer2_themeServices_RemoveThemesParameters_constructor_param_mapName}
		 * 
		 */		
		public function RemoveThemesParameters(mapName:String = null)
		{
			super(mapName);
		}		

		/**
		 * ${iServer2_themeServices_RemoveThemesParameters_attribute_layerNames_D} 
		 * @return 
		 * 
		 */		
		public function get layerNames():Array
		{
			return _layerNames;
		}

		public function set layerNames(value:Array):void
		{
			_layerNames = value;
		}

		sm_internal function toJSON():String
		{
			var json:String = "";
			var tempLayers:Array = new Array();
			
			if(this.layerNames)
			{
				if(this.layerNames.length > 0)
					
					for(var i:int = 0; i < this.layerNames.length; i++)
						tempLayers.push("\"" + this.layerNames[i] + "\"");
				
				json += "[" + tempLayers.join(",") + "]";
			}
			return json;
		}
	}
}