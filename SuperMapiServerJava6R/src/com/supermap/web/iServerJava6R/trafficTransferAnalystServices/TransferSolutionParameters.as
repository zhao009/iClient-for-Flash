package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	import flash.net.URLVariables;
	

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransferSolutionParameters_Title}.
	 * 
	 */	
	public class TransferSolutionParameters
	{
		private var _transferTactic:String = TransferTactic.LESS_TIME;
		private var _transferPreference:String = TransferPreference.NONE;
		private var _walkingRatio:Number = 10;
		private var _points:Array;
		private var _solutionCount:int = 5;
		
		/**
		 * ${iServerJava6R_TransferSolutionParameters_constructor_D} 
		 * 
		 */	
		public function TransferSolutionParameters()
		{
		}

		/**
		 * ${iServerJava6R_TransferSolutionParameters_attribute_transferPreference_D} 
		 * @return 
		 * 
		 */	
		public function get transferPreference():String
		{
			return _transferPreference;
		}

		public function set transferPreference(value:String):void
		{
			_transferPreference = value;
		}

		/**
		 * ${iServerJava6R_TransferSolutionParameters_attribute_solutionCount_D} 
		 * @return 
		 * 
		 */
		public function get solutionCount():int
		{
			return _solutionCount;
		}

		public function set solutionCount(value:int):void
		{
			_solutionCount = value;
		}

//		/**
//		 * ${iServerJava6R_TrafficTransferParameters_attribute_maxTransferGuideCount_D}.
//		 * @default 50
//		 * @return 
//		 * 
//		 */	
//		public function get maxTransferGuideCount():int
//		{
//			return _maxTransferGuideCount;
//		}
//
//		public function set maxTransferGuideCount(value:int):void
//		{
//			_maxTransferGuideCount = value;
//		}
		/**
		 * ${iServerJava6R_TransferSolutionParameters_attribute_points_D}.
		 * @return 
		 * 
		 */	
		public function get points():Array
		{
			return _points;
		}

		public function set points(value:Array):void
		{
			_points = value;
		}
		/**
		 * ${iServerJava6R_TransferSolutionParameters_attribute_walkingRatio_D}.
		 * @default 10
		 * @return 
		 * 
		 */	
		public function get walkingRatio():Number
		{
			return _walkingRatio;
		}

		public function set walkingRatio(value:Number):void
		{
			_walkingRatio = value;
		}
		/**
		 * ${iServerJava6R_TransferSolutionParameters_attribute_transferTactic_D}.
		 * @return 
		 * 
		 */	
		public function get transferTactic():String
		{
			return _transferTactic;
		}

		public function set transferTactic(value:String):void
		{
			_transferTactic = value;
		}
		
		sm_internal function getVariablesString():String
		{
			var json:String = "";
			
			var nodeStr:String;
			if( this._points&& this._points.length)
			{
				if(this._points[0] is Point2D)
				{
					nodeStr = JsonUtil.fromPoint2Ds(this._points as Array);
				}
				else
				{
					nodeStr = "[" + this._points.join(",") + "]"; 
				}
			}
			
			json += "solutionCount=" + this._solutionCount + "&";
			json += "transferTactic=" + this._transferTactic + "&";
			json += "transferPreference=" + this._transferPreference + "&";
			json += "walkingRatio=" + this._walkingRatio + "&";			
			json += "points=" + nodeStr;
			
			return json;
		}
	}
}