package utils.display.sprite
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import utils.event.EventUtils;

	public class GSprite extends Sprite
	{
		private var eventDic:Dictionary;
		
		public function GSprite()
		{
		}
		
		/**X注册点*/
		public function pivotX(value:int):void {
			this.x -= value;
		}
		
		/**Y注册点*/
		public function set pivotY(value:int):void {
			this.y -= value;
		}
		
		/**移除所有子对象*/
		public function removeAllChildren():void{
			
		}
		
		/**从父容器中移除*/
		public function removeFromParent():void{
			if(this.parent){
				this.parent.removeChild(this);
				this.dispose();
			}
		}
		
		/**销毁*/
		public function dispose():void {
			while(this.numChildren){
				var sprite:DisplayObject = this.getChildAt(0);
				if(sprite is GSprite){
					GSprite(sprite).dispose();
				}
				this.removeChild(sprite);
				sprite = null;
			}
			EventUtils.removeTargetAllEventListener(this);
		}
	}
}