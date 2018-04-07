package {
	import handle.HandleFacade;
	
	import map.MapFacade;
	
	import pathing.PathingFacade;
	
	import res.ResFacade;
	
	import role.RoleFacade;
	
	import scene.SceneFacade;

	/**
	 * 游戏模块初始化入口
	 * @author dingzhichao
	 *
	 */
	public class FirstEnterGame {
		
		public static function init():void {
			/*场景*/
			SceneFacade.init();
			/*地图*/
			MapFacade.init();
			/*资源*/
			ResFacade.init();
			/*角色*/
			RoleFacade.init();
			/*控制器*/
			HandleFacade.init();
			/*寻路*/
			PathingFacade.init();
		}
	}
}
