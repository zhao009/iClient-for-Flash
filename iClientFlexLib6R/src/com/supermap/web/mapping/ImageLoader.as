package com.supermap.web.mapping
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.*;
	import flash.utils.ByteArray;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	internal class ImageLoader extends Loader
	{
		private var _loaded:Boolean;
		private var _cancelled:Boolean;
		private var _errored:Boolean;
		private var _completeEvent:Event;
		private var _alphaFrameIncrease:Number;
		private var _context:LoaderContext;
		public var id:String;
		public var cancel:Boolean;
		private var _fadeInFrameCount:uint = 1;
		private var _smoothing:Boolean;
		
		public function ImageLoader()
		{
			this._alphaFrameIncrease = 1 / this.fadeInFrameCount;
			this._context = new LoaderContext();
			with (contentLoaderInfo)
			{
				addEventListener(Event.OPEN, contentLoaderInfo_openHandler, false, 0, true);
				addEventListener(ProgressEvent.PROGRESS, contentLoaderInfo_progressEventHandler, false, 0, true);
				addEventListener(Event.COMPLETE, contentLoaderInfo_completeHandler, false, 0, true);
				addEventListener(IOErrorEvent.IO_ERROR, contentLoaderInfo_ioErrorEventHandler, false, 0, true);
			}
			addEventListener(Event.REMOVED, this.removedHandler);
		}
		
		public function get fadeInFrameCount() : uint
		{
			return this._fadeInFrameCount;
		}
		
		public function set fadeInFrameCount(value:uint) : void
		{
			this._fadeInFrameCount = value;
			this._alphaFrameIncrease = 1 / value;
		}
		
		public function get smoothing() : Boolean
		{
			return this._smoothing;
		}
		
		public function set smoothing(value:Boolean) : void
		{
			if (this._smoothing != value)
			{
				this._smoothing = value;
				if (this._loaded)
				{
					this.setContentSmoothing(this._smoothing);
				}
			}
		}
		
		override public function load(request:URLRequest, context:LoaderContext = null) : void
		{
			this._context.checkPolicyFile = true;
			var local_context:LoaderContext = context ? (context) : (this._context);
			super.load(request, local_context);
		}
		
		override public function loadBytes(bytes:ByteArray, context:LoaderContext = null) : void
		{
			this._context.checkPolicyFile = false;
			var local_context:LoaderContext = context ? (context) : (this._context);
			super.loadBytes(bytes, local_context);
		}
		
		private function setContentSmoothing(smoothing:Boolean) : void
		{
			var local_context:Bitmap = content as Bitmap;
			if (local_context)
			{
				local_context.smoothing = smoothing;
			}
		}
		
		private function cancelDownload() : void
		{
			if (this.cancel && !this._loaded && !this._cancelled && !this._errored)
			{
				try
				{
					close();
				}
				catch (error:Error)
				{
				}
				finally
				{
					unload();
				}
				this._cancelled = true;
			}
		}
		
		private function removedHandler(event:Event) : void
		{
			if (!this._loaded)
			{
				this.cancel = true;
				this.cancelDownload();
			}
			else
			{
				unload();
			}
		}
		
		private function contentLoaderInfo_openHandler(event:Event) : void
		{
			this.cancelDownload();
			dispatchEvent(event);

		}
		
		private function contentLoaderInfo_progressEventHandler(event:ProgressEvent) : void
		{
			this.cancelDownload();
			dispatchEvent(event);
		}
		
		private function contentLoaderInfo_completeHandler(event:Event) : void
		{
			this._loaded = true;
			if (this.smoothing)
			{
				this.setContentSmoothing(true);
			}
			if (this.fadeInFrameCount > 1)
			{
				alpha = this._alphaFrameIncrease;
				addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
				this._completeEvent = event;
			}
			else
			{
				dispatchEvent(event);
			}
		}
		
		private function contentLoaderInfo_ioErrorEventHandler(event:IOErrorEvent) : void
		{
			this._errored = true;
			dispatchEvent(event);
		}
		
		private function enterFrameHandler(event:Event) : void
		{
			alpha = alpha + this._alphaFrameIncrease;
			if (alpha > 0.99)
			{
				alpha = 1;
				removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
				dispatchEvent(this._completeEvent);
			}
		}
		
	}
}