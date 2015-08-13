package view
{
	import mx.controls.SWFLoader;
	import mx.managers.IFocusManagerComponent;
	
	public class AccSWFLoader extends SWFLoader implements IFocusManagerComponent
	{
		public function AccSWFLoader()
		{
			super();
			this.focusEnabled = true;
		}
	}
}