package gameClient.baseData
{
	public class PlayerVo
	{
		/**序号*/
		private var _index:int;
		/**玩家名字*/
		private var _name:String;
		
		public function PlayerVo()
		{
		}
		
		/**序号*/
		public function set index(value:int):void {
			_index = value;
		}
		public function get index():int {
			return _index;
		}
		/**玩家名字*/
		public function set name(value:String):void {
			_name = value;
		}
		public function get name():String {
			return _name;
		}
	}
}