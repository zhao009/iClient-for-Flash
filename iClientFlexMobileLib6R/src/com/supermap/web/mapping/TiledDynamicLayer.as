package com.supermap.web.mapping
{
	import com.supermap.web.sm_internal;
	
	import flash.net.*;

	use namespace sm_internal;
	/**
	 * ${mapping_TiledDynamicLayer_Title}.
	 * <p>${mapping_TiledDynamicLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class TiledDynamicLayer extends TiledLayer
	{
		/**
		 * ${mapping_TiledDynamicLayer_constructor_None_D} 
		 * 
		 */		
		public function TiledDynamicLayer()
		{
		}
		
		//
		//根据当前的细节层次以及瓦片的行列号向服务端请求数据
		// 因为每个服务端的请求URL不统一，因此该接口由子类负责实现。 
		override sm_internal function getTileURL2(row:int, col:int, level:int, resolution:Number) : URLRequest
		{
			return this.getTileURL(row, col, resolution);
		}
		
		/**
		 * ${mapping_TiledDynamicLayer_method_protected_getTileURL_D} 
		 * @param row ${mapping_TiledDynamicLayer_method_protected_getTileURL_param_row}
		 * @param col ${mapping_TiledDynamicLayer_method_protected_getTileURL_param_col}
		 * @param resolution ${mapping_TiledCachedLayer_method_protected_getTileURL_param_resolution}
		 * @return ${mapping_TiledDynamicLayer_method_protected_getTileURL_return}
		 * 
		 */		
		protected function getTileURL(row:int, col:int, resolution:Number) : URLRequest
		{
			return null;
		}
	}
}