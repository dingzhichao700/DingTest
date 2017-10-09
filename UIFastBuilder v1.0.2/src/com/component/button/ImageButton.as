package utils.tools.component.button {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.event.EventUtils;
	import utils.tools.Style;

	/**
	 * 图片按钮
	 * @author dingzhichao
	 *
	 */
	public class ImageButton extends Button {
		
		private var container:Sprite;
		private var upPic:Bitmap;
		private var downPic:Bitmap;
		private var overPic:Bitmap;
		
		public function ImageButton(upUrl:String, downUrl:String, overUrl:String, res:String) {
			container = new Sprite();
			this.addChild(container);
			upPic = Style.getBitmap(upUrl, res, container);
			downPic = Style.getBitmap(downUrl, res, container);
			overPic = Style.getBitmap(overUrl, res, container);
			downPic.visible = false;
			overPic.visible = false;
			
			EventUtils.addEventListener(this, MouseEvent.MOUSE_UP, onClickHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_DOWN, onClickHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_OVER, onClickHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_OUT, onClickHandler);
		}
		
		/**按下或弹起*/
		private function onClickHandler(e:MouseEvent):void {
			if (!touchAble) {
				return;
			}
			switch (e.type) {
				case MouseEvent.MOUSE_OVER:
					overPic.visible = true;
					upPic.visible = false;
					downPic.visible = false;
					break;
				case MouseEvent.MOUSE_DOWN:
					overPic.visible = false;
					upPic.visible = false;
					downPic.visible = true;
					break;
				case MouseEvent.MOUSE_OUT:
				case MouseEvent.MOUSE_UP:
					upPic.visible = true;
					overPic.visible = false;
					downPic.visible = false;
					break;
			}
		}
	}
}
