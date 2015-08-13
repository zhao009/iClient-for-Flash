package com.supermap.web.iServerJava2.editServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_editServices_EditResult_Title}.
	 * <p>${iServer2_editServices_EditResult_Description}</p>
	 * 
	 * 
	 */
	public class EditResult
	{
		private var _succeed:Boolean;
		
		private var _ids:Array;
		
		private var _editBounds:Rectangle2D;
		
		private var _message:String;
		
		/**
		 * ${iServer2_editServices_EditResult_attribute_succeed_D} 
		 * 
		 */
		public function get succeed():Boolean
		{
			return this._succeed;
		}
		
		/**
		 * ${iServer2_editServices_EditResult_attribute_IDs_D} 
		 * 
		 */
		public function get ids():Array
		{
			return this._ids;
		}
		
		/**
		 * ${iServer2_editServices_EditResult_attribute_editBounds_D}.
		 * <p>${iServer2_editServices_EditResult_attribute_editBounds_remarks}</p>
		 * 
		 */
		public function get editBounds():Rectangle2D
		{
			return this._editBounds;
		}
		
		
		/**
		 * ${iServer2_editServices_EditResult_attribute_message_remarks}
		 * 
		 */
		public function get message():String
		{
			return this._message;
		}
		
		sm_internal static function toEditResult(object:Object):EditResult
		{
			var editResult:EditResult;
			if(object)
			{
				editResult = new EditResult();
				editResult._message = object.message;
				editResult._succeed = object.succeed;
				editResult._ids = object.ids;
				if(object.editBounds)
					editResult._editBounds =  new Rectangle2D(object.editBounds.leftBottom.x, object.editBounds.leftBottom.y, object.editBounds.rightTop.x, object.editBounds.rightTop.y);			
			}
			return editResult;
		}

	}
}