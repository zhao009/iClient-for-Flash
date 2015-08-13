package com.supermap.web.iServerJava6R.dataServices
{
	/**
	 * ${iServerJava6R_EditFeaturesParameters_Title}.
	 * <p>${iServerJava6R_EditFeaturesParameters_Description}</p> 
	 * 
	 */	
	public class EditFeaturesParameters
	{
		private var _features:Array;
		private var _editType:String;
		private var _IDs:Array;
		private var _isUseBatch:Boolean = false;
		private var _returnContent:Boolean = true;
		
		/**
		 * ${iServerJava6R_EditFeaturesParameters_constructor_D} 
		 * 
		 */		
		public function EditFeaturesParameters()
		{
			this._editType = EditType.ADD;
		}

		/**
		 * ${iServerJava6R_EditFeaturesParameters_attribute_returnContent_D}.
		 * */
		public function get returnContent():Boolean
		{
			return _returnContent;
		}

		public function set returnContent(value:Boolean):void
		{
			_returnContent = value;
		}

		/**
		 * ${iServerJava6R_EditFeaturesParameters_attribute_IDs_D}.
		 * <p>${iServerJava6R_EditFeaturesParameters_attribute_IDs_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get IDs():Array
		{
			return _IDs;
		}

		public function set IDs(value:Array):void
		{
			_IDs = value;
		}

		/**
		 * ${iServerJava6R_EditFeaturesParameters_attribute_editType_D} 
		 * @see EditType
		 * @return 
		 * 
		 */		
		public function get editType():String
		{
			return _editType;
		}

		public function set editType(value:String):void
		{
			_editType = value;
		}

		/**
		 * ${iServerJava6R_EditFeaturesParameters_attribute_features_D}.
		 * <p>${iServerJava6R_EditFeaturesParameters_attribute_features_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get features():Array
		{
			return _features;
		}

		public function set features(value:Array):void
		{
			_features = value;
		}
		
		/**
		 * ${iServerJava6R_EditFeaturesParameters_attribute_isUseBatch_D}.
		 * <p>${iServerJava6R_EditFeaturesParameters_attribute_isUseBatch_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get isUseBatch():Boolean
		{
			return _isUseBatch;
		}
		
		public function set isUseBatch(value:Boolean):void
		{
			_isUseBatch = value;
		}
	}
}