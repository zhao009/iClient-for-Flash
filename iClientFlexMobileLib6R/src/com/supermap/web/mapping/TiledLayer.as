package com.supermap.web.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.mapping.supportClasses.CandidateTileInfo;
	import com.supermap.web.mapping.supportClasses.Coords;
	import com.supermap.web.mapping.supportClasses.Tile;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.*;
	
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.LoaderContext;
	import flash.utils.*;
	
	import mx.events.*;
	import mx.logging.*;
	
	use namespace sm_internal;
	
	[Event(name="fadeInFrameCountChange", type="flash.events.Event")]
	
	/**
	 * ${mapping_TiledLayer_Title}.
	 * <p>${mapping_TiledLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class TiledLayer extends ImageLayer
	{
		/**
		 * @private 
		 */		
		protected var _resolutions:Array;
		
		private var _log:ILogger;
		private var _tileIds:Array;
		private var _tiles:Dictionary;
		private var _tileBounds:Dictionary;
		private var _ct:CandidateTileInfo = null;
		private var _removeStack:Array;
		private var _loadingStack:Array;	
		private var _origin:Point2D;
		private var _tileSize:int = 512;
		private var _levelChange:Boolean;
		private var _useDefaultZoomHandlers:Boolean = true;
		private var _coords_dx:Number;
		private var _coords_dy:Number;
		private var _hiddenViewBounds:Rectangle2D;
		private var _fireAllComplete:Boolean;
		private var _fadeInFrameCount:uint = 4;
		private var _forceToRefreshFlag:Boolean;
		
		private const FADEIN_FRAME_COUNT_CHANGE:String = "fadeInFrameCountChange";
		
		private var _shardObject:SharedObject;
		private var _serializedTiles:Dictionary = null;
		
		private var _offlineStorage:OfflineStorage;
		
		protected var _offlineFilestored:Boolean = false;
		
		protected var _urls:Array = [];
		
		
		//构造函数
		/**
		 * ${mapping_TiledLayer_constructor_None_D} 
		 * 
		 */		
		public function TiledLayer()
		{
			this._tileIds = [];
			this._tiles = new Dictionary(true);
			this._tileBounds = new Dictionary(true);
			this._removeStack = [];
			this._loadingStack = [];
			mouseChildren = false;
			mouseEnabled = false;
		}	
		
		public function get offlineStorage():OfflineStorage
		{
			return _offlineStorage;
		}

		public function set offlineStorage(value:OfflineStorage):void
		{
			_offlineStorage = value;
		}

		/**
		 * ${mapping_TiledLayer_attribute_origin_D}.
		 * ${mapping_TiledLayer_attribute_origin_remarks_D}
		 * @return 
		 * 
		 */		
		public function get origin() : Point2D
		{
			return this._origin;
		}
		
		public function set origin(value:Point2D) : void
		{
			var old_origin:Point2D = this._origin;
			if (old_origin !== value)
			{
				this._origin = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "origin", old_origin, value));
				}
			}
		}
		
		/**
		 * ${mapping_TiledLayer_attribute_tileSize_D}.
		 * ${mapping_TiledLayer_attribute_tileSize_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get tileSize():int
		{
			return _tileSize;
		}
		
		public function set tileSize(value:int):void
		{
			var old_tileSize:int = this.tileSize;
			if (old_tileSize !== value)
			{
				this._tileSize = value;
				if(this.loaded && this._tileSize != 512)
					invalidateLayer();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "tileSize", old_tileSize, value));
				}
			}
		}
		
		
		/**
		 * 设置渐显的帧数，可以使缩放地图时更加平滑
		 * 如果该值小于或等于0则没有渐显效果
		 * 默认值设为4
		 */
		
		/**
		 * ${mapping_TiledLayer_attribute_fadeInFrameCount_D}.
		 * ${mapping_TiledLayer_attribute_fadeInFrameCount_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get fadeInFrameCount() : uint
		{
			return this._fadeInFrameCount;
		}
		
		public function set fadeInFrameCount(value:uint) : void
		{
			if (value != this._fadeInFrameCount)
			{
				this._fadeInFrameCount = value;
				dispatchEvent(new Event(FADEIN_FRAME_COUNT_CHANGE));
			}
		}	
		//end 属性
		
		
		public function selectUrls(row:int, col:int) : String
		{		
			return this._urls[(row+col)%this._urls.length];
		}
		
		//保护成员
		/**
		 *根据当前的细节层次以及瓦片的行列号向服务端请求数据
		 * 因为每个服务端的请求URL不统一，因此该接口由子类负责实现。 
		 */ 	
		sm_internal function getTileURL2(row:int, col:int, level:int, resolution:Number) : URLRequest
		{
			return null;
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function draw() : void
		{
			this.loadTiles(this._levelChange);
			this._levelChange = false;
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function refresh() : void
		{
			super.refresh();
			this.removeAllChildren();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function removeAllChildren() : void
		{
			super.removeAllChildren();
			graphics.clear();
			this._tileIds = [];
			this._tiles = new Dictionary(true);
			this._tileBounds = new Dictionary(true);
			this._ct = null;
			this._loadingStack = [];
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function addMapListeners() : void
		{
			super.addMapListeners();
			this.addMapPanListeners();
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function removeMapListeners() : void
		{
			super.removeMapListeners();
			this.removeMapPanListeners();
		}
		
		private function addMapPanListeners() : void
		{
			if (map)
			{
				map.addEventListener(PanEvent.PAN_UPDATE, this.onPanHandler, false, 0, true);
			}
			
		}
		
		private function removeMapPanListeners() : void
		{
			if (map)
			{
				map.removeEventListener(PanEvent.PAN_UPDATE, this.onPanHandler);
			}
		}
		
		private function onPanHandler(event:PanEvent) : void
		{
			if (this.loaded && !this._ct)
			{
				return;
			}
			var rect:Rectangle = parent.scrollRect;
			this._coords_dx = -rect.x;
			this._coords_dy = -rect.y;
			this.updateImages(new Rectangle(0, 0, rect.width, rect.height));
		}
		
		//加载瓦片
		private function loadTiles(levelChange:Boolean = false, resolution:Number = NaN) : void
		{			
			var bVisible:Boolean = false;
			var resolutionOutOfRange:Boolean = false;
			var res:Number = NaN;
			var level:int = -1;
			if (this.visible && this.loaded && this.map && map.width>0 && map.height>0)
			{
				var screenWidth:Number = map.width;
				var screenHeight:Number = map.height;
				var geoWidth:Number = map.viewBounds.width;
				var geoHeight:Number = map.viewBounds.height;
				bVisible = true;
				if (!isNaN(resolution))
				{
					res = resolution;
				}
				else
				{
					res = this.resolution;
				}
				if(this._resolutions != null)
				{
					var closet:Object = TileUtil.getClosestResolutionAndLevel(screenWidth, screenHeight, geoWidth, geoHeight, this.map.resolutions);
					var curMapResolution:Number = closet.resolution;
					
					var curLevel:int = this._resolutions.indexOf(curMapResolution);
					resolutionOutOfRange = (curLevel == -1);
					if(!resolutionOutOfRange)
					{
						res = curMapResolution;
						level = curLevel;
					}
				}
				else
				{
					resolutionOutOfRange = false;
					if(this.map.resolutions && this.map.resolutions.length)
					{
						res = this.map.resolutions[map.level];
					}
				}
				
				if (resolutionOutOfRange)
				{
					bVisible = false;
					this.removeAllChildren();
					this.removeMapPanListeners();
					return;
				}
				else
				{
					this.removeMapPanListeners();
					this.addMapPanListeners();
				}
				
				var candidateTi:CandidateTileInfo = TileUtil.getCandidateTileInfo(map.scrollRectX, map.scrollRectY, this._tileSize, this._origin, map.viewBounds, res, level);
				if(candidateTi == null)
				{
					return;
				}
				if(this._ct == null)
				{
					this._ct = candidateTi;
				}
				if ((this._ct && candidateTi.resolution != this._ct.resolution) || (this._levelChange) || this._forceToRefreshFlag)
				{
					this._forceToRefreshFlag = false;
					this._ct = candidateTi;
					this.cleanUpRemovedImages();									
					var i:Number = 0;
					var tileIdLength:Number = this._tileIds.length;
					var tileId:String = null;
					while (i < tileIdLength)
					{				
						tileId = this._tileIds[i];
						var img:ImageLoader = this._tiles[tileId];
						this._tileIds[i] = null;
						this._tileBounds[tileId] = null;
						this._removeStack.push(img);
						i++;
					}
					if (levelChange)
					{
						this._tileIds = [];
						this._tiles = new Dictionary(true);
						this._tileBounds = new Dictionary(true);
					}
				}
				
				var rect:Rectangle = parent.scrollRect;
				var offsetX:Number = -rect.x;
				var offsetY:Number = -rect.y;
				if (bVisible && !resolutionOutOfRange)
				{
					this._coords_dx = offsetX;
					this._coords_dy = offsetY;
					this.updateImages(new Rectangle(0, 0, rect.width, rect.height));
					if (this._loadingStack.length === 0)
					{
						dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, null, true));
					}
					else
					{
						this._fireAllComplete = true;
					}
				}
				else
				{
					this.cleanUpRemovedImages();
				}
				var tileIdIndex:int = this._tileIds.length - 1;
				while (tileIdIndex >= 0)
				{				
					tileId = this._tileIds[tileIdIndex];
					if (tileId)
					{
						var imgLoader:ImageLoader = this._tiles[tileId];
						var imgRect:Rectangle= new Rectangle(imgLoader.x, imgLoader.y, this._tileSize, this._tileSize);
						if (rect.intersects(imgRect))
						{
							this._tileBounds[tileId] = imgRect;
						}
						else
						{
							if (this._loadingStack.indexOf(tileId) != -1)
							{
								this.tilePopPop(imgLoader);
							}
							if (imgLoader && contains(imgLoader))
							{
								removeChild(imgLoader);
								imgLoader.cancel = true;
							}
							this._tileIds.splice(tileIdIndex, 1);
							delete this._tileBounds[tileId];
							delete this._tiles[tileId];
						}
					}
					else
					{
						this._tileIds.splice(tileIdIndex, 1);
						delete this._tileBounds[tileId];
						delete this._tiles[tileId];
					}
					tileIdIndex--;
				}
			}
		}
		sm_internal var isStartRowAndCol:Boolean = true;
		private function updateImages(rect:Rectangle) : void
		{
			var tileId:String = null;
			var toAddRow:Number = NaN;
			var toAddCol:Number = NaN;
			
			var resolution:Number = this._ct.resolution;
			var leftTop:Point2D = new Point2D(this.bounds.left, this.bounds.top);
			var rightBottom:Point2D = new Point2D(this.bounds.right, this.bounds.bottom);
			var tempCoords:Coords = TileUtil.getContainingTileCoords(this._tileSize, this._origin, leftTop, resolution, isStartRowAndCol);
			//bounds范围所包含的地图瓦片的总行列个数
			var startRow:int = tempCoords.row < 0 ? (0) : (tempCoords.row);
			var startCol:int = tempCoords.col < 0 ? (0) : (tempCoords.col);
			isStartRowAndCol = false;
			tempCoords = TileUtil.getContainingTileCoords(this._tileSize, this._origin, rightBottom, resolution, isStartRowAndCol);
			isStartRowAndCol = true;
			var endRow:int = tempCoords.row;
			var endCol:int = tempCoords.col;
			
			var tile:Tile = this._ct.tile;
			var offsets:Point2D = tile.offset;
			//当前显示范围左上角瓦片对应的行列号
			var row:int = tile.coords.row;
			var col:int = tile.coords.col;
			
			var level:Number = this._ct.level;
			var mapId:String = map.id;
			var layerId:String = this.id;
			var rectX:Number = rect.x;
			var rectY:Number = rect.y;
			
			var offsetX:Number = offsets.x - this._coords_dx;
			var offsetY:Number = offsets.y - this._coords_dy;
			var offsetX2:Number = this._tileSize - offsetX - rectX;
			var offsetY2:Number = this._tileSize - offsetY - rectY;
			var offsetWidth:Number = offsetX2 > 0 ? (offsetX2 % this._tileSize) : (this._tileSize - Math.abs(offsetX2) % this._tileSize);
			var offsetHeight:Number = offsetY2 > 0 ? (offsetY2 % this._tileSize) : (this._tileSize - Math.abs(offsetY2) % this._tileSize);
			var clipStartCol:int = rectX > 0 ? (Math.floor((rectX + offsetX) / this._tileSize)) : (Math.ceil((rectX - (this._tileSize - offsetX)) / this._tileSize));
			var clipStartRow:int = rectY > 0 ? (Math.floor((rectY + offsetY) / this._tileSize)) : (Math.ceil((rectY - (this._tileSize - offsetY)) / this._tileSize));
			var clipEndCol:int = clipStartCol + Math.ceil((rect.width - offsetWidth) / this._tileSize);
			var clipEndRow:int= clipStartRow + Math.ceil((rect.height - offsetHeight) / this._tileSize);
			var offsetCol:int = clipStartCol;
			while (offsetCol <= clipEndCol)
			{	
				var offsetRow:int = clipStartRow;
				while (offsetRow <= clipEndRow)
				{			
					toAddRow = row + offsetRow;
					toAddCol = col + offsetCol;
					if (toAddRow >= startRow && toAddRow <= endRow && toAddCol >= startCol && toAddCol <= endCol)
					{
						tileId = this._tileSize + "_" + level + "_" + resolution + "_" +  toAddCol + "_" + toAddRow;
						if (this._tileIds.indexOf(tileId) === -1)
						{
							this._loadingStack.push(tileId);
							this._tileIds.push(tileId);
							this.addImage(level,resolution, offsetRow, toAddRow, offsetCol, toAddCol, tileId, this._tileSize, offsets);
						}
					}
					offsetRow++;
				}
				offsetCol++;
			}
		}
		
		private function addImage(level:Number, resolution:Number, offsetRow:Number, r:Number, offsetCol:Number, c:Number, id:String, tileSize:Number, offsets:Point2D) : void
		{
			var imgLoder:ImageLoader = new ImageLoader();
			this._tiles[id] = imgLoder;
			imgLoder.id = id;
			var tileBytes:ByteArray;
			var loaderContext:LoaderContext;
			if(this._offlineStorage)
			{
				tileBytes = _offlineStorage.getTile(imgLoder);
				if(tileBytes &&　tileBytes.length)
				{
					loaderContext = new LoaderContext();
					loaderContext.allowLoadBytesCodeExecution = true;
					
					imgLoder.addEventListener(Event.COMPLETE, this.onImageComplete2, false, 0, true);
					imgLoder.loadBytes(tileBytes, loaderContext);
					imgLoder.x = tileSize * offsetCol - offsets.x;
					imgLoder.y = tileSize * offsetRow - offsets.y;
					addChild(imgLoder);
					return;
				}
			}
			
			//如果采用本地离线数据包，通过数据库获取资源
			if(_offlineFilestored)
			{
				tileBytes = getLocalTile(r,c,level);
				if(tileBytes &&　tileBytes.length)
				{
					loaderContext = new LoaderContext();
					loaderContext.allowLoadBytesCodeExecution = true;
					
					imgLoder.addEventListener(Event.COMPLETE, this.onImageComplete2, false, 0, true);
					imgLoder.loadBytes(tileBytes, loaderContext);
					imgLoder.x = tileSize * offsetCol - offsets.x;
					imgLoder.y = tileSize * offsetRow - offsets.y;
					addChild(imgLoder);
				}
				else
				{
					this.tilePopPop(imgLoder);
				}
				return;
			}
			
			imgLoder.fadeInFrameCount = this.fadeInFrameCount;
			imgLoder.addEventListener(Event.COMPLETE, this.onImageComplete, false, 0, true);
			imgLoder.addEventListener(IOErrorEvent.IO_ERROR, this.onImageIOError, false, 0, true);
			imgLoder.x = tileSize * offsetCol - offsets.x;
			imgLoder.y = tileSize * offsetRow - offsets.y;
			var tileUrlReq:URLRequest = this.getTileURL2(r, c, level, resolution);
			
			//专门处理一下带有clipRegion的请求url
			if(tileUrlReq.url.indexOf("clipRegion") != -1 && tileUrlReq.url.length > 1024)
			{
				var sptStr:Array = tileUrlReq.url.split("?");
				var postURL:String = sptStr[0] + "?X-RequestEntity-ContentType=application/flex&flexAgent=true&_method=GET";
				tileUrlReq.url = postURL;				
				var keyValueAry:Array = sptStr[1].split("&");
				
				var variables:URLVariables = new URLVariables();
				
				tileUrlReq.method = URLRequestMethod.POST;
				
				var requestEntityStr:String = "";
				requestEntityStr += "{";
				for(var j:int = 0; j < keyValueAry.length; j++)
				{
					var keyItem:String = keyValueAry[j];
					var keyObj:Array = keyItem.split("=");
					var val:* = keyObj[1];
					var value:* = (val)? val : ("\"" + "" +  "\"");
					requestEntityStr += ("\"" + keyObj[0]  + "\""+ ":" + value + ",");
				}
				requestEntityStr += "}";
				variables.requestEntity = requestEntityStr;
				
				tileUrlReq.data = variables;
			}
			//处理clipRegion完毕!
			
			imgLoder.load(tileUrlReq);
			addChild(imgLoder);
		}
		
		protected function getLocalTile(row:int, col:int, level:int):ByteArray
		{
			return null;
		}
		
		private function onImageComplete(event:Event) : void
		{
			var img:ImageLoader = ImageLoader(event.target);
			if(this._offlineStorage)
				_offlineStorage.putTile(img);
			
			this.tilePopPop(img);
			if (hasEventListener(event.type))
			{
				dispatchEvent(event);
			}
		}
		
		private function onImageComplete2(event:Event) : void
		{
			var img:ImageLoader = ImageLoader(event.target);
			this.tilePopPop(img);
			if (hasEventListener(event.type))
			{
				dispatchEvent(event);
			}
		}
		
		private function onImageIOError(event:IOErrorEvent) : void
		{
			var img:ImageLoader = ImageLoader(event.target);
			this.tilePopPop(img);
			if (Log.isError())
			{
				this._log.error("{0}::{1}", id, event.text);
			}
			if (hasEventListener(event.type))
			{
				dispatchEvent(event);
			}
		}
		
		private function tilePopPop(img:ImageLoader) : void
		{
			var tileIndex:Number = this._loadingStack.indexOf(img.id);
			if (tileIndex != -1)
			{
				this._loadingStack.splice(tileIndex, 1);
			}
			img.removeEventListener(Event.COMPLETE, this.onImageComplete);
			img.removeEventListener(IOErrorEvent.IO_ERROR, this.onImageIOError);
			if (this._loadingStack.length === 0)
			{
				graphics.clear();
				this.cleanUpRemovedImages();
				if (this._fireAllComplete)
				{
					this._fireAllComplete = false;
					dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, null, true));
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function viewBoundsChangedHandler(event:ViewBoundsEvent) : void
		{
			super.viewBoundsChangedHandler(event);
			this._levelChange = event.levelChange;
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function removedHandler(event:Event) : void
		{
			if (event.target === this)
			{
				this.removeMapListeners();
				this.removeAllChildren();
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function hideHandler(event:FlexEvent) : void
		{
			super.hideHandler(event);
			if (map)
			{
				this._hiddenViewBounds = map.viewBounds.clone();
			}
			else
			{
				this._hiddenViewBounds = null;
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function showHandler(event:FlexEvent) : void
		{
			super.showHandler(event);
			if (map && map.viewBounds && this._hiddenViewBounds && 
				!map.viewBounds.equals(this._hiddenViewBounds))
			{
				this.removeAllChildren();
			}
		}
		
		private function cleanUpRemovedImages() : void
		{
			var imgLoader:ImageLoader = null;
			while (this._removeStack.length > 0)
			{		
				imgLoader = this._removeStack.pop();
				if (imgLoader && contains(imgLoader))
				{
					removeChild(imgLoader);
					imgLoader.cancel = true;
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function zoomStartHandler(event:ZoomEvent) : void
		{
			if (this._useDefaultZoomHandlers)
			{
				try
				{
					super.zoomStartHandler(event);
					this.removeAllChildren();
				}
				catch (error:SecurityError)
				{
					_useDefaultZoomHandlers = false;
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function zoomUpdateHandler(event:ZoomEvent) : void
		{
			if (this._useDefaultZoomHandlers)
			{
				super.zoomUpdateHandler(event);
			}
			else
			{
				var rect:Rectangle = parent.scrollRect;
				var ts:Number = Math.ceil(this._tileSize * event.zoomFactor);
				var twRatio:Number = event.width / map.width;
				var thRatio:Number = event.height / map.height;
				
				var idLength:int = this._tileIds.length;			
				var tileId:String = null;
				var tileBounds:Rectangle = null;
				var img:ImageLoader = null;
				
				for(var i:Number = 0; i < idLength; i++)
				{			
					tileId = this._tileIds[i];
					tileBounds = this._tileBounds[tileId];
					img = this._tiles[tileId];
					if(img && tileBounds)
					{
						img.x = event.x + (tileBounds.x - rect.x) * twRatio + rect.x;
						img.y = event.y + (tileBounds.y - rect.y) * thRatio + rect.y;
						img.width = ts;
						img.height = ts;
					}				
				}
			}
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function zoomEndHandler(event:ZoomEvent) : void
		{
			super.zoomEndHandler(event);
			this._useDefaultZoomHandlers = true;
		}
		
		sm_internal function forceToRefresh() : void
		{
			this._forceToRefreshFlag = true;
			this.invalidateLayer();
		}
	}
}