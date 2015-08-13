package com.supermap.web.symbol.clover
{
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	import mx.utils.NameUtil;
	import mx.utils.ObjectUtil;

	use namespace sm_internal;

	/**
	 * ${symbol_SectorItem_Title}.
	 * <p>${symbol_SectorItem_Description}</p> 
	 * @see com.supermap.web.symbol.clover.CloverStyle
	 * 
	 */	
	public class SectorItem extends Style
	{
		/*******************************
		* 	扇形中心线角度(必设属性)
		********************************/
		private var _sectorCenterLineAngle:Number = 0;
		
		/*******************************
		 * 	扇形内角角度（默认为60）
		 *******************************/
		private var _sectorInnerAngle:Number = 60;
		
		/*******************************
		 * 	默认大小（半径默认为10）
		 *******************************/
		private var _sectorRadius:Number = 10;
		
		/*******************************
		 * 	颜色（默认为红色）
		 *******************************/
		private var _sectorColor:uint = 0xFF0000;
		
		/*****************************
		 * 	透明度（默认为不透明）
		 ******************************/
		private var _sectotAlpha:Number = 1;
		
		/*****************************
		 * 	是否显示边框（默认为不显示）
		 ******************************/
		private var _isBorder:Boolean = false;
		
		/*****************************
		 * 	边框颜色（默认为蓝色）
		 ******************************/
		private var _borderColor:uint = 0x0000FF;
		
		/*****************************
		 * 	边框透明度（默认为0.8）
		 ******************************/
		private var _borderAlpha:Number = 0.8;
		
		/*****************************
		 * 	边框宽度（默认为1）
		 ******************************/
		private var _borderWeight:Number = 1;
		private var _attributes:Object;
		sm_internal var pts:Array;
		sm_internal var centerX:Number;
		sm_internal var centerY:Number;
		
		sm_internal var uniqueID:String;
		
		/**
		 * ${symbol_SectorItem_constructor_D} 
		 * @param sectorCenterLineAngle ${symbol_SectorItem_constructor_param_sectorCenterLineAngle}
		 * @param sectorInnerAngle ${symbol_SectorItem_constructor_param_sectorInnerAngle}
		 * @param sectorRadius ${symbol_SectorItem_constructor_param_sectorRadius}
		 * @param sectorColor ${symbol_SectorItem_constructor_param_sectorColor}
		 * @param sectotAlpha ${symbol_SectorItem_constructor_param_sectotAlpha}
		 * @param attributes ${symbol_SectorItem_constructor_param_attributes}
		 * @param isBorder ${symbol_SectorItem_constructor_param_isBorder}
		 * @param borderColor ${symbol_SectorItem_constructor_param_borderColor}
		 * @param borderAlpha ${symbol_SectorItem_constructor_param_borderAlpha}
		 * @param borderWeight ${symbol_SectorItem_constructor_param_borderWeight}
		 * 
		 */	
		public function SectorItem(sectorCenterLineAngle:Number, sectorInnerAngle:Number = 60, sectorRadius:Number = 30, sectorColor:uint = 0xFF0000, sectotAlpha:Number = 1, attributes:Object = null, isBorder:Boolean = false, borderColor:uint = 0x0000FF, borderAlpha:Number = 0.8, borderWeight:Number = 1)
		{			
			this._sectorCenterLineAngle = sectorCenterLineAngle;
			this._sectorInnerAngle = sectorInnerAngle;
			this._sectorRadius = sectorRadius;
			this._sectorColor = sectorColor;
			this._sectotAlpha = sectotAlpha;
			this._attributes = attributes;
			this._isBorder = isBorder;
			this._borderColor = borderColor;
			this._borderAlpha = borderAlpha;
			this._borderWeight = borderWeight;
			
			uniqueID = NameUtil.createUniqueName(this);
		}
		
		/**
		 * ${symbol_SectorItem_attribute_attributes_D} 
		 * @return 
		 * 
		 */		
		public function get attributes():Object
		{
			return _attributes;
		}
		
		public function set attributes(value:Object):void
		{
			var oldValue:Object = this._attributes;
			if(this._attributes !== value)
			{
				this._attributes = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"attributes",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_borderWeight_D} 
		 * @return 
		 * 
		 */		
		public function get borderWeight():Number
		{
			return _borderWeight;
		}

		public function set borderWeight(value:Number):void
		{
			var oldValue:Number = this.borderWeight;
			if(this._borderWeight !== value)
			{
				this._borderWeight = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderWeight",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_borderAlpha_D} 
		 * @return 
		 * 
		 */		
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		public function set borderAlpha(value:Number):void
		{
			var oldValue:Number = this.borderAlpha;
			if(this._borderAlpha !== value)
			{
				this._borderAlpha = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderAlpha",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_borderColor_D} 
		 * @return 
		 * 
		 */		
		public function get borderColor():uint
		{
			return _borderColor;
		}

		public function set borderColor(value:uint):void
		{
			var oldValue:Number = this.borderColor;
			if(this._borderColor !== value)
			{
				this._borderColor = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderColor",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_isBorder_D} 
		 * @return 
		 * 
		 */		
		public function get isBorder():Boolean
		{
			return _isBorder;
		}

		public function set isBorder(value:Boolean):void
		{
			var oldValue:Boolean = this.isBorder;
			if(this._isBorder !== value)
			{
				this._isBorder = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isBorder",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_sectotAlpha_D} 
		 * @return 
		 * 
		 */		
		public function get sectotAlpha():Number
		{
			return _sectotAlpha;
		}

		public function set sectotAlpha(value:Number):void
		{
			var oldValue:Number = this.sectotAlpha;
			if(this._sectotAlpha !== value)
			{
				this._sectotAlpha = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sectotAlpha",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_sectorColor_D} 
		 * @return 
		 * 
		 */		
		public function get sectorColor():uint
		{
			return _sectorColor;
		}

		public function set sectorColor(value:uint):void
		{
			var oldValue:Number = this.sectorColor;
			if(this._sectorColor !== value)
			{
				this._sectorColor = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sectorColor",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_sectorRadius_D} 
		 * @return 
		 * 
		 */		
		public function get sectorRadius():Number
		{
			return _sectorRadius;
		}

		public function set sectorRadius(value:Number):void
		{
			var oldValue:Number = this.sectorRadius;
			if(this._sectorRadius !== value)
			{
				this._sectorRadius = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sectorRadius",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_sectorInnerAngle_D} 
		 * @return 
		 * 
		 */		
		public function get sectorInnerAngle():Number
		{
			return _sectorInnerAngle;
		}

		public function set sectorInnerAngle(value:Number):void
		{
			var oldValue:Number = this.sectorInnerAngle;
			if(this._sectorInnerAngle !== value)
			{
				this._sectorInnerAngle = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sectorInnerAngle",oldValue, value));
				}
			}
		}

		/**
		 * ${symbol_SectorItem_attribute_sectorCenterLineAngle_D} 
		 * @return 
		 * 
		 */		
		public function get sectorCenterLineAngle():Number
		{
			return _sectorCenterLineAngle;
		}

		public function set sectorCenterLineAngle(value:Number):void
		{
			var oldValue:Number = this.sectorCenterLineAngle;
			if(this._sectorCenterLineAngle !== value)
			{
				this._sectorCenterLineAngle = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"sectorCenterLineAngle",oldValue, value));
				}
			}
		}
		
		//TODO:
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function toString():String
		{
			return "";
		}
		
		sm_internal static function formSectorItem(sectorItem:SectorItem):SectorItem
		{
			var sectorItemStyle:SectorItem;
			if(sectorItem)
			{
				sectorItemStyle = new SectorItem(sectorItem.sectorCenterLineAngle);
				sectorItemStyle.attributes = sectorItem.attributes;
				var obj:Object;
				if(sectorItem.attributes){
					obj = SectorItem.clone(sectorItem.attributes);
					sectorItemStyle.attributes = obj;
				}
				sectorItemStyle.attributes = obj;
				sectorItemStyle.borderAlpha = sectorItem.borderAlpha;
				sectorItemStyle.borderColor = sectorItem.borderColor;
				sectorItemStyle.borderWeight = sectorItem.borderWeight;
				sectorItemStyle.isBorder = sectorItem.isBorder;
				sectorItemStyle.sectorColor = sectorItem.sectorColor;
				sectorItemStyle.sectorInnerAngle = sectorItem.sectorInnerAngle;
				sectorItemStyle.sectorRadius = sectorItem.sectorRadius;
				sectorItemStyle.sectotAlpha = sectorItem.sectotAlpha;
			}
			return sectorItemStyle;
		}
		
		public static function clone(object:Object):Object
		{
            var qClassName:String = getQualifiedClassName(object);			
            var objectType:Class = getDefinitionByName(qClassName) as Class;			
            registerClassAlias(qClassName, objectType);			
            var copier : ByteArray = new ByteArray();			
            copier.writeObject(object);			
            copier.position = 0;			
        	return copier.readObject();
		}
	}
}