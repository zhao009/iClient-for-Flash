package com.supermap.web.mapping
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.MathUtil;
	import com.supermap.web.utils.ScaleUtil;
	
	import flash.net.*;
	
	import mx.events.PropertyChangeEvent;
	import mx.utils.*;
	
	use namespace sm_internal;
	
	/**
	 * ${mapping_TiledCachedLayer_Title}.
	 * <p>${mapping_TiledCachedLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class TiledCachedLayer extends TiledLayer
	{	
		/**
		 * @private 
		 */				
		protected var _scales:Array;
		
		sm_internal var cacheOutputScales:Array;
		/**
		 * ${mapping_TiledCachedLayer_constructor_None_D} 
		 * 
		 */		
		public function TiledCachedLayer()
		{
		}
		
		/**
		 * ${mapping_TiledCachedLayer_attribute_resolutions_D}.
		 * <p>${mapping_TiledCachedLayer_attribute_resolutions_remarks_D}</p> 
		 * @see #scales
		 * @see com.supermap.web.utils.ScaleUtil
		 * @return 
		 * 
		 */		
		public function get resolutions():Array
		{
			return _resolutions;
		}
		public function set resolutions(value:Array) : void
		{
			if(value == null)
			{
				return;
			}
			var old_resolutions:Array = this._resolutions;
			var length:int = value.length;
			var tempArr:Array = [];
			for (var j:int = 0; j < value.length; j++)
			{
				if(isNaN(value[j]) || value[j] <= 0)
				{
					continue;
				}
				tempArr.push(value[j]);
			}
			if (ObjectUtil.compare(old_resolutions, tempArr) != 0)
			{
				this._resolutions = MathUtil.getUniqueArray(tempArr.sort(Array.NUMERIC | Array.DESCENDING));
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "resolutions", old_resolutions, value));
				}
			}
		}
		
		/**
		 * ${mapping_TiledCachedLayer_attribute_scales_D}.
		 * ${mapping_TiledCachedLayer_attribute_scales_remarks_D} 
		 * @see #resolutions
		 * @return 
		 * 
		 */		
		public function get scales():Array
		{
			if(_scales == null)
			{
				//这个异常值以后还得改
				return null;
			}
			return _scales;
		}
		public function set scales(value:Array) : void
		{		
			if(value == null)
			{
				return;
			}
			
			var length:int = value.length;
			var tempArr:Array = [];
			if (value[0] > 1)
			{
				cacheOutputScales = [];
				
				for (var j:int = 0; j < value.length; j++)
				{
					if(isNaN(value[j]) || value[j] <= 0)
					{
						continue;
					}
					this.cacheOutputScales.push(value[j]);
					tempArr.push(1.0 / value[j]);
				}
			}
			else
			{
				for (j = 0; j < value.length; j++)
				{
					if(isNaN(value[j]) || value[j] <= 0)
					{
						continue;
					}
					tempArr.push(value[j]);
				}
			}
			
			var old_scales:Array = this._scales;
			if (ObjectUtil.compare(old_scales, tempArr) != 0)
			{
				this._scales = MathUtil.getUniqueArray(tempArr.sort(Array.NUMERIC));
				if(!isNaN(this.dpi) && this.dpi != 0)
				{
					if(this.CRS)
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, this.dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, this.dpi);
				}		
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scales", old_scales, this._scales));
				}
			}
		}
		
		/**
		 *继承自Layer,绘制或重绘图层时需调用的接口
		 * 
		 */				
		override sm_internal function setMap(map:Map) : void
		{
			super.setMap(map);
			if(map.baseLayer != this && this.scales != null)
			{
				if(map.scales != null)
				{
					map.scales = this.scales.concat(map.scales);
				}		
				else
				{
					map.scales = this.scales;
				}
			}
			
			if(map.baseLayer != this && this.resolutions != null)
			{
				if(map.resolutions != null)
				{
					var tempRes:Array = [];
					if(map.scales &&　this._scales)
					{
						for (var j:int = 0; j < this._scales.length; j++)
						{
							var curScale:Number = this._scales[j];
							var isContain:Boolean = false;
							
							var i:int = 0;
							for (i; i < map.scales.length; i++)
							{
								if(map.scales[i] == curScale)
								{
									isContain = true;
									break;
								}
							}
							
							if(!isContain)
								tempRes.push(this.resolutions[j]);
							else
								this.resolutions[j] = this.map.resolutions[i];
						}
					}
					else
					{
						tempRes = this.resolutions;
					}
					
					map.resolutions = tempRes.concat(map.resolutions);
				}		
				else
				{
					map.resolutions = this.resolutions;
				}
			}
		}
		
		override sm_internal function getTileURL2(row:int, col:int, level:int, resolution:Number) : URLRequest
		{		
			return this.getTileURL(row, col, level);
		}
		
		/**
		 * ${mapping_TiledCachedLayer_method_protected_getTileURL_D} 
		 * @param row ${mapping_TiledCachedLayer_method_protected_getTileURL_param_row}
		 * @param col ${mapping_TiledCachedLayer_method_protected_getTileURL_param_col}
		 * @param level ${mapping_TiledCachedLayer_method_protected_getTileURL_param_level}
		 * @return ${mapping_TiledCachedLayer_method_protected_getTileURL_return}
		 * 
		 */		
		protected function getTileURL(row:int, col:int, level:int) : URLRequest
		{
			return null;
		}
		
	}
}