package com.supermap.components
{
	import flash.events.Event;
	
	import mx.core.ClassFactory;
	import mx.events.FlexEvent;
	
	import spark.components.SkinnableContainer;
	
	[Exclude(name="backgroundColor", kind="style")]
	[Exclude(name="backgroundAlpha", kind="style")]
	
	//边框透明度
	[Style(name="borderAlpha", type="Number", inherit="no")]
	//边框看颜色
	[Style(name="borderColor", type="uint", format="Color", inherit="no")]
	//边框可见
	[Style(name="borderVisible", type="Boolean", inherit="no")]
	
	//边框线宽
	[Style(name="borderWeight", type="Number", format="Length", inherit="no")]
	
	//圆角等属性
	[Style(name="topLeftRadius", type="int",  inherit="no")]
	[Style(name="topRightRadius", type="int",  inherit="no")]
	[Style(name="bottomLeftRadius", type="int",  inherit="no")]
	[Style(name="bottomRightRadius", type="int",  inherit="no")]
	
	/**
	 * 其他四个边角属性会覆盖该属性
	 * */
	[Style(name="cornorRadius", type="int",  inherit="no")]
	
	[Style(name="firstBackColor", type="uint", format="Color", inherit="no")]
	[Style(name="secondBackColor", type="uint", format="Color", inherit="no")]
	[Style(name="firstBackAlpha", type="Number", inherit="no")]
	[Style(name="secondBackAlpha",type="Number", inherit="no")]
	
	/**
	 * 继承skinnableContainer,使用默认的皮肤来实现对边框等样式的填充和修改
	 * */
	public class StyledSkinnableContainer extends SkinnableContainer
	{
		
		public function StyledSkinnableContainer()
		{
			super();
		}
	}
}