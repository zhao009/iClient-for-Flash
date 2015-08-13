package com.supermap.web.components
{
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.mapping.Map;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;


	/**
	 * ${components_MapHistoryManager_Title}.
	 * <p>${components_MapHistoryManager_Description}</p> 
	 * 
	 * 
	 */	
	public class MapHistoryManager extends EventDispatcher
	{
		private var _nexViewBound:Boolean = false;
		private var _viewBounds:Array;
		private var _prevViewBound:Boolean = false;
		private var _viewBoundIndex:Number = -1;
		private var _map:Map;

		/**
		 * ${components_MapHistoryManager_constructor_None_D} 
		 * 
		 */		
		public function MapHistoryManager()
		{
		}
		
		/**
		 * ${components_MapHistoryManager_attribute_map_D} 
		 * @see Map Class
		 * 
		 */		
		public function get map():Map
		{
			return this._map;
		} 
		
		public function set map(value:Map):void
		{
			if(value)
			{ 
				if(this._map != value)
				{
					this._map = value;
					resetVars();
					if (this._map.viewBounds)
					{
						this._viewBounds.push(this._map.viewBounds.clone());
						rectifyIndex();
					}
					
					this._map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE , viewBoundsChangeHandler);
				}
			}
		} 
		
		/**
		 * ${components_MapHistoryManager_attribute_isLastViewBounds_D} 
		 * @return 
		 * 
		 */		
		public function get isLastViewBounds() : Boolean
		{
			return this._viewBoundIndex == (this._viewBounds.length - 1);
		}
		
		/**
		 * ${components_MapHistoryManager_attribute_isFirstViewBounds_D} 
		 * @return 
		 * 
		 */		
		public function get isFirstViewBounds() : Boolean
		{
			return this._viewBoundIndex <= 0;
		}
		
		/**
		 * ${components_MapHistoryManager_method_viewPreViewBounds_D} 
		 * 
		 */		
		public function viewPreViewBounds() : void
		{
			if (isFirstViewBounds)
			{
				return;
			}
			
			this._viewBoundIndex -= 1;
			rectifyIndex();
			this._prevViewBound = true;
			this._map.viewBounds = this._viewBounds[this._viewBoundIndex];
		}
		
		/**
		 * ${components_MapHistoryManager_method_viewNextViewBounds_D} 
		 * 
		 */		
		public function viewNextViewBounds() : void
		{
			if (isLastViewBounds)
			{
				return;
			}
			
			this._viewBoundIndex += 1;
			rectifyIndex();
			this._nexViewBound = true;
			this._map.viewBounds = this._viewBounds[this._viewBoundIndex];
		}
		
		private function viewBoundsChangeHandler(event:ViewBoundsEvent) : void
		{
			if (!this._prevViewBound)
			{
				if (!this._nexViewBound)
				{
					this._viewBounds = this._viewBounds.splice(0, (this._viewBoundIndex + 1));
					this._viewBounds.push(event.viewBounds.clone());
					this._viewBoundIndex = this._viewBounds.length - 1;
				}
			}
			
			this._prevViewBound = false;
			this._nexViewBound = false;
			dispatchEvent(event);
		}
		
		private function resetVars() : void
		{
			this._viewBounds = [];
			this._nexViewBound = false;
			this._prevViewBound = false;
			this._viewBoundIndex = -1;
		}
		
		private function rectifyIndex() : void
		{
			if (this._viewBoundIndex < 0)
			{
				this._viewBoundIndex = 0;
				dispatchEvent(new Event("indexChange"));
			}
			else if (this._viewBoundIndex > this._viewBounds.length)
			{
				this._viewBoundIndex = this._viewBounds.length;
				dispatchEvent(new Event("cursorChange"));
			}
		}

	}
}