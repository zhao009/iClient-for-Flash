package com.supermap.web.mapping
{
	import com.supermap.web.sm_internal;
	
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	use namespace sm_internal;
	import flash.utils.ByteArray;

	/**
	 * ${mapping_LocalStorage_Title}.
	 * <p>${mapping_LocalStorage_Description}</p> 
	 * @see TiledLayer#localStorage
	 * 
	 */	
	public class LocalStorage
	{
		private var _sharedObject:SharedObject;
		private var _sharedObjectName:String;
		private var _serializedTiles:Object = null;
		
		/**
		 * ${mapping_LocalStorage_constructor_D} 
		 * @param sharedObjectName ${mapping_LocalStorage_constructor_param_sharedObjectName_D}
		 * 
		 */		
		public function LocalStorage(sharedObjectName:String = "tileStorage")
		{
			this._sharedObjectName = sharedObjectName;
		}
		
		/**
		 * ${mapping_LocalStorage_attribute_sharedObjectName_D} 
		 * @return 
		 * 
		 */		
		public function get sharedObjectName():String
		{
			return _sharedObjectName;
		}

		public function set sharedObjectName(value:String):void
		{
			_sharedObjectName = value;
		}
		
		/**
		 * ${mapping_LocalStorage_method_clear_D} 
		 * 
		 */		
		public function clear():void
		{
			if(!this._sharedObject)
				_sharedObject =  SharedObject.getLocal(this._sharedObjectName);
			this._sharedObject.clear();
		}
		
		sm_internal function connectSharedObject():void
		{
			_sharedObject =  SharedObject.getLocal(this._sharedObjectName);
			if(this._sharedObject.data && this._sharedObject.data.serializedTiles)
			{
				this._serializedTiles = this._sharedObject.data.serializedTiles;
			}
			else
			{
				this._serializedTiles = new Object();
			}			
		}
		
		sm_internal function disconnectSharedObject():void
		{
			_sharedObject = null;
			this._serializedTiles = null;
		}
		
		sm_internal function putTiles(iamgeID:String, imageBytes:ByteArray):void
		{
			this._serializedTiles[iamgeID] = imageBytes;
		}
		
		sm_internal function getTiles(imageID:String):Object
		{
			var obj:Object = this._serializedTiles[imageID];
			return obj;
		}
		
		sm_internal function serializeTiles():void
		{
			this._sharedObject.data.serializedTiles = this._serializedTiles;	
			this._sharedObject.flush();
		}

	}
}