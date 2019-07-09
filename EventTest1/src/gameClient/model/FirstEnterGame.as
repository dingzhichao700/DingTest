package gameClient.model
{
	import flash.display.Sprite;
	
	import gameClient.manager.keyBoard.KeyBoardManager;
	import gameClient.manager.layer.LayerManager;
	import gameClient.manager.window.RegistWindow;

	/**
	 * 游戏初始化 
	 * @author ding
	 * 
	 */	
	public class FirstEnterGame
	{
		public function FirstEnterGame()
		{
		}
		
		/**初始化游戏基本资源*/
		public static function initGame(stage:Sprite):void{
			RegistWindow.regist();
			new LayerManager(stage);
			FacadeInit();
			KeyBoardManager.init(stage.stage);
			var test:TestArea = new TestArea();
		}
		
		private static function FacadeInit():void {
			
		}
	}
}