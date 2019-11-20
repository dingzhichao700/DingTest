package utils.event
{
	import flash.events.Event;

	public class ButtonEvent extends Event
	{
		/**按钮点击*/
		public static const CLICK:String = "mouse_click";	
		/**按钮按下*/
		public static const MOUSE_DOWN:String = "mouse_down";	
		/**按钮弹起*/
		public static const MOUSE_UP:String = "mouse_up";	
		/**按钮划过*/
		public static const MOUSE_OVER:String = "mouse_over";	
		
		public function ButtonEvent(_event:String) {
			super(_event);
		}
	}
}