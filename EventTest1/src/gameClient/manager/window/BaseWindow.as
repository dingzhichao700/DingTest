package gameClient.manager.window
{
	import flash.display.Sprite;
	
	import gameClient.manager.layer.LayerManager;

	/**
	 * 窗口基类 
	 * @author ding
	 * 
	 */	
	public class BaseWindow extends Sprite
	{
		private var _isOpen:Boolean;
		/**打开时传入的数据*/
		private var _openData:Object;
		/**窗口名*/
		private var _windowName:String;
		
		public function BaseWindow()
		{
		}
		
		/**打开*/
		protected function open():void{
//			trace("打开窗口：" + _windowName);
			/*子类复写*/
		}
		
		/**初始化窗口数据*/
		public function initWindowData(mWindowName:String, _data:Object = null):void {
			_windowName = mWindowName;
			_openData = _data;
			parentContainer.addChild(this);
			open();
		}
		
		/**关闭窗口，清除数据()*/
		public function clearWindowData():void{
			if(parentContainer.contains(this)){
				parentContainer.removeChild(this);
				close();
			}
		}
		
		/**关闭*/
		protected function close():void {
//			trace("关闭窗口：" + _windowName);
		}
		
		private function get parentContainer():Sprite {
			return LayerManager.windowLayer;
		}
		
		/**界面是否打卡*/
		public function get isOpen():Boolean { 
			return _isOpen;
		}
		
		/**窗口名*/
		public function get windowName():String { 
			return _windowName;
		}
		
		/**打开时传入的数据*/
		private function get openData():Object { 
			return _openData;
		}
		
		/**舞台宽度*/
		protected function get stageWidth():int {
			return parentContainer.stage.stageWidth;
		}
		
		/**舞台高度*/
		protected function get stageHeight():int {
			return parentContainer.stage.stageHeight;
		}
	}
}