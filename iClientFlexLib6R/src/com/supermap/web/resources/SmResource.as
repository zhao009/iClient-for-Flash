package com.supermap.web.resources
{	
	import mx.resources.ResourceManager;

	[ResourceBundle("SuperMapMessage")]
	/**
	 * ${resources_SmResource_Title}.
	 * <p>${resources_SmResource_Description}</p>
	 * 
	 */	
	public class SmResource
	{
		
		// TODO:其他错误类型逐渐补充进来  
		// 暂时只是在geometry里使用到" USE_SUBCLASS "错误类型
		
		import mx.resources.*;
		import mx.utils.StringUtil;
		
		/**
		 * ${resources_SmResource_attribute_SUPERMAP_MESSAGES_D} 
		 */		
		public static const SUPERMAP_MESSAGES:String = "SuperMapMessage";
		/**
		 * ${resources_SmResource_attribute_WIDTH_LESSTHAN_ZERO_D}
		 */
		public static const WIDTH_LESSTHAN_ZERO:String = "E0000E";
		/**
		 * ${resources_SmResource_attribute_HEIGHT_LESSTHAN_ZERO_D}
		 */
		public static const HEIGHT_LESSTHAN_ZERO:String = "E0001E";
		/**
		 * ${resources_SmResource_attribute_USE_SUBCLASS_D}
		 */
		public static const USE_SUBCLASS:String = "E0002E";
		/**
		 * 	${resources_SmResource_attribute_OUT_OF_ARRAY_RANGE_D}
		 */
		public static const OUT_OF_ARRAY_RANGE:String = "E0003E";
		/**
		 * ${resources_SmResource_attribute_PART_PART_LENGHT_LESSTHAN_TWO_D}
		 */
		public static const PART_LENGHT_LESSTHAN_TWO:String = "E0004E";
		/**
		 * ${resources_SmResource_attribute_PART_LENGHT_LESSTHAN_THREE_D}
		 */
		public static const PART_LENGHT_LESSTHAN_THREE:String = "E0005E";
		/**
		 * ${resources_SmResource_attribute_THEMERANGEITEM_START_END_D}
		 */
		public static const THEMERANGEITEM_START_END:String = "E0006E";
		/**
		* ${resources_SmResource_attribute_NONE_PARAMETERS_D}
		*/
		public static const NONE_PARAMETERS:String = "E0007E";
		/**
		 * ${resources_SmResource_attribute_NUMBER_LESSTHAN_OR_EQUAL_ZERO_D} 
		 */		
		public static const NUMBER_LESSTHAN_OR_EQUAL_ZERO:String = "E0008E";
		
		/**
		 * ${resources_SmResource_attribute_NUMBER_TO_XML_ERROR_D} 
		 */		
		public static const TO_XML_ERROR:String = "E0009E";
		/**
		 * ${resources_SmResource_attribute_CREAT_RECTANGLE2D_ERROR_D} 
		 */		
		public static const CREAT_RECTANGLE2D_ERROR:String = "E0010E";
		/**
		 * ${resources_SmResource_attribute_PARSE_CLOUDLAYER_RESULT_ERROR_D} 
		 */		
		public static const PARSE_CLOUDLAYER_RESULT_ERROR:String = "E0011E";
		/**
		 * ${resources_SmResource_attribute_WFST_EXECUTE_ERROR_D} 
		 */		
		public static const WFST_EXECUTE_ERROR:String = "E0012E";
		/**
		 * ${resources_SmResource_attribute_TYPENAME_IS_NULL_D} 
		 */		
		public static const TYPENAME_IS_NULL:String	= "E0013E";
		
	 
		/**
		 * ${resources_SmResource_attribute_ZOOM_LEVEL_D} 
		 */		
		public static const ZOOM_LEVEL:String = "S0009S";
		/**
		 * ${resources_SmResource_attribute_ZOOM_IN_D} 
		 */		
		public static const ZOOM_IN:String    = "S0010S";
		/**
		 * ${resources_SmResource_attribute_ZOOM_OUT_D} 
		 */		
		public static const ZOOM_OUT:String   = "S0011S";
	 
		/**
		 * ${resources_SmResource_attribute_TO_UP_D} 
		 */		
		public static const TO_UP:String 		= "S0012S";
		/**
		 * ${resources_SmResource_attribute_TO_DOWN_D} 
		 */		
		public static const TO_DOWN:String	= "S0013S";
		/**
		 * ${resources_SmResource_attribute_TO_LEFT_D} 
		 */		 
		public static const TO_LEFT:String	= "S0014S";
		/**
		 * ${resources_SmResource_attribute_TO_RIGHT_D} 
		 */		
		public static const TO_RIGHT:String	= "S0015S";
		
		//featuredatagrid 删除某条记录时弹出框的标题内容
		/**
		 * ${resources_SmResource_attribute_FD_DELETE} 
		 */		
		public static const FD_DELETE:String	= "S0016S";
		
		//timeslider
		/**
		 * ${resources_SmResource_attribute_TS_NEXT_D} 
		 */		
		public static const TS_NEXT:String	= "S0017S";
		/**
		 * ${resources_SmResource_attribute_TS_PLAY_D} 
		 */		
		public static const TS_PLAY:String	= "S0018S";
		/**
		 * ${resources_SmResource_attribute_TS_PREVIOUS_D} 
		 */		
		public static const TS_PREVIOUS:String	= "S0019S";
		/**
		 * ${resources_SmResource_attribute_TS_PAUSE_D} 
		 */		
		public static const TS_PAUSE:String	= "S0020S";
		
		//WFS
		/**
		 * ${resources_SmResource_attribute_RESULT_NULL_D} 
		 */		
		public static const RESULT_NULL:String	= "S0021S";
		
		/**
		 * ${resources_SmResource_attribute_VIEW_ENTIRE_D} 
		 */		
		public static const VIEW_ENTIRE:String	= "S0022S";
//		public static const WFST_RESULT_NULL:String	= "S0021S";
		/**
		 * ${resources_SmResource_method_formatMessage_D}.
		 * <p>${resources_SmResource_method_formatMessage_remarks}</p> 
		 * @param errorCode ${resources_SmResource_method_formatMessage_param_errorCode}
		 * @param args ${resources_SmResource_method_formatMessage_param_args}
		 * @return ${resources_SmResource_method_formatMessage_return}
		 * 
		 */		
		public static function formatMessage(errorCode:String, ...args) : String
		{
 			var str:String = ResourceManager.getInstance().getString(SmResource.SUPERMAP_MESSAGES, errorCode, args);
			return StringUtil.substitute("{0}: {1}", errorCode, str);
		}
	}
}