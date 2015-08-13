package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.net.URLVariables;

	use namespace sm_internal;

	/**
	 * ${iServerJava6R_TransferPathParameters_Title}. 
	 * 
	 */		
	public class TransferPathParameters
	{
		private var _transferLines:Array;
		private var _points:Array;

		/**
		 * ${iServerJava6R_TransferPathParameters_constructor_D} 
		 * 
		 */			
		public function TransferPathParameters()
		{
		}

		/**
		 * ${iServerJava6R_TransferPathParameters_attribute_points_D} 
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
		 * ${iServerJava6R_TransferPathParameters_attribute_transferLines_D} 
		 * @return 
		 * 
		 */			
		public function get transferLines():Array
		{
			return _transferLines;
		}

		public function set transferLines(value:Array):void
		{
			_transferLines = value;
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
			
			var transferLinesStr:String;
			if (this._transferLines && this._transferLines.length)
			{
				var transferLinesArray:Array = [];
				var transferLinesLength:int = this._transferLines.length;
				for(var i:int = 0; i < transferLinesLength; i++)
				{
					transferLinesArray.push((this._transferLines[i] as TransferLine).toJson());
				}
				
				transferLinesStr = "[" + transferLinesArray.join(",") + "]";
			}
			json += "transferLines=" + transferLinesStr + "&";
			json += "points=" + nodeStr;
			
			return json;
		}

	}
}