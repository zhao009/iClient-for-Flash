package com.supermap.web.gears.components
{ 
	import com.supermap.web.iServerJava6R.layerServices.GetLayersInfoService;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	internal class LegendTask extends GetLayersInfoService
	{   
		private var _layerID:String;
		
		public function LegendTask(url:String)
		{
			super(url);     
		}
 
		public function get layerID():String
		{
			return _layerID;
		}

		public function set layerID(value:String):void
		{
			_layerID = value; 
		}

		public function excute():void
		{   
			if(url != null)
			{
				this.processAsync(null);
			}
		} 
	}
}