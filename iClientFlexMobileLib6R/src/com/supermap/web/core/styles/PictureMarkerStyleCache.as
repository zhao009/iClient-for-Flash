package com.supermap.web.core.styles
{
    import com.supermap.web.core.geometry.*;
    
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    import mx.core.BitmapAsset;
    import mx.logging.*;
	/**
	 * @private 
	 * 
	 */	
    internal class PictureMarkerStyleCache extends Object
    {
        private var _sourceToObject:Dictionary;
        private var _logger:ILogger;
        private var _customPictureMarkerSprite:CustomSprite;
        private var _loaderContext:LoaderContext;
        private var _broken:Class;
        private static var _instance:PictureMarkerStyleCache;

        public function PictureMarkerStyleCache()
        {
            this._sourceToObject = new Dictionary();
            this._loaderContext = new LoaderContext(true);
            this._broken = BitmapAsset;
            
        }

        private function get logger() : ILogger
        {
            if (this._logger == null)
            {
                this._logger = Log.getLogger(getQualifiedClassName(PictureMarkerStyleCache).replace(/::/, "."));
            }
            return this._logger;
        }

        public function getDisplayObject(source:Object, point:GeoPoint, operation:Function) : void
        {
            var onComplete:Function;
            var onIOError:Function;
            var loader:Loader;
            onComplete = function (event:Event) : void
            {
                var _loc_3:Number = NaN;
                var _loc_4:Number = NaN;
                var _loc_2:* = event.target as LoaderInfo;
                CustomPictureMarkerObject(_sourceToObject[source]).status = "complete";
                if (_loc_2.content is Bitmap)
                {
                    CustomPictureMarkerObject(_sourceToObject[source]).isBitMap = true;
                    CustomPictureMarkerObject(_sourceToObject[source]).bitmap = _loc_2.content as Bitmap;
                    _loc_3 = 0;
                    while (_loc_3 < CustomPictureMarkerObject(_sourceToObject[source]).arrFunction.length)
                    {
                        
                        addBitmapImage(CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[_loc_3].operation, CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[_loc_3].pt, CustomPictureMarkerObject(_sourceToObject[source]).bitmap);
                        _loc_3++;
                    }
                }
                else
                {
                    CustomPictureMarkerObject(_sourceToObject[source]).isBitMap = false;
                    _customPictureMarkerSprite = new CustomSprite();
                    if (CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[0].pt)
                    {
                        _customPictureMarkerSprite.point = CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[0].pt;
                        _customPictureMarkerSprite.x = CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[0].pt.x;
                        _customPictureMarkerSprite.y = CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[0].pt.y;
                    }
                    _customPictureMarkerSprite.addChild(loader);
                    CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[0].operation(_customPictureMarkerSprite);
                    _loc_4 = 1;
                    while (_loc_4 < CustomPictureMarkerObject(_sourceToObject[source]).arrFunction.length)
                    {
                        
                        loadNonBitmapImage(CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[_loc_4].operation, CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[_loc_4].pt, source);
                        _loc_4 = _loc_4 + 1;
                    }
                }
                
            }
            ;
            onIOError = function (event:Event) : void
            {
                if (Log.isError())
                {
                    logger.error(event.toString());
                }
                CustomPictureMarkerObject(_sourceToObject[source]).isBitMap = true;
                CustomPictureMarkerObject(_sourceToObject[source]).bitmap = new _broken() as Bitmap;
                var _loc_2:Number = 0;
                while (_loc_2 < CustomPictureMarkerObject(_sourceToObject[source]).arrFunction.length)
                {
                    
                    addBitmapImage(CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[_loc_2].operation, CustomPictureMarkerObject(_sourceToObject[source]).arrFunction[_loc_2].pt, CustomPictureMarkerObject(_sourceToObject[source]).bitmap);
                    _loc_2 = _loc_2 + 1;
                }
                _sourceToObject[source] = null;
                
            }
            ;
            var customPictureMarkerObject:CustomPictureMarkerObject = this._sourceToObject[source];
            if (customPictureMarkerObject == null)
            {
                customPictureMarkerObject = new CustomPictureMarkerObject();
                customPictureMarkerObject.arrFunction = [];
                loader = new Loader();
                loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
                loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
                if (source is String)
                {
                    loader.load(new URLRequest(String(source)), this._loaderContext);
                }
                else
                {
                    loader.loadBytes(source as ByteArray, new LoaderContext());
                }
                customPictureMarkerObject.status = "pending";
                customPictureMarkerObject.arrFunction.push({operation:operation, pt:point});
                this._sourceToObject[source] = customPictureMarkerObject;
            }
            else if (customPictureMarkerObject.status == "pending")
            {
                customPictureMarkerObject.arrFunction.push({operation:operation, pt:point});
            }
            else if (customPictureMarkerObject.status == "complete")
            {
                if (customPictureMarkerObject.isBitMap)
                {
                    this.addBitmapImage(operation, point, customPictureMarkerObject.bitmap);
                }
                else
                {
                    this.loadNonBitmapImage(operation, point, source);
                }
            }
            
        }

        public function isComplete(source:String) : Boolean
        {
            if (this._sourceToObject[source])
			{
				return CustomPictureMarkerObject(this._sourceToObject[source]).status == "complete" ? (true) : (false);
			}
			return false;
        }

        private function addBitmapImage(funct:Function, pt:GeoPoint, bitmap:Bitmap) : void
        {
            this._customPictureMarkerSprite = new CustomSprite();
            if (pt)
            {
                this._customPictureMarkerSprite.point = pt;
                this._customPictureMarkerSprite.x = pt.x;
                this._customPictureMarkerSprite.y = pt.y;
            }
            this._customPictureMarkerSprite.addChild(new Bitmap(bitmap.bitmapData));
            funct(this._customPictureMarkerSprite);
            
        }

        private function loadNonBitmapImage(funct:Function, pt:GeoPoint, source:Object) : void
        {
            var loader:Loader;
            var onComplete:Function;
            var onIOError:Function;
            var funct:* = funct;
            var pt:* = pt;
            var source:* = source;
            onComplete = function (event:Event) : void
            {
                _customPictureMarkerSprite = new CustomSprite();
                if (pt)
                {
                    _customPictureMarkerSprite.point = pt;
                    _customPictureMarkerSprite.x = pt.x;
                    _customPictureMarkerSprite.y = pt.y;
                }
                _customPictureMarkerSprite.addChild(loader);
                funct(_customPictureMarkerSprite);
                
            }
            onIOError = function (event:Event) : void
            {
                if (Log.isError())
                {
                    logger.error(event.toString());
                }
                
            }
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
            if (source is String)
            {
                loader.load(new URLRequest(String(source)), this._loaderContext);
            }
            else
            {
                loader.loadBytes(source as ByteArray, new LoaderContext());
            }
            
        }

        public static function get instance() : PictureMarkerStyleCache
        {
            if (_instance == null)
            {
                _instance = new PictureMarkerStyleCache;
            }
            return _instance;
        }

    }
}
