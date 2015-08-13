package com.supermap.web.iServerJava6R.mapServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.iServerJava6R.serviceEvents.ClearCacheEvent;
	import com.supermap.web.resources.SmServerError;
	import com.supermap.web.resources.SmServerResource;
	import com.supermap.web.service.ServiceBase;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	/**
	 * ${iServerJava6R_ClearCacheService_Title}.
	 * <p>${iServerJava6R_ClearCacheService_Description}</p>
	 *
	 */
	public class ClearCacheService extends ServiceBase
	{
		private var _bounds:Rectangle2D;
		private var _scale:Number;
		private var _picWidth:int;
		private var _picHeight:int;

		/**
		 * ${iServerJava6R_ClearCacheService_constructor_String_D}.
		 * @param url ${iServerJava6R_ClearCacheService_constructor_String_param_url}
		 *
		 */
		public function ClearCacheService(url:String)
		{
			super(url);
		}

		/**
		 * ${iServerJava6R_ClearCacheService_method_ProcessAsync_D}
		 * @param responder ${iServerJava6R_ClearCacheService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_ClearCacheService_method_ProcessAsync_return}
		 *
		 */
		public function processAsync(responder:IResponder = null):AsyncToken
		{
			if (!this._bounds)
			{
				throw new SmServerError(SmServerResource.BOUNDS_NULL);
				return null;
			}
			var variable:String = "bounds=" + "{\"rightTop\":{\"y\":" + bounds.top + ", \"x\":" + bounds.right
				+ "},\"leftBottom\":{\"y\":" + bounds.bottom + ", \"x\":" + bounds.left + "}}";
			if (scale && !isNaN(scale))
			{
				variable += "&scale=" + scale;
			}
			if (_picWidth && picHeight)
			{
				variable += "&picWidth=" + picWidth + "&picHeight=" + picHeight;
			}
			return sendURL("/clearcache.json", variable, responder, this.resultHandler);
		}

		private function resultHandler(object:Object, asyncToken:AsyncToken):void
		{
			var result:ClearCacheResult = new ClearCacheResult(object.toString());
			for each (var responder:IResponder in asyncToken.responders)
			{
				responder.result(result);
			}
			this.dispatchEvent(new ClearCacheEvent(ClearCacheEvent.PROCESS_COMPLETE, result, object));
		}

		/**
		 * ${iServerJava6R_ClearCacheService_attribute_picHeight_D}
		 * @see picWidth
		 * @return
		 *
		 */
		public function get picHeight():int
		{
			return _picHeight;
		}

		public function set picHeight(value:int):void
		{
			_picHeight = value;
		}

		/**
		 * ${iServerJava6R_ClearCacheService_attribute_picWidth_D}
		 * @see picHeight
		 * @return
		 *
		 */
		public function get picWidth():int
		{
			return _picWidth;
		}

		public function set picWidth(value:int):void
		{
			_picWidth = value;
		}

		/**
		 * ${iServerJava6R_ClearCacheService_attribute_scale_D}
		 * @return
		 *
		 */
		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
		}

		/**
		 * ${iServerJava6R_ClearCacheService_attribute_bounds_D}
		 * @return
		 *
		 */
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

	}
}
