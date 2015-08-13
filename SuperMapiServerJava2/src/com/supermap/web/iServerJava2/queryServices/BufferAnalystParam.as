package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_BufferAnalystParam_Title}.
	 * <p>${iServer2_BufferAnalystParam_Description}</p>
	 * <p><img src="../../../../../images/BufferAnalyst.bmp"/></p>
	 * 
	 * 
	 */
	public class BufferAnalystParam
	{
		//该值在进行点、线、面不同缓冲区分析时有所区别。 
		//1、线缓冲区分析时，该值必须大于0： 
        //当 BufferAnalystParam.bufferSideType = LEFT 时，表示左边缓冲区的距离。 
        //当 BufferAnalystParam.bufferSideType = FULL 时，即左右相等的双边缓冲（左右两边的缓冲距离都为 leftDistance）。 当 BufferAnalystParam.bufferSideType = RIGHT 时，该值无效。
        //2、面缓冲区分析时，该值代表缓冲区半径，该半径不能等于0，大于0时表示向外缓冲，小于0时表示向内缓冲。 
        //3、点缓冲区分析时，该值代表缓冲半径，必须大于0
		private var _leftDistance:Number;
		//线缓冲区分析时，表示右边缓冲区的距离，必须大于0
		private var _rightDistance:Number = 0;
		//保存结果面时，线段拟合半圆弧的线段数，即将半圆弧采用多少条线段来进行拟合
		private var _semicircleLineSegment:int = 12;
		//线缓冲区分析的端点类型，目前支持圆头缓冲
		private var _bufferEndType:int = BufferEndType.ROUND;
		//线缓冲区分析的缓冲边的类型，目前支持缓冲左边、缓冲右边、两边同时缓冲三种类型
		private var _bufferSideType:int = BufferSideType.FULL;
		
		/**
		 * ${iServer2_BufferAnalystParam_attribute_bufferSideType_D_as} 
		 */
		public function get bufferSideType():int
		{
			return _bufferSideType;
		}

		public function set bufferSideType(value:int):void
		{
			_bufferSideType = value;
		}

		/**
		 * ${iServer2_BufferAnalystParam_attribute_bufferEndType_D_as} 
		 */
		public function get bufferEndType():int
		{
			return _bufferEndType;
		}

		public function set bufferEndType(value:int):void
		{
			_bufferEndType = value;
		}

		/**
		 * ${iServer2_BufferAnalystParam_attribute_semicircleLineSegment_D_as} 
		 */
		public function get semicircleLineSegment():int
		{
			return _semicircleLineSegment;
		}
		
		public function set semicircleLineSegment(value:int):void
		{
			_semicircleLineSegment = value;
		}

		/**
		 * ${iServer2_BufferAnalystParam_attribute_rightDistance_D_as} 
		 */
		public function get rightDistance():Number
		{
			return _rightDistance;
		}

		public function set rightDistance(value:Number):void
		{
			_rightDistance = value;
		}

		/**
		 * ${iServer2_BufferAnalystParam_attribute_leftDistance_D_as} 
		 */
		public function get leftDistance():Number
		{
			return _leftDistance;
		}

		public function set leftDistance(value:Number):void
		{
			_leftDistance = value;
		}

		sm_internal function toBufferAnalystParam():String
		{
			var param:String = "";
			
			if (this.leftDistance != 0)
			{
				param += "\"leftDistance\":" + leftDistance.toString() + ",";
			}
			
			param += "\"rightDistance\":" + rightDistance.toString() + ",";
			
			
			param += "\"semicircleLineSegment\":" + semicircleLineSegment.toString() + ",";
			
			param += "\"bufferEndType\":" + bufferEndType.toString() + ",";
			
			param += "\"bufferSideType\":" + bufferSideType.toString();

			if(param.length > 0)
			param ="{" + param + "}";
			
            return param;
		}
		

	}
}