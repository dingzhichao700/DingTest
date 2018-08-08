package {

	public class GameDataManager {
		
		public var cur_stage:int;
		/**当前是否已救出人质*/
		public var savaHost:Boolean;
		public var chance:int;
		
		private static var instance:GameDataManager;
		
		public static function getInstance():GameDataManager {
			instance ||= new GameDataManager();
			return instance;
		}
		
		public function GameDataManager() {
		}
		
		public function initData():void {
			cur_stage = 1;
			chance = 3;
		}
		
	}
}
