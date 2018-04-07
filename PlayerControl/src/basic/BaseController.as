package basic
{
	import event.GameEvent;

	/**
	 * 控制器基类
	 * @author dingzhichao
	 * 
	 */	
	public class BaseController
	{
		public function BaseController()
		{
		}
		
		/**注册消息*/		
		public function registMsg():void {
			/*子类复写*/
		}
		
		/**事件处理*/		
		protected function viewHandler(e:GameEvent):void {
			/*子类复写*/
		}
	}
}