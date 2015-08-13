package com.supermap.web.mapping
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.Credential;
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.*;
	import flash.net.URLRequest;
	
	import mx.events.PropertyChangeEvent;
	use namespace sm_internal;
	
	/**
	 * ${mapping_HighlightLayer_Title}.
	 * <p>${mapping_HighlightLayer_Description}</p> 
	 * 
	 */	
	public class HighlightLayer extends DynamicLayer
	{		
		//private var _imageFormat:String = "png";
		private var _urlRequest:URLRequest;
		private var _highlightTargetsetID:String = "";
		private var _queryResultID:String = "";
		private var _style:ServerStyle = null;	
		private var _redirect:Boolean = true;
		private var _url:String = "";
		private var _encodedUrl:String;
		private var _customServiceParams:Object;
		
		private var _maxVisibleVertex:int;
		/**
		 * ${mapping_HighlightLayer_constructor_D} 
		 * @param url ${mapping_HighlightLayer_constructor_param_url}
		 * 
		 */		
		public function HighlightLayer(url:String)
		{
			super();
			this.url = url;
			this._urlRequest = new URLRequest();
			this.setLoaded(true);
			this._maxVisibleVertex = int.MAX_VALUE;
		}

		/**
		 * ${mapping_HighlightLayer_attribute_maxVisibleVertex_D} 
		 * @return 
		 * 
		 */		
		public function get maxVisibleVertex():int
		{
			return _maxVisibleVertex;
		}

		public function set maxVisibleVertex(value:int):void
		{
			_maxVisibleVertex = value;
		}

		/**
		 * ${iServerJava6R_DynamicRESTLayer_customServiceParams_D}.
		 * <p>${iServerJava6R_DynamicRESTLayer_customServiceParams_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get customServiceParams():Object
		{
			if(!_customServiceParams)
			{
				_customServiceParams = new Object();
			}
			return _customServiceParams;
		}
		
		public function set customServiceParams(value:Object):void
		{
			if (this._customServiceParams is IEventDispatcher)
			{
				IEventDispatcher(this._customServiceParams).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.customServerParams_changeHandler);
			}
			this._customServiceParams = value;
			if (this._customServiceParams is IEventDispatcher)
			{
				IEventDispatcher(this._customServiceParams).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.customServerParams_changeHandler, false, 0, true);
			}
		}
		
		/**
		 * ${mapping_HighlightLayer_Redirect_D}.
		 * <p>${mapping_HighlightLayer_Redirect_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get redirect():Boolean
		{
			return _redirect;
		}

		public function set redirect(value:Boolean):void
		{
			_redirect = value;
		}

		/**
		 * ${mapping_HighlightLayer_url_D}.
		 * <p>${mapping_HighlightLayer_url_remarks}</p>
		 * 
		 */		
		public override function get url():String
		{	
			return this._url;
		}
		public override function set url(value:String):void
		{
			if (this._url != value)
			{			
				if (value && value != "")
				{
					super.url = value;
					this._url = value;	
					//invalidateLayer();
					var markIndex:int = this.url.lastIndexOf("/");
					var preUrl:String = this.url.substr(0, markIndex + 1);
					var mapName:String = this.url.substr(markIndex + 1);
					this._encodedUrl = preUrl + encodeURI(mapName);
					
					if(this._url.lastIndexOf("/") != this._url.length - 1)
					{
						this._url += "/";
						this._encodedUrl += "/";
					}
					
					invalidateProperties();
				}				
			}
		}
		
		/**
		 * ${mapping_HighlightLayer_Style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ServerStyle
		{
			return _style;
		}

		public function set style(value:ServerStyle):void
		{
			_style = value;
		}

		/**
		 * ${mapping_HighlightLayer_queryResultID_D}.
		 * <p>${mapping_HighlightLayer_queryResultID_remarks}</p> 
		 * @see #highlightTargetsetID
		 * @see com.supermap.web.iServerJava6R.queryServices.QueryParameters#returnContent
		 * @see com.supermap.web.iServerJava6R.queryServices.QueryResult#resourceInfo
		 * @see com.supermap.web.iServerJava6R.queryServices.QueryResult#recordsets
		 * @return 
		 * 
		 */		
		public function get queryResultID():String
		{
			return _queryResultID;
		}

		public function set queryResultID(value:String):void
		{			
			if (this.queryResultID != value)
			{			
				if (value && value != "")
				{
					_queryResultID = value;	
					invalidateProperties();					
				}				
			}
		}

		/**
		 * ${mapping_HighlightLayer_attribute_highlightTargetSetID_D}
		 * @see #queryResultID 
		 * @return 
		 * 
		 */		
		public function get highlightTargetsetID():String
		{
			return _highlightTargetsetID;
		}

		public function set highlightTargetsetID(value:String):void
		{
			if (this.queryResultID != value)
			{			
				if (value && value != "")
				{
					_highlightTargetsetID = value;	
					invalidateProperties();					
				}				
			}
		}
	
		
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			invalidateLayer();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function loadMapImage(loader:Loader) : void
		{
			if (this.resolution <= 0)
			{
				return;
			}	  	
			var viewBounds:String = JsonUtil.fromRectangle2D(this.map.viewBounds);
			var width:Number = this.map.width;
			var height:Number = this.map.height;	
						
			var mapURL:String = "";
			
			mapURL +=  this._encodedUrl + "highlightImage." + "png" +"?viewBounds=" + viewBounds + "&width=" + width + 
			"&height=" + height + "&transparent=" + this.transparent;				
			
			if (this.queryResultID != null)
			{
				mapURL += "&queryResultID=" + this.queryResultID;
			}
			else
			{
				mapURL += "&highlightTargetSetID=" + this.highlightTargetsetID;
			}
			if(this.style)
				mapURL += "&style=" + this.style.toJSON();			
			else
				mapURL += "&style=" + "null";	
			
			mapURL += "&redirect=" + this.redirect;
				
			if(this._customServiceParams)
			{
				for (var prop:String in this.customServiceParams) 
				{
					mapURL += ("&" + prop + "=" + this.customServiceParams[prop]);
				}
			}
			if(this.maxVisibleVertex != int.MAX_VALUE && this.maxVisibleVertex > 0)
			{
				mapURL += ("&maxVisibleVertex=" + this.maxVisibleVertex); 
			} 
			if(Credential.CREDENTIAL)
			{
				mapURL += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			this._urlRequest.url = mapURL;
			
			loader.load(this._urlRequest);
		}
		
		private function customServerParams_changeHandler(event:Event) : void
		{		
			this.invalidateLayer();			
		}
	}
}