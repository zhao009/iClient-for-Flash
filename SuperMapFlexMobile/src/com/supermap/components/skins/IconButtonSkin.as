package com.supermap.components.skins
{
	import com.supermap.components.IconButton;

	import spark.skins.mobile.ButtonSkin;

	public class IconButtonSkin extends ButtonSkin
	{
		private var _iconButton:IconButton;

		public function IconButtonSkin()
		{
			super();
			this.width = 43;
			this.height = 31;
		}

		override protected function getBorderClassForCurrentState():Class
		{
			if(!_iconButton)
			{
				_iconButton = this.parent as IconButton;
			}

			if(currentState == "down")
				return _iconButton.down;
			else
				return _iconButton.up;
		}
	}
}
