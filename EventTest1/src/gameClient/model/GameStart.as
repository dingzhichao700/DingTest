package gameClient.model
{
	import flash.display.Sprite;
	
	import gameClient.manager.window.WindowManager;
	import gameClient.manager.window.WindowName;
	
	/**
	 * 游戏开始 
	 * @author ding
	 * 
	 */	
	public class GameStart
	{
		public function GameStart(stage:Sprite)
		{
			FirstEnterGame.initGame(stage);
			WindowManager.openWindow(WindowName.LOGIN_PANEL);
		}
	}
}