package com.supermap.web.utils
{
	import com.supermap.web.sm_internal;	
	
	use namespace sm_internal;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class MathUtil
	{
		sm_internal static const DBL_EPSILON:Number= 1E-06;
		
		sm_internal static function getNearest(resolution:Number, resolutions:Array, minRes:Number, maxRes:Number) : Number
		{
			if (resolutions == null || resolutions.length < 1)
			{
				return clipResolution(resolution, minRes, maxRes);
			}
			var index:int;
			if (minRes > 0 || maxRes > 0)
			{			
				index = getNearestIndex(resolution, resolutions, minRes, maxRes);
			}
			else
			{
				index = getNearestIndex2(resolution, resolutions);
			}
			return resolutions[index];
		}
		
		sm_internal static function getNearestIndex(resolution:Number, resolutions:Array, minRes:Number, maxRes:Number) : int
		{
			var i:int = getNearestIndex2(resolution, resolutions);
			if ((minRes > 0 || maxRes > 0) && i != -1)
			{
				if (resolutions[i] < minRes)
				{
					i--;				
				}
				else if (resolutions[i] > maxRes)
				{
					i++;
				}
				i = (i < 0) ? 0 : (i >= resolutions.length ? resolutions.length - 1 : i);
			}
			return i;
		}
		
		
		sm_internal static function getNearestIndex2(resolution:Number, resolutions:Array) : int
		{
			if (resolutions == null || resolutions.Length < 1)
			{
				return -1;
			}
			var index:int = 0;
			for (var i:int = 0; i < resolutions.length; i++)
			{
//				if (numsAreClose(resolution,resolutions[i]))
//				{
//					index = i;
//					break;
//				}
				if (Math.abs(resolutions[i] - resolution) < Math.abs(resolutions[index] - resolution))
				{
					index = i;
				}
			}
			return index;
		}
		
		sm_internal static function getNearest2(resolution:Number, resolutions:Array) : Number
		{
			if (resolutions == null || resolutions.length < 1)
			{
				return resolution;//直接返回原值
			}
			var index:int = getNearestIndex2(resolution, resolutions);
			return resolutions[index];
		}
		
		sm_internal static function numsAreClose(value1:Number, value2:Number) : Boolean
		{
			if(value1 == value2)
			{
				return true;
			}
			return Math.abs(value1 - value2) < DBL_EPSILON;
		}
		
		sm_internal static function isInResolutionRange(resolution:Number, minResolution:Number, maxResolution:Number) : Boolean
		{
			var bInResolutionRange:Boolean = true;

			if(maxResolution >0 && minResolution > 0)
			{
				if (minResolution <= resolution)
				{
					bInResolutionRange = maxResolution >= resolution;
				}
				else
				{
					bInResolutionRange = false;
				}
			}
			else if(maxResolution > 0)
			{
				bInResolutionRange = maxResolution >= resolution;
			}
			else if(minResolution > 0)
			{
				bInResolutionRange = minResolution <= resolution;
			}			
			
			return bInResolutionRange;
		}
		
		sm_internal static function clipResolution(resolution:Number, minRes:Number, maxRes:Number) : Number
		{
			var res:Number = resolution;
			if (minRes > 0)
			{
				res = Math.max(resolution, minRes);
			}
			if (maxRes > 0)
			{
				res = Math.min(res, maxRes);
			}
			if (res < MathUtil.DBL_EPSILON)
			{
				res = MathUtil.DBL_EPSILON;
			}
			return res;
		}
		
		//归并排序(升序)
		sm_internal static function mergeSort(arr:Array, start:int, end:int):void
		{
			var mid:int = 0;
			if(start < end)
			{
				mid = (start + end) / 2;
				mergeSort(arr, start, mid);
				mergeSort(arr, mid+1, end);
				merge(arr, start, mid, end);
			}
		}
		
		
		private static function merge(arr:Array, start:int, mid:int, end:int):void
		{
			var mergedArray:Array = [];
			var i:int = start;   //arr1的索引
			var j:int = mid + 1;   //arr2的索引
			var k:int = start;   //合并后的数组索引
			while(i <= mid && j <= end)
			{
				if(arr[i] >= arr[j])
				{
					mergedArray[k++] = arr[i++];
				}
				else if(arr[i] < arr[j])
				{
					mergedArray[k++] = arr[j++];
				}
			}
			if(i <= mid)
			{
				while(i <= mid)
				{
					mergedArray[k++] = arr[i++];
				}
			}
			else if(j <= end)
			{
				while(j <= end)
				{
					mergedArray[k++] = arr[j++];
				}
			}
			var length:int = mergedArray.length;
			for(i = 0; i < length; i++)
			{
				arr[start+i] = mergedArray[i];
			}
		}
		
		//对已排序的数组中的重复元素进行剔除
		sm_internal static function getUniqueArray(array:Array):Array
		{
			var uniqueArr:Array = [];
			var length:int = array.length;
			var j:int = 0;
			for(var i:int = 0; i < length; i++)
			{
				if(array[i] == array[i+1])
				{
					continue;
				}
				else
				{
					uniqueArr[j++] = array[i];
				}
			}
			return uniqueArr;
		}
			
	}
}