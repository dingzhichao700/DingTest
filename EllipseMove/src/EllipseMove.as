package {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[SWF(frameRate = "30")]
	public class EllipseMove extends Sprite {

		private var rectArr:Array;
		private const addSize:Number = 0.5;
		private const ELLIPSE_W:int = 200;
		private const ELLIPSE_H:int = 50;
		private const ELLIPSE_CENTER_X:int = 250;
		private const ELLIPSE_CENTER_Y:int = 200;
		private var rotateKey:Boolean;
		private var spLine:Sprite;

		public function EllipseMove() {

			rotateKey = true;
			rectArr = [];
			spLine = new Sprite();
			addChild(spLine);

			for (var i:int = 0; i < 8; i++) {
				var rect:Rect = new Rect();
				rect.angle = (i + 1) * 45;
				rect.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				rect.addEventListener(MouseEvent.MOUSE_OUT, onOut);
				addChild(rect);
				rectArr.push(rect);
			}

			addEventListener(Event.ENTER_FRAME, enterFrame);
		}

		private function enterFrame(evt:Event):void {
			if (!rotateKey) {
				return;
			}
			spLine.graphics.clear();
			for (var i:int = 0; i < rectArr.length; i++) {
				var an:Number = Rect(rectArr[i]).angle
				an = an + addSize > 360 ? an + addSize - 360 : an + addSize;
				Rect(rectArr[i]).angle = an;
				setPosByAngle(rectArr[i], Rect(rectArr[i]).angle);
			}
		}

		private function setPosByAngle(sp:DisplayObject, angle:int):void {
			sp.x = ELLIPSE_CENTER_X + ELLIPSE_W * Math.sin(angle / 180 * Math.PI);
			sp.y = ELLIPSE_CENTER_Y + ELLIPSE_H * Math.cos(angle / 180 * Math.PI);
			spLine.graphics.lineStyle(1, 0x000000);
			spLine.graphics.moveTo(ELLIPSE_CENTER_X, ELLIPSE_CENTER_Y);
			spLine.graphics.lineTo(sp.x, sp.y);
		}
		
		private function onOver(evt:MouseEvent):void {
			rotateKey = false;
		}
		
		private function onOut(evt:MouseEvent):void {
			rotateKey = true;
		}
	}
}

import flash.display.Sprite;
import flash.text.TextField;

class Rect extends Sprite {

	private var _angle:Number;
	private var txt:TextField;
	private var con:Sprite;
	private var rect:Sprite;

	function Rect() {
		con = new Sprite();
		addChild(con);

		rect = new Sprite;
		rect.graphics.beginFill(0xff0000);
		rect.graphics.drawRect(0, 0, 40, 40);
		con.addChild(rect);
		rect.x = -rect.width / 2;
		rect.y = -rect.height / 2;
		
		txt = new TextField();
//		con.addChild(txt);
	}

	/**角度*/
	public function get angle():Number {
		return _angle;
	}

	public function set angle(value:Number):void {
		_angle = value;
		var scale:Number = Math.pow(Math.abs(_angle / 360 - 0.5), 2) * 2;
		rect.alpha = 0.8 + scale;
		this.scaleX = this.scaleY = 0.5 + scale;
		this.rotationY = -_angle;
//		txt.htmlText = scale + "";
	}
}
