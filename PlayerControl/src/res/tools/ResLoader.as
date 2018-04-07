package res.tools
{
	import flash.display.Loader;

	/**
	 * 动作资源加载器 
	 * @author dingzhichao
	 * 
	 */	
	public class ResLoader extends Loader
	{
		/**角色*/		
		private var _chara:String;
		/**动作*/		
		private var _act:String;
		/**方向*/		
		private var _direction:String;
		/**序号*/		
		private var _num:String;
		
		public function ResLoader()
		{
		}
		
		/**角色*/	
		public function set chara(value:String):void {
			_chara = value;
		}
		public function get chara():String {
			return _chara;
		}
		
		/**动作*/	
		public function set act(value:String):void {
			_act = value;
		}
		public function get act():String {
			return _act;
		}
		
		/**方向*/	
		public function set direction(value:String):void {
			_direction = value;
		}
		public function get direction():String {
			return _direction;
		}
		
		/**序号*/	
		public function set num(value:String):void {
			_num = value;
		}
		public function get num():String {
			return _num;
		}
	}
}