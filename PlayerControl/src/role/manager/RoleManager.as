package role.manager {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import pathing.PathingFacade;
	
	import role.RoleFacade;
	import role.util.RoleUtils;
	import role.view.RoleBase;
	import role.vo.RoleVo;
	
	import scene.SceneFacade;

	/**
	 * 角色管理
	 * @author dingzhichao
	 *
	 */
	public class RoleManager extends Sprite {

		public var mainRole:RoleBase;
		/**场景中角色列表*/
		private var roleList:Array;
		private var count:int;
		/**动画播放的帧率(每几帧播放一个下个动作)*/
		private static const ANIME_FRAME:uint = 3;

		public function RoleManager() {
		}

		public function init():void {
			roleList = new Array();
			this.addEventListener(Event.ENTER_FRAME, frameHandler);
			initPlayer();
		}
		
		/**初始化角色*/
		private function initPlayer():void {
			mainRole = new RoleBase("woman");
			mainRole.x = 800;
			mainRole.y = 800;
			RoleFacade.manager.addRole(mainRole);
			for (var i:int = 0; i < 10; i++) {
				var enemy:RoleBase = new RoleBase("man");
				enemy.vo.direction = Math.floor(Math.random() * 8);
				enemy.x = 350 + 900 * Math.random();
				enemy.y = 600 + 400 * Math.random();
				RoleFacade.manager.addRole(enemy);
			}
		}

		/**帧频*/
		private function frameHandler(e:Event):void {
			count++;
			if (count >= ANIME_FRAME) {
				count = 0;
			}
			for (var i:int in roleList) {
				RoleUtils.orientateRole(roleList[i]);
				RoleBase(roleList[i]).onFrame();
				if (count == 0) {
					RoleBase(roleList[i]).playAnime();
				}
			}
			
			/*定位场景*/
			SceneFacade.manager.locateScene(RoleFacade.manager.mainRole);
		}

		/**增加角色*/
		public function addRole(role:RoleBase):void {
			roleList.push(role);
			SceneFacade.manager.addElement(role);
		}

		/**移除角色*/
		public function removeRole(role:RoleBase):void {
			for (var i:int = 0; i < roleList.length; i++) {
				if (RoleBase(roleList[i]) == role) {
					roleList.splice(i, 1);
					SceneFacade.manager.removeElement(role);
					role = null;
				}
			}
		}
		
		public function moveRole(endPos:Point, role1:RoleBase):void {
			PathingFacade.manager.searchPath(role1.vo.position, endPos, role1);
		}
		
		/**使某角色按节点数组开始移动*/
		public function moveByRoute(vo:RoleVo):void {
			for (var i:int in roleList) {
				if (RoleBase(roleList[i]).vo == vo) {
					if (RoleBase(roleList[i]).vo.routeArr.length == 0) {
						return;
					}
					RoleBase(roleList[i]).vo.target = PathingFacade.manager.getPointByGrid(RoleBase(roleList[i]).vo.routeArr[0]);
					RoleBase(roleList[i]).vo.routeArr.shift();
				}
			}
		}
	}
}
