package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.iServerJava2.ServerGeometry;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/**
	 * ${iServer2_Query_Record_Title}. 
	 * <br/> ${iServer2_Query_Record_Description_as}
	 * <br/> ${iServer2_Query_Record_Remarks_as}
	 * 
	 * 
	 */	
	public class Record
	{
		
		private var _center:Point2D;
		private var _shape:ServerGeometry;
		private var _fieldValues:Array;
		
		/**
		 * ${iServer2_Query_Record_constructor_D} 
		 * 
		 */		
		public function Record()
		{
		}
		
		/**
		 * ${iServer2_Query_Record_attribute_center_D} 
		 * 
		 */		
		public function get center():Point2D
		{
			return this._center;
		}
		
		/**
		 * ${iServer2_Query_Record_attribute_fieldValues_D} 
		 * 
		 */				
		public function get fieldValues():Array
		{
			return this._fieldValues;
		}
		
		/**
		 * ${iServer2_Query_Record_attribute_shape_D_as} 
		 * @see ServerGeometry ServerGeometry Class 
		 * 
		 */		
		public function get shape():ServerGeometry
		{
			return this._shape;
		}
		
		/**
		 * @private 
		 * @param object
		 * @return 
		 * 
		 */		
		sm_internal static function toRecord(object:Object):Record
		{
			var record:Record;
			if(object)
			{
				record = new Record();
				if(object.center)
				{
					record._center = new Point2D(object.center.x, object.center.y);
				}
				record._fieldValues = object.fieldValues;
				record._shape = ServerGeometry.fromJson(object.shape);
			}
			return record;
		}
	}
	
}