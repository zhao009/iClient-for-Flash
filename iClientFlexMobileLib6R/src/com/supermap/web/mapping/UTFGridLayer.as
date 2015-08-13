package com.supermap.web.mapping
{
	import com.supermap.web.core.Credential;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.serialization.json.JSON;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.ScaleUtil;
	
	import flash.events.*;
	import flash.geom.Point;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	use namespace sm_internal;

	// @author lwl
	// 实现思路：
	// 1.继承TiledDynamicRESTLayer是为了便于得到当前可视范围内的瓦片对应的x,y,scale，据此可以得到对应UTFGrid服务端地址并下载;
	// 2.得到下载后的UTFGrid数据并扩展URLLoader得到UTFLoader，为每个UTFGrid数据赋予索引值，方便后续查找；
	// 3.根据用户设置添加鼠标单击和移动事件，并根据鼠标位置获取对应UTFGrid数据。
	// 4.获取UTFGrid数据思路来源JS。
	// 5.实现该功能涉及到两个as文件，UTFGridLayer.as与UTFLoader.as

	/**
	 * ${mapping_UTFGridLayer_Title}.
	 * <p>${mapping_UTFGridLayer_Description}</p>
	 *
	 */
	public class UTFGridLayer extends TiledDynamicRESTLayer
	{
		private var _UTFGridMouseClickHandler:Function;
		private var _UTFGridMouseMoveHandler:Function;

		private var _layerName:String;
		private var _pixcell:int = 2;

		private var _utfgridResolution:int = 2;
		private var utftiles:Dictionary;
		private var utftilesMaxNum:int = 500;
		
		private var _utftilesNum:int = 0;
		//用于在存放title的key是进行对res的精度进行修改
		private var _cutLen:Number = 5;

		/**
		 * ${mapping_UTFGridLayer_constructor_D}
		 *
		 */
		public function UTFGridLayer()
		{ 
			super();
			this.utftiles = new Dictionary(true);
			if (this.pixcell)
			{
				this._utfgridResolution = this.pixcell;
			}
			this.addMapListeners();
		}

		/**
		 * ${mapping_UTFGridLayer_attribute_UTFGridMouseClickHandler_D}.
		 * <p>${mapping_UTFGridLayer_attribute_UTFGridMouseClickHandler_remarks}</p>
		 * @return
		 *
		 */
		public function get UTFGridMouseClickHandler():Function
		{
			return _UTFGridMouseClickHandler;
		}

		public function set UTFGridMouseClickHandler(value:Function):void
		{
			_UTFGridMouseClickHandler = value;
		}

		/**
		 * ${mapping_UTFGridLayer_attribute_UTFGridMouseMoveHandler_D}.
		 * <p>${mapping_UTFGridLayer_attribute_UTFGridMouseMoveHandler_remarks}</p>
		 * @return
		 *
		 */
		public function get UTFGridMouseMoveHandler():Function
		{
			return _UTFGridMouseMoveHandler;
		}

		public function set UTFGridMouseMoveHandler(value:Function):void
		{
			_UTFGridMouseMoveHandler = value;
		}

		/**
		 * ${mapping_UTFGridLayer_attribute_layerName_D}
		 * @return
		 *
		 */
		public function get layerName():String
		{
			return _layerName;
		}

		public function set layerName(value:String):void
		{
			_layerName = value;
		}

		/**
		 * ${mapping_UTFGridLayer_attribute_pixcell_D}
		 * @return
		 *
		 */
		public function get pixcell():int
		{
			return _pixcell;
		}

		public function set pixcell(value:int):void
		{
			_pixcell = value;
			this._utfgridResolution = _pixcell;
		}

		override protected function addMapListeners():void
		{
			super.addMapListeners();
			//根据用户的设置，为地图添加对应的鼠标移动和鼠标点击监听事件，Flex暂时不提供鼠标悬停事件，看需求可以后续完善
			if (this.map)
			{
				if (UTFGridMouseClickHandler != null)
				{
					this.map.addEventListener(MouseEvent.CLICK, clickHandler);
				}
				if (UTFGridMouseMoveHandler != null)
				{
					this.map.addEventListener(MouseEvent.MOUSE_MOVE, moveHandler);
				}
				this.map.addEventListener(PanEvent.PAN_START, panStartHandler);
				this.map.addEventListener(PanEvent.PAN_END, panEndHandler);
			}
		}

		protected function panEndHandler(event:PanEvent):void
		{
		}

		protected function panStartHandler(event:PanEvent):void
		{
			super.zoomStartHandler(new ZoomEvent(ZoomEvent.ZOOM_END));

			//无论是平移还是缩放 都将utftiles清空，减少内存的消耗
			//虽然减少了内存消耗但是影响用户体验效果，因此去掉
			//this.clearDic(this.utftiles);
		}

		override protected function zoomEndHandler(event:ZoomEvent):void
		{
			super.zoomEndHandler(event);
		}

		override protected function zoomStartHandler(event:ZoomEvent):void
		{
			super.zoomStartHandler(event);

			//无论是平移还是缩放 都将utftiles清空，减少内存的消耗
			//虽然减少了内存消耗但是影响用户体验效果，因此去掉
			//this.clearDic(this.utftiles);
		}

		//循环删除Dictionary中的元素
		private function clearDic(dic:Dictionary):void
		{
			for (var id:String in dic)
			{
				delete dic[id];
			}
		}

		protected function clickHandler(event:MouseEvent):void
		{
			if(!this.visible)
			{
				//如果用户设置Visible为false，则删除utftiles里边的数据
				this.clearDic(this.utftiles);
			}
			//这个地方使用stageX和stageY来相对于Flash画布的位置，如果使用localX和localY则是相对于map的位置，不是希望的效果
			var data:Object = getDataFromMousePostion(event.stageX, event.stageY);
			if (data)
			{
				this.UTFGridMouseClickHandler(data, event.stageX, event.stageY);
			}
			else
			{
				this.UTFGridMouseClickHandler(null, event.stageX, event.stageY);
			}
		}

		protected function moveHandler(event:MouseEvent):void
		{
			if(!this.visible)
			{
				//如果用户设置Visible为false，则删除utftiles里边的数据
				this.clearDic(this.utftiles);
			}
			//这个地方使用stageX和stageY来相对于Flash画布的位置，如果使用localX和localY则是相对于map的位置，不是希望的效果
			var data:Object = getDataFromMousePostion(event.stageX, event.stageY);
			if (data)
			{
				this.UTFGridMouseMoveHandler(data, event.stageX, event.stageY);
			}
			else
			{
				this.UTFGridMouseMoveHandler(null, event.stageX, event.stageY);
			}
		}

		override protected function getTileURL(row:int, col:int, resolution:Number):URLRequest
		{
			//控制Dictionary长度，不允许大于utftilesMaxNum，否则清空
			if (this._utftilesNum > this.utftilesMaxNum)
			{
				this.clearDic(this.utftiles);
				this._utftilesNum = 0;
			}
			if (resolution <= 0 || this.dpi == 0)
			{
				return null;
			}
			var scale:Number;
			if (this.CRS)
			{
				scale = ScaleUtil.resolutionToScale(resolution, this.dpi, this.CRS.unit, this.CRS.datumAxis);
			}
			else
			{
				scale = ScaleUtil.resolutionToScale(resolution, this.dpi);
			}

			var serverURL:String;

			//请求url实例:
			//http://localhost:8090/iserver/services/map-World/rest1/maps/World/utfGrid.json?scale=0.0000001&x=3&y=3&width=256&height=256&pixCell=2&layerName=Countries@World
			serverURL = encodeURI(this.url) + "utfGrid.json?scale=" + scale + "&x=" + col + "&y=" + row + "&width=" + this.tileSize + "&height=" + this.tileSize + "&pixCell=" + this.pixcell + "&layerNames=" + encodeURIComponent("[\""+this.layerName+"\"]");
			//管理Credential
			if(Credential.CREDENTIAL)
			{
				if(serverURL.split("?").length>1)
					serverURL += "&" + Credential.CREDENTIAL.getUrlParameters();
				else
					serverURL += "?" + Credential.CREDENTIAL.getUrlParameters();
			}
			var utfloader:UTFLoader = new UTFLoader();
			
//			var oldS:String = resolution.toString();
//			var newS:String = oldS.substring(0,oldS.length - parseInt(oldS.length/this._cutLen));
			var newS:String = clipResolution(resolution).toString();

			utfloader.id = newS + "_" + col + "_" + row;
			//判断瓦片存储字典里便是否已经有了对应的数据，如果已经有了，就没有必要向服务器发送请求，而是直接使用就可以了，从而提高交互速度
			if (this.utftiles[utfloader.id])
			{
				return new URLRequest("");
			}
			utfloader.addEventListener(Event.COMPLETE, completehandler);
			utfloader.load(new URLRequest(serverURL));

			//这里没有必要在基类中进行URL请求，所以传一个空url
			return new URLRequest("");
		}
		
		private function clipResolution(old:Number):Number
		{
			var result:Number = old - old%1;
			if(result==0)
			{	
				result = this.clipResolution(old*10);
			}
			return result;
		}

		protected function completehandler(event:Event):void
		{
			try
			{
				var utf:UTFLoader = UTFLoader(event.target);
				var json:Object = com.supermap.web.serialization.json.JSON.decode(utf.data, false);
				this.utftiles[utf.id] = json;
				this._utftilesNum++;
			}
			catch (error:Error)
			{
				trace(error.toString());
			}
		}

		//通过鼠标位置获取对应位置的数据
		private function getDataFromMousePostion(mouseX:Number, mouseY:Number):Object
		{
			//转换为地理坐标系下宽度和高度
			var tSize:Number = this.tileSize * this.resolution;

			//得到整个地图范围，需要使用其边界位置
			var bounds:Rectangle2D = this.bounds;

			//将屏幕坐标转换成地理坐标
			var point:Point = new Point(mouseX, mouseY);
			var point2d:Point2D = this.map.stageToMap(point);

			//算出与边界的距离，并除以每个瓦片地理大小，得出一个整数（即包含瓦片个数），和一个小数（用来计算相对于一个瓦片的x,y像素位置）
			var dtx:Number = (point2d.x - bounds.left) / tSize;
			var dty:Number = (bounds.top - point2d.y) / tSize;

			//求出tile的位置（行，列）
			var col:Number = Math.floor(dtx);
			var row:Number = Math.floor(dty);

			//通过分辨率，行，列；来计算索引表
			//此处对resolution字符串进行裁剪目的为了避免精度造成的误差
//			var oldS:String = resolution.toString();
//			var newS:String = oldS.substring(0,oldS.length - parseInt(oldS.length/this._cutLen));
			var newS:String = clipResolution(resolution).toString();
			var index:String = newS + "_" + col + "_" + row;

			//得到索引对应的UTFGrid瓦片数据
			
			var tileData:Object = utftiles[index];
			
			//算出鼠标位置在当前瓦片中的相对位置
			var i:Number = Math.floor((dtx - col) * this.tileSize);
			var j:Number = Math.floor((dty - row) * this.tileSize);

			//获取鼠标位置对应的数据
			var data:Object = this.getFeature(i, j, tileData);
			return data;
		}

		//通过鼠标相对瓦片位置的x(i),y(j),以及UTFGrid瓦片对应的数据算出当前鼠标位置对应的属性值；可以参考JS对应方式实现；
		private function getFeature(i:Number, j:Number, tileData:Object):Object
		{
			if (tileData && tileData.data)
			{
				var id:Number;
				var utfgridResolution:int = this._utfgridResolution;
				var row:int = Math.floor(j / utfgridResolution);
				var col:int = Math.floor(i / utfgridResolution);
				//charCodeAt() 方法可返回指定位置的字符的 Unicode 编码。这个返回值是 0 - 65535 之间的整数。
				var charCode:int = tileData.grid[row].charCodeAt(col);
				var index:int = this.indexFromCharCode(charCode);
				var keys:Array = tileData.keys;
				if (!isNaN(index) && (index in keys))
				{
					id = keys[index];
				}
				return tileData.data[id];
			}
			else
			{
				return null;
			}
		}

		//给定一个UTFGrid中grid属性中的字符码对应的十进制表示，将其解析成UTFGrid中keys数组上的索引。
		private function indexFromCharCode(charCode:int):int
		{
			if (charCode >= 93)
			{
				charCode--;
			}
			if (charCode >= 35)
			{
				charCode--;
			}
			return charCode - 32;
		}
	}
}
