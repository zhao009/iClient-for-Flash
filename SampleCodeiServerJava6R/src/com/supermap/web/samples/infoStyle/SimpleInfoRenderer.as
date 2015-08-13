package com.supermap.web.samples.infoStyle
{
	import mx.controls.Image;
	import mx.controls.Text;
	import mx.core.IFactory;
	import mx.core.UIComponent;
	
	import spark.components.BorderContainer;
	import spark.components.HGroup;

	public class SimpleInfoRenderer extends UIComponent implements IFactory
	{
		private var img:Image;
		private var txt:Text;
		
		public function SimpleInfoRenderer(imgSource:String, textContent:String)
		{
			super();
			var hGroup:HGroup = new HGroup();
			hGroup.gap = 5;
			hGroup.width = 250;
			hGroup.height = 80;
			img = new Image;
			img.width = 100;
			img.height = 75;
			img.source = imgSource;
			txt = new Text;
			txt.text = textContent;
			txt.width = 150;
			txt.percentHeight = 100;
			hGroup.addElement(img);
			hGroup.addElement(txt);
			this.addChild(hGroup);
			this.width = 250;//必设
			this.height = 80;//必设
		}
		
		public function newInstance():* {
			return new SimpleInfoRenderer(img.source as String,txt.text);
		}
	}
}