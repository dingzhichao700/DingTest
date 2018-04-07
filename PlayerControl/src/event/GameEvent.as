package event {

	/**
	 * 自定义消息
	 * @author dingzhichao
	 *
	 */
	public class GameEvent {

		/**消息*/
		private var _type:String;
		/**附加数据*/
		private var _data:*;

		public function GameEvent(mType:String, mData:* = null) {
			_type = mType;
			_data = mData;
		}

		/**消息*/
		public function get type():String {
			return _type;
		}

		/**附加数据*/
		public function get data():* {
			return _data;
		}
	}
}