package utils.display.button
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	import utils.event.EventUtils;
	import utils.tools.TextTools;
	import utils.tools.UITools;
	
	/**
	 * 一般按钮 
	 * @author ding
	 * 
	 */	
	public class GameButton extends BaseButton
	{
		private var buttonContainer:Sprite;
		private var upPic:Sprite;
		private var downPic:Bitmap;
		private var colorLevel:int;
		private var filterArr:Array;
		
		public function GameButton(_color:int, _label:String, _width:int = 40, _height:int = 40, _colorLevel:int = 5, labelSize:int = 18)
		{
			buttonContainer = new Sprite();
			colorLevel = _colorLevel;
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0x381E0D);
			bg.graphics.drawRect(0, 0, _width,_height);
			bg.graphics.endFill();
			buttonContainer.addChild(bg);
			
			/**横向边距*/
			var sideWidth:int = 4;
			/**纵向边距*/
			var sideHeight:int = 4;
			/**宽度*/
			var resterWidth:int = _width - sideWidth*2;
			/**高度*/
			var resterHeight:int = _height - sideWidth*2;
			/**色比例跨度(减少7成后颜色较暗)*/
			var interval:Number = 0.65/colorLevel;
			
			upPic = UITools.createResterRect(_color, resterWidth, resterHeight, colorLevel, interval);
			upPic.x = sideWidth;
			upPic.y = sideHeight;
			buttonContainer.addChild(upPic);
			
			var data:BitmapData = new BitmapData(upPic.width, upPic.height);
			data.draw(upPic);
			downPic = new Bitmap(data);
			downPic.scaleY = -1;
			downPic.x = sideWidth;
			downPic.y = sideHeight + downPic.height;
			downPic.alpha = 0.7;
			downPic.visible = false;
			buttonContainer.addChild(downPic);
			
			var filter:GlowFilter = new GlowFilter(_color, 1, upPic.width/2, upPic.height/2, 1, 12, true);
			filterArr = new Array();
			filterArr.push(filter);
			
			var label:TextField = TextTools.createTxt(_label, 0, 0, _width, _height, 0x000000, labelSize, 2);
			label.x = bg.width - label.width >> 1;
			label.y = bg.height - label.height >> 1;
			label.mouseEnabled = false;
			buttonContainer.addChild(label);
			addChild(buttonContainer);
			
			EventUtils.addEventListener(this, MouseEvent.MOUSE_DOWN, onClickHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_OUT, onClickHandler);
			EventUtils.addEventListener(this, MouseEvent.MOUSE_UP, onClickHandler);
		}
		
		/**按下或弹起*/
		private function onClickHandler(e:MouseEvent):void {
			if(!touchAble){
				return;
			}
			switch(e.type) {
				case MouseEvent.MOUSE_OVER:
					break;
				case MouseEvent.MOUSE_OUT:
					downPic.visible = false;
					break;
				case MouseEvent.MOUSE_DOWN:
					downPic.visible = true;
					break;
				case MouseEvent.MOUSE_UP:
					downPic.visible = false;
					break;
			}
		}
	}
}