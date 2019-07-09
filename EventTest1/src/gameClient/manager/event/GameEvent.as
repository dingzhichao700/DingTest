package gameClient.manager.event
{
	public class GameEvent
	{
		private var _type:String;
		private var _data:Object;
		
		public function GameEvent(mType:String, mData:Object)
		{
			_type = mType;
			_data = mData;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}