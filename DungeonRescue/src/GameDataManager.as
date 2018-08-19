package {

	public class GameDataManager {
		
		private var _stage:int;
		/**当前已救出人质数*/
		public var resCue:int;
		/**剩余机会*/
		public var chance:int;
		
		private static var instance:GameDataManager;
		
		public static function getInstance():GameDataManager {
			instance ||= new GameDataManager();
			return instance;
		}
		
		public function GameDataManager() {
		}
		
		/**重置数据*/
		public function initData():void {
			chance = 3;
		}
		
		/**设置关卡数据，人质救出数归零*/
		public function setStage(value:int):void {
			_stage = value;
			resCue = 0;
		}
		
		public function get curStage():int {
			return _stage;
		}
		
		public function checkPassMission():Boolean {
			if(curStage == 2 || curStage == 3){
				return resCue >= 1;
			}
			return true;
		}
		
	}
}
