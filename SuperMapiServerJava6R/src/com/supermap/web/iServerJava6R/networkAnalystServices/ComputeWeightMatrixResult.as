package com.supermap.web.iServerJava6R.networkAnalystServices
{ 
	import com.supermap.web.sm_internal;
	
	import mx.collections.ArrayCollection;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ComputeWeightMatrixResult_Title}.
	 * <p>${iServerJava6R_ComputeWeightMatrixResult_Description}</p> 
	 * 
	 */	
	public class ComputeWeightMatrixResult
	{
		private var _weightMatrix:Array;
		
		/**
		 * ${iServerJava6R_ComputeWeightMatrixResult_constructor_D} 
		 * 
		 */		
		public function ComputeWeightMatrixResult()
		{
		}
		
		/**
		 * ${iServerJava6R_ComputeWeightMatrixResult_attribute_WeightMatrix_D}.
		 * <p>${iServerJava6R_ComputeWeightMatrixResult_attribute_WeightMatrix_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get weightMatrix():Array
		{
			return _weightMatrix;
		}
 
		sm_internal static function fromJson(json:Object):ComputeWeightMatrixResult
		{
			if(json)
			{
				var result:ComputeWeightMatrixResult = new ComputeWeightMatrixResult();
				if((json as Array).length)
				{
					result._weightMatrix = [];
					var jsonLength:int = (json as Array).length;
					for(var i:int = 0; i < jsonLength; i++)
					{
						var list:ArrayCollection = new ArrayCollection();
						
						var length2:int = (json[i] as Array).length;
						for(var j:int = 0; j < length2; j++)
						{
							list.addItem(json[i][j]);
						}
						result._weightMatrix.push(list);//对结果进行组装
					}
				}//if
				return result;
			}//if
			return null;
		} 
	}
}