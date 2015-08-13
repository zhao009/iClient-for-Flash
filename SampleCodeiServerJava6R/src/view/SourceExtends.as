package view
{
	import mx.core.INavigatorContent;
	
	public class SourceExtends extends Source implements INavigatorContent
	{
		public function SourceExtends()
		{
			super();
		}
		
		override public function set source(file:String):void
		{ 
			fileName = file.substring(file.lastIndexOf("/")+1);
			//trace("sourceExtends:" + fileName);
			service01ID.url = file;
			service01ID.send(); 
		}

		public function get label():String
		{ 
			return fileName;
		}
		
		public function get icon():Class
		{
			return null;
		}
		
		public function get creationPolicy():String
		{
			return null;
		}
		
		public function set creationPolicy(value:String):void
		{
		}
		
		public function createDeferredContent():void
		{
		}
		
		public function get deferredContentCreated():Boolean
		{
			return false;
		}
	}
} 