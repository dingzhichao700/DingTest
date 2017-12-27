package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.Style;

	[SWF(frameRate = "30", backgroundColor = "0xaaaaaa", width = 720, height = 480)]

	public class TailTest extends Sprite {

		private var res:Bitmap;
		private var DELAY:int = 1;
		private var CUT:int = 10;
		private var cutWidth:int;
		private var REFER_RATE:Number = 0.7;
		private var resX:int = 50;
		private var resY:int = 50;
		private var partList:Array;
		private var targetSp:Sprite;

		public function TailTest() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			init();
		}

		private function init():void {
			if(!ResourceManager.getInstance().hasRes("common")) {
				ResourceManager.getInstance().loadRes("common", init);
				return;
			}
			targetSp = new Sprite();
			this.addChild(targetSp);
			LoopManager.init();
			this.addEventListener(Event.ENTER_FRAME, onFrame);

			var resCon:Sprite = new Sprite();
			this.addChild(resCon);
			res = Style.getBitmap("tail", "", resCon, resX, resY);
			var bmd:BitmapData;
			cutWidth = res.width / CUT;
			var posArr:Array = [];
			partList = [];
			for(var i:int = 0; i < CUT; i++) {
				bmd = new BitmapData(cutWidth, res.height, true, 0);
				bmd.copyPixels(res.bitmapData, new Rectangle(cutWidth * i, 0, cutWidth, res.height), new Point());

				var pixelTop:int = 0;
				var pixelBottom:int = 0;
				var value:int = 0;
				for(var j:int = 0; j < bmd.height; j++) {
					value = bmd.getPixel32(bmd.width - 1, j);
					if(value != 0) {
						pixelTop = j;
						break;
					}
				}
				for(j; j < bmd.height; j++) {
					value = bmd.getPixel32(bmd.width - 1, j);
					if(value == 0) {
						pixelBottom = j;
						break;
					}
				}
				posArr.push([pixelTop, pixelBottom]);

				var part:TailPart = new TailPart();
				this.partList.push(part);
				var bmp:Bitmap = new Bitmap(bmd, "auto", true);
				bmp.y = -bmp.height / 2;
				part.addChild(bmp);

				if(i == 0) {
					part.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
					part.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
					part.addEventListener(MouseEvent.MOUSE_UP, onUp);
				}

				var radius:int = (pixelBottom - pixelTop) / 2;
				var round:Sprite = new Sprite();
				round.graphics.beginFill(0xff0000, 0.5);
				round.graphics.drawCircle(0, 0, radius);
				round.x = resX + cutWidth + (cutWidth) * i;
				round.y = resY + pixelTop + radius;
				this.addChild(round);
				res.mask = round;

				var copyBmd:BitmapData = new BitmapData(round.x + resCon.width, round.y + resCon.height, true, 0);
				copyBmd.draw(resCon, new Matrix(1, 0, 0, 1, -resX - (cutWidth) * i, -resY));
				var copyBmp:Bitmap = new Bitmap(copyBmd, "auto", true);
				copyBmp.y = -bmp.height / 2;
				part.addChild(copyBmp);
				round.graphics.clear();

				part.x = 50 + (cutWidth + 0) * i;
				part.y = 250 + (0) * i;
				this.addChildAt(part, 0);
			}
			res = null;
		}

		private function onFrame(e:Event):void {
			setLine();
		}

		private function setLine():void {
			targetSp.graphics.clear();
			targetSp.graphics.beginFill(0x00ff00);
			for(var i:int = 1; i < partList.length; i++) {
				/*定位点坐标，后一截定位到这个点*/
				var focusX:int = partList[i - 1].x + Math.cos(Sprite(partList[i - 1]).rotation * Math.PI / 180) * cutWidth;
				var focusY:int = partList[i - 1].y + Math.sin(Sprite(partList[i - 1]).rotation * Math.PI / 180) * cutWidth;
				/*参考点坐标，后一截朝向到这个点*/
				var referX:int = partList[i - 1].x + Math.cos(Sprite(partList[i - 1]).rotation * Math.PI / 180) * cutWidth * REFER_RATE;
				var referY:int = partList[i - 1].y + Math.sin(Sprite(partList[i - 1]).rotation * Math.PI / 180) * cutWidth * REFER_RATE;

//				targetSp.graphics.drawCircle(focusX, focusY, 5);
				var disX:Number = partList[i].x - focusX * REFER_RATE;
				var disY:Number = partList[i].y - focusY;
				var dis:Number = Math.sqrt(disX * disX + disY * disY);
				var radian:Number = Math.atan2(disY, disX);
				setPos(partList[i], focusX, focusY, radian * 180 / Math.PI);
//				LoopManager.doDelay(DELAY, setPos, [partList[i], focusX, focusY, radian * 180 / Math.PI]);
			}
		}

		private function setPos(part:TailPart, x:int, y:int, angle:Number = 0):void {
			part.x = x;
			part.y = y;
			part.rotation = angle;
		}

		private function onMove(e:MouseEvent):void {
//			setLine();
		}

		private function onDown(e:MouseEvent):void {
			TailPart(e.currentTarget).startDrag();
		}

		private function onUp(e:MouseEvent):void {
			TailPart(e.currentTarget).stopDrag();
		}
	}
}
