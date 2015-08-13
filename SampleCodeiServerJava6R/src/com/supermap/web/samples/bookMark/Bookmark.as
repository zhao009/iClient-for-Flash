package com.supermap.web.samples.bookMark
{
	import flash.net.SharedObject;
	
	import spark.components.mediaClasses.VolumeBar;

	public class Bookmark
	{
		import com.supermap.web.core.Point2D;
		import com.supermap.web.mapping.Map;
		
		import mx.collections.ArrayCollection;
		import mx.events.ListEvent;
		
		public var _marks:ArrayCollection = null;
		
		private var _map:Map = null;
		
		private var _shardObject:SharedObject = SharedObject.getLocal("markStorage");
		
		private var _serializedMarks:Array = null;
		
		private var _isShowSerializedMarks:Boolean = true;
		
		public function Bookmark()
		{
			if(this._isShowSerializedMarks && serializedMarks)
				_marks  = new ArrayCollection(_serializedMarks);
			else
				_marks = new ArrayCollection();
		}

		public function get isShowSerializedMarks():Boolean
		{
			return _isShowSerializedMarks;
		}

		public function set isShowSerializedMarks(value:Boolean):void
		{
			_isShowSerializedMarks = value;
		}

		public function get serializedMarks():Array
		{
			if(_shardObject.data.serializedMarks)
				_serializedMarks = _shardObject.data.serializedMarks;
			if(_serializedMarks)
			{
				for(var i:int = 0; i < _serializedMarks.length; i++)
				{
					var mark:Object = _serializedMarks[i];
					mark.center = new Point2D(mark.center.x, mark.center.y);
				}
			}
			return _serializedMarks;
		}
		
		public function clearSerializedMarks():void
		{
			this._shardObject.clear();
		}

		public function set shardObject(value:SharedObject):void
		{
			_shardObject = value;
		}
		
		private function serializeMarks():void
		{
			this._shardObject.data.serializedMarks = this._marks.toArray();
			this._shardObject.flush();
		}

		public function addMark(name:String):void
		{
			if(addMarkCommonMethod(name))
				this._marks.addItem(addMarkCommonMethod(name));
			this.serializeMarks();
		}
		
		public function addMarkAt(name:String, index:int):void
		{
			if(addMarkCommonMethod(name))
				this._marks.addItemAt(addMarkCommonMethod(name), index);
			this.serializeMarks();
		}
		
		private function addMarkCommonMethod(name:String):Object
		{			
			if(name == null || name == "")
			{
				var date:Date = new Date();
				name = date.getFullYear().toString() + "-" + (date.getMonth() + 1) 
					+ "-" + date.getDate() 
					+ " " + date.getHours()
					+ ":" + date.getMinutes()
					+ ":" + date.getSeconds();
			}
			
			var currentResolution:Number = this._map.resolution;
			var currentCenter:Point2D = this._map.viewBounds.center;
			var data:Object = 
				{
					name: name,
					resolution: currentResolution,
					center: currentCenter
				}
			
			if(this._marks.length > 0)
			{
				for(var i:int; i < this._marks.length; i++)
				{
					if(name == this._marks[i].name)
					{
						this._marks[i].resolution = currentResolution;
						this._marks[i].center = currentCenter;
						return null;
					}
				}
			}
			
			return data;
		}
		
		public function removeMark(name:String):void
		{
			if(this._marks.length > 0)
			{
				for(var i:int; i < this._marks.length; i++)
				{
					if(name == this._marks[i].name)
					{
						this._marks.removeItemAt(i);
						this.serializeMarks();
					}
				}
			}
		}
		
		public function removeAll():void
		{
			if(this._marks.length > 0)
				this._marks.removeAll();
			this.serializeMarks();
		}
		  
		public function removeMarkAt(index:int):void
		{
			if(this._marks.length > index)
			{
				if(this._marks[index])
					this._marks.removeItemAt(index);
			}
			this.serializeMarks();
		}
		
		public function renameMark(lastName:String, newName:String):void
		{
			if(this._marks.length > 0)
			{
				for(var i:int; i < this._marks.length; i++)
				{
					if(lastName == this._marks[i].name)
					{
						this._marks[i].name = newName;
						this.serializeMarks();
					}
				}
			}
		}
		
		public function renameMarkAt(newName:String, index:int):void
		{
			if(this._marks[index])
			{
				var newMark:Object = new Object();
				newMark.name = newName;
				newMark.resolution = this._marks[index].resolution;
				newMark.center = this._marks[index].center;
				this._marks.setItemAt(newMark, index);
				this.serializeMarks();
			}
		}
		
		// 书签对象列表，书签对象有三个属性，分辨是：书签名称、地图分辨率、地图当前显示范围的中心点
		public function get marks():ArrayCollection
		{
			return this._marks;
		}
		
		public function get map():Map
		{
			return this._map;
		}
		
		public function set map(value:Map):void
		{
			this._map = value;
		}
		
	}
}