package com.supermap.web.samples.mapping
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.mapping.TiledCachedLayer;
	
	import flash.net.URLRequest;
	
	public class TiledTDTLayer extends TiledCachedLayer
	{
		//影像类型，包括：矢量、影像两种
		private var _mapType:String;
		private var _mapTypeChanged:Boolean;
		public static const MAP_TYPE_VECTOR:String = "vector";
		public static const MAP_TYPE_AERIAL:String = "aerial";
		private var _isLabel:Boolean;
		private var _isLabelChange:Boolean;
		//道路：
		//1~10级
		private const VECTOR_URL_WORLD:String = "http://tile{subdomain}.tianditu.com/DataServer?T=A0512_EMap&X={tileX}&Y={tileY}&L={level}";
		private const VECTOR_URL_WORLD_LABEL:String = "http://tile{subdomain}.tianditu.com/DataServer?T=AB0512_Anno&X={tileX}&Y={tileY}&L={level}";
		//11~12级
		private const VECTOR_URL_CHINA_1:String = "http://tile{subdomain}.tianditu.com/DataServer?T=B0627_EMap1112&X={tileX}&Y={tileY}&L={level}";
		//13~18级
		private const VECTOR_URL_CHINA_2:String = "http://tile{subdomain}.tianditu.com/DataServer?T=siwei0608&X={tileX}&Y={tileY}&L={level}";
		
		//影像
		//1~10级
		private const AE_URL_1:String = "http://tile{subdomain}.tianditu.com/DataServer?T=sbsm0210&X={tileX}&Y={tileY}&L={level}";
		private const AE_URL_LABEL_1:String = "http://tile{subdomain}.tianditu.com/DataServer?T=A0610_ImgAnno&X={tileX}&Y={tileY}&L={level}";
		//11级
		private const AE_URL_11:String = "http://tile{subdomain}.tianditu.com/DataServer?T=e11&X={tileX}&Y={tileY}&L={level}";
		//12级
		private const AE_URL_12:String = "http://tile{subdomain}.tianditu.com/DataServer?T=e12&X={tileX}&Y={tileY}&L={level}";
		//13级
		private const AE_URL_13:String = "http://tile{subdomain}.tianditu.com/DataServer?T=e13&X={tileX}&Y={tileY}&L={level}";
		private const AE_URL_LABEL_1113:String = "http://tile{subdomain}.tianditu.com/DataServer?T=B0530_eImgAnno&X={tileX}&Y={tileY}&L={level}";
		//14级
		private const AE_URL_14:String = "http://tile{subdomain}.tianditu.com/DataServer?T=eastdawnall&X={tileX}&Y={tileY}&L={level}";
		//其它
		private const AE_URL_2:String = "http://tile{subdomain}.tianditu.com/DataServer?T=sbsm1518&X={tileX}&Y={tileY}&L={level}";
		private const AE_URL_LABEL_2:String = "http://tile{subdomain}.tianditu.com/DataServer?T=siweiAnno68&X={tileX}&Y={tileY}&L={level}";
		public function TiledTDTLayer()
		{
			super();
			this.mapType = TiledTDTLayer.MAP_TYPE_VECTOR;
			this.tileSize = 256;
			this._isLabel = false;
			this.loadLayerInfo();
		}
		
		private function loadLayerInfo():void
		{
			this.bounds = new Rectangle2D(-180, -90, 180, 90);
			this.origin = new Point2D(-180,90);
			this.resolutions = [0.35346564346121762, 0.1767328217186605, 0.088366410859330252,
				0.044183205441613423, 0.022091602720806711, 0.011045801360403356, 0.0055229006802016778,
				0.0027614503401008389, 0.0013807251700504195, 0.00069036257307691462, 0.00034518129848675242,
				0.00017259063729508113, 0.000086295318647540564, 0.000043147659323770282, 
				0.00002157384161018023, 0.000010786920805090115, 0.0000053934604025450575];
			setLoaded(true);
		}
		
		[Inspectable(category = "iClient", enumeration = "true,false")] 
		public function get isLabel():Boolean
		{
			return _isLabel;
		}

		public function set isLabel(value:Boolean):void
		{
			if(this._isLabel != value)
			{
				_isLabel = value;
				this._isLabelChange = true;
				invalidateProperties();
			}
		}

		[Inspectable(category = "iClient", enumeration = "vector,aerial")] 
		public function get mapType():String
		{
			return _mapType;
		}

		public function set mapType(value:String):void
		{
			if (this._mapType != value)
			{
				this._mapType = value;
				this._mapTypeChanged = true;
				invalidateProperties();
			}
		}
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._mapTypeChanged || this._isLabelChange)
			{
				removeAllChildren();
				this._mapTypeChanged = false;
				this._isLabelChange = false;
				invalidateLayer();
			}
		}

		override protected function getTileURL(row:int, col:int, level:int):URLRequest
		{
			level += 2;
			var serverURL:String;
			switch(this.mapType)
			{
				case MAP_TYPE_VECTOR:
					if(level<=10)
					{
						if(this.isLabel)
							serverURL = VECTOR_URL_WORLD_LABEL;
						else
							serverURL = VECTOR_URL_WORLD;
					}
					else if(level>10 && level <= 12)
						serverURL = VECTOR_URL_CHINA_1;
					else if(level>12 && level <= 18)
						serverURL = VECTOR_URL_CHINA_2;
					break;
				case MAP_TYPE_AERIAL:
					if(level<=10)
					{
						if(this.isLabel)
							serverURL = AE_URL_LABEL_1;
						else
							serverURL = AE_URL_1;
					}
					else
					{
						switch(level)
						{
							case 11:
								if(this.isLabel)
									serverURL = AE_URL_LABEL_1113;
								else
									serverURL = AE_URL_11;
								break;
							case 12:
								if(this.isLabel)
									serverURL = AE_URL_LABEL_1113;
								else
									serverURL = AE_URL_12;
								break;
							case 13:
								if(this.isLabel)
									serverURL = AE_URL_LABEL_1113;
								else
									serverURL = AE_URL_13;
								break;
							case 14:
								if(this.isLabel)
									serverURL = AE_URL_LABEL_2;
								else
									serverURL = AE_URL_14;
								break;
							default:
								if(this.isLabel)
									serverURL = AE_URL_LABEL_2;
								else
									serverURL = AE_URL_2;
								break;
						}
					}
			}
			serverURL = serverURL.replace("{subdomain}", Math.round(Math.random() * 5).toString()); 
			serverURL = serverURL.replace("{tileX}", col.toString());
			serverURL = serverURL.replace("{tileY}", row.toString());
			serverURL = serverURL.replace("{level}", level.toString());
			return new URLRequest(serverURL);
		}
	}
}