package com.supermap.web.clustering
{
	/**
	 * ${clustering_FieldValuesRule_Title}.
	 * <p>${clustering_FieldValuesRule_Description}</p> 
	 * 
	 */	
	public class FieldValuesRule
	{
		/**
		 * @private 
		 */		
		public var array:Array = [];
		
		/**
		 * @private 
		 */		
		public var fieldValueFun:Function;
		
		/**
		 * ${clustering_FieldValuesRule_attribute_SUM_D}
		 */		
		public static const SUM:String = "sum";//求和
		/**
		 * ${clustering_FieldValuesRule_attribute_MAX_D} 
		 */		
		public static const MAX:String = "max";//最大值
		/**
		 * ${clustering_FieldValuesRule_attribute_MIN_D} 
		 */		
		public static const MIN:String = "min";//最小值
		
		public function FieldValuesRule()
		{
		}
		
		//接受外部处理函数参数
		/**
		 * @private 
		 * @param fn
		 * @return 
		 * 
		 */		
		public function setResultNumber(fn:Function):Number
		{
			var result:Number = fn(array);//fn是用户自己定义的一个函数 这个函数用来处理array
//			trace(result);
			return result; 
		}
		
		//求和
		/**
		 * @private 
		 * @param array
		 * @return 
		 * 
		 */		 
		public function sumFn(array:Array):Number 
		{
			var sum:Number = 0;
			for (var i:int;i < array.length; i++) {
				sum += array[i];
			}
			return sum;
		}
		
		//最大值
		/**
		 * @private 
		 * @param array
		 * @return 
		 * 
		 */		
		public function maxFn(array:Array):Number 
		{
			var array:Array = this.sortArray(array);   
			return array[array.length-1];   
			
		}
		
		//最小值
		/**
		 * @private 
		 * @param array
		 * @return 
		 * 
		 */		
		public function minFn(array:Array):Number 
		{
			var array:Array = this.sortArray(array);   
			return array[0];        
		}
		
		/**
		 * @private 
		 * @param numbers
		 * @return 
		 * 
		 */		
		public  function sortArray(numbers:Array):Array{         
			numbers.sort(Array.NUMERIC);   
			return numbers;   
		}		
	}
}