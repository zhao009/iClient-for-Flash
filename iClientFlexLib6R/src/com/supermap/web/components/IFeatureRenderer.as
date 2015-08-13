package com.supermap.web.components
{
	import com.supermap.web.core.Feature;
	/**
	 * @private 
	 * 
	 */	
	public interface IFeatureRenderer
	{
		public function IFeatureRenderer();
		
		function set feature(value:Feature) : void;
	}
}