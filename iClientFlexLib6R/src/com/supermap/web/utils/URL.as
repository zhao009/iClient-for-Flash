package com.supermap.web.utils
{
	import flash.net.URLVariables;
	
	import mx.utils.ObjectUtil;
	/**
	 * @private 
	 * 
	 */	
	public class URL
	{
		private var _sourceURL:String;
		private var _path:String;
		private var _query:URLVariables;
		
		public function URL(path:String = null)
		{
			this.update(path);
		}
		
		public function get path():String
		{
			return _path;
		}

		public function set path(value:String):void
		{
			_path = value;
		}

		public function get query():URLVariables
		{
			return _query;
		}

		public function set query(value:URLVariables):void
		{
			_query = value;
		}

		public function get sourceURL():String
		{
			return _sourceURL;
		}
		public function set sourceURL(value:String):void
		{
			_sourceURL = value;
		}

		public function update(value:String):void
		{
			var pos:int;
			this._sourceURL = value;
			this._path = null;
			this._query = null;
			
			if (value)
			{
				pos = value.indexOf("?");
				if (pos == -1)
				{
					this._path = value;
				}
				else
				{
					this._path = value.substring(0, pos);
					if (pos + 1 < value.length)
					{
						this._query = new URLVariables(value.substring(pos + 1));
					}
				}
			}
		}
		
		public function toString() : String
		{
			return ObjectUtil.toString(this);
		}
		
	}
}