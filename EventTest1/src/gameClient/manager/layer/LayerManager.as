package gameClient.manager.layer
{
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import gameClient.manager.GameManager;

	/**
	 * 层级管理器 
	 * @author ding
	 * 
	 */	
	public class LayerManager
	{
		private static var _stage:Sprite;
		/**背景层*/
		public static var bgLayer:Sprite;
		/**窗口层*/
		public static var windowLayer:Sprite;
		/**UI层*/
		public static var uiLayer:Sprite;
		/**测试层*/
		public static var testLayer:Sprite;
		/**警告层*/
		public static var warningLayer:Sprite;
		
		public function LayerManager(container:Sprite)
		{
			_stage = container;
			GameManager.viewRect = new Rectangle(0, 0, _stage.stage.stageWidth, _stage.stage.stageHeight);
			
			bgLayer = new Sprite;
			windowLayer = new Sprite;
			uiLayer = new Sprite;
			testLayer = new Sprite;
			warningLayer = new Sprite;
			
			_stage.addChild(bgLayer);
			_stage.addChild(windowLayer);
			_stage.addChild(uiLayer);
			_stage.addChild(testLayer);
			_stage.addChild(warningLayer);
		}
		
		/**游戏舞台*/
		public static function get stage():Sprite{
			return _stage;
		}
	}
}