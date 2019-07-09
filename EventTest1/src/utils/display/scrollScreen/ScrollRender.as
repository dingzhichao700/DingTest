package utils.display.scrollScreen
{
	import utils.display.sprite.GSprite;

	/**
	 * 拖曳视图子组件 
	 * @author ding
	 * 
	 */	
	public class ScrollRender extends GSprite
	{
		private var _dataSource:Object;
		
		public function ScrollRender()
		{
		}
		
		/**设置数据*/
		public function set dataSource(arr:Object):void {
			_dataSource = arr;
		}
		
		/**创建*/
		public function create():void{
			/*子类复写*/
		}
		
		/**刷新*/
		public function update():void{
			/*子类复写*/	
		}
		
		/**宽度*/
		override public function get width():Number {
			return 100;
		}
		
		/**高度*/
		override public function get height():Number {
			return 30;
		}
	}
}