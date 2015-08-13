package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.iServerJava2.ServerGeometry;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/**
	 * ${iServer2_Query_ResultSet_Title}. 
	 * <br/> ${iServer2_Query_ResultSet_Description}
	 * 
	 * 
	 */	
	public class ResultSet
	{
		
		private var _currentCount:int;
		private var _totalCount:int;
		private var _recordSets:Array;
		private var _customResponse:String;
		private var _bufferGeometry:ServerGeometry;
		
		/**
		 * ${iServer2_Query_ResultSet_constructor_D} 
		 * 
		 */		
		public function ResultSet()
		{
//			_bufferGeometry = new ServerGeometry();
		}
		
		/**
		 * ${iServer2_Query_ResultSet_attribute_bufferGeometry_D} 
		 * @see BufferQueryService
		 * @see EntityBufferQueryService
		 * @return 
		 * 
		 */		
		public function get bufferGeometry():ServerGeometry
		{
			return _bufferGeometry;
		}

		/**
		 * ${iServer2_Query_ResultSet_attribute_currentCount_D} 
		 * 
		 */		
		public function get currentCount():int
		{
			return this._currentCount;
		}
		
		/**
		 * ${iServer2_Query_ResultSet_attribute_totalCount_D} 
		 * 
		 */		
		public function get totalCount():int
		{
			return this._totalCount;
		}
		
		/**
		 * ${iServer2_Query_ResultSet_attribute_recordSets_D_as} 
		 * 
		 */		
		public function get recordSets():Array
		{
			return this._recordSets;
		}
		
		/**
		 * ${iServer2_Query_ResultSet_attribute_customResponse_D}  
		 * 
		 */		
		public function get customResponse():String
		{
			return this._customResponse;
		}
		
		/**
		 * @private 
		 * @param object
		 * @return 
		 * 
		 */		
		sm_internal static function toResultSet(object:Object):ResultSet
		{
			var resultSet:ResultSet;
			if(object)
			{
				resultSet = new ResultSet();
				var tempRecordSets:Array;
				
				if(object.bufferGeometry)
				{
					resultSet._bufferGeometry = new ServerGeometry();
					resultSet._bufferGeometry.feature = object.bufferGeometry.feature;
					resultSet._bufferGeometry.id = object.bufferGeometry.id;
					resultSet._bufferGeometry.parts = object.bufferGeometry.parts;
					resultSet._bufferGeometry.point2Ds = object.bufferGeometry.point2Ds;
					
					if(object.resultSet)
					{
						resultSet._currentCount = object.resultSet.currentCount;
						resultSet._customResponse = object.resultSet.customResponse;
						resultSet._totalCount = object.resultSet.totalCount;
						tempRecordSets = object.resultSet.recordSets;
					}
				}
				else
				{
					resultSet._currentCount = object.currentCount;
					resultSet._customResponse = object.customResponse;
					resultSet._totalCount = object.totalCount;
					
					tempRecordSets = object.recordSets;
				}
				
				if(tempRecordSets)
				{
					if(tempRecordSets.length > 0)
					{
						resultSet._recordSets = new Array();
						for(var i:int = 0; i < tempRecordSets.length; i++)
							resultSet._recordSets.push(RecordSet.toRecordSet(tempRecordSets[i]));
					}
				}
				
			}
			return resultSet;
		}

	}
}