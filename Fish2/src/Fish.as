package {
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.net.SharedObject;
	import flash.system.fscommand;
	import flash.utils.setInterval;
	
	import utils.Dispatcher;
	import utils.ResourceManager;
	import utils.SoundManager;
	import utils.Style;

	[SWF(width = 2048, height = 768, backgroundColor = "0x000000", frameRate = "20")]
	public class Fish extends MovieClip {

		private var mainCon:Sprite;
		private var mainMask:Sprite;
		private var rippler:Rippler;
		/**装饰容器*/
		private var dressCon:Sprite;
		private var dressArr:Array;

		/**鱼容器*/
		private var fishCon:Sprite;
		private var fishArr:Array;
		private var qingtingArr:Array;
		private const CONTEXT_W:int = 2048;
		private const CONTEXT_H:int = 768;
		private const FISH_WIDE:int = 0;
		private const SHOCK_DIS:int = 200;
		private const QINGTING_CONFIG:Array = [[363,462],[698,363],[1686,569],[1574,226],[1073,226],[1460,466]];
		private const DRESS_CONFIG:Array = [[1674,412,1,0.78,-142],[280,613,1,0.73,121],[459,243,1,0.71,76],[1379,64,1,0.66,84],[1448,306,1,0.73,143],[993,581,1,0.63,87],[605,545,1,0.68,77],[1526,650,1,0.62,33],[166,427,2,0.79,-133],[1927,615,2,0.79,-111],[1611,70,2,0.63,176],[1923,99,3,0.61,-108],[818,79,3,0.71,-18],[651,133,3,0.71,-16],[257,36,3,0.69,-62],[1310,580,3,0.73,143],[1099,400,3,0.62,112],[822,470,3,0.64,-93],[748,662,3,0.61,37],[2065,433,4,0.68,-119],[2416,666,4,0.68,-99],[1163,40,4,0.72,13],[2397,108,4,0.68,-54],[465,678,4,0.67,-7],[1852,267,4,0.68,40],[2292,304,4,0.68,-130],[2130,93,4,0.68,-172],[2462,431,4,0.68,-107],[1995,264,5,0.22,23],[467,462,5,0.31,-56],[1039,315,5,0.21,-167],[760,334,5,0.24,-46],[932,238,5,0.29,125],[1084,671,5,0.32,172],[891,691,5,0.28,-60],[290,476,5,0.34,-161],[582,244,5,0.29,80],[128,299,5,0.3,-134],[1768,690,5,0.36,17],[1423,453,5,0.2,-140],[1361,719,5,0.39,63],[156,725,5,0.2,-77],[278,162,5,0.2,-28],[1739,68,5,0.2,26],[434,53,5,0.2,99],[1706,231,5,0.3,-158],[1267,131,5,0.3,27],[974,88,5,0.2,107],[1639,635,5,0.2,-134],[605,417,5,0.2,60],[128,48,5,0.2,-99],[1227,277,5,0.2,125],[584,21,5,0.2,-24],[2172,219,5,0.2,54],[2266,596,5,0.2,4],[2279,693,5,0.2,125],[821,340,5,0.2,54],[1644,200,5,0.2,-11],[2123,677,5,0.2,-74],[2052,729,5,0.2,-167],[751,216,5,0.2,-19],[2205,604,5,0.2,-63],[2139,574,5,0.2,-45],[2266,448,5,0.2,-66],[941,478,5,0.2,128],[38,695,5,0.2,-36],[226,151,5,0.2,-4],[1137,664,5,0.2,101],[323,238,5,0.2,30],[84,584,5,0.2,-113],[342,730,5,0.2,-41],[342,730,5,0.35,-71],[1492,154,5,0.35,55],[996,28,5,0.35,-20],[2227,664,5,0.35,-142],[837,595,6,0.62,-67],[363,152,6,0.65,-164],[1738,155,6,0.61,-53],[1325,207,6,0.62,-162],[1247,595,6,0.62,29],[1093,82,6,0.62,-163],[909,349,6,0.66,80],[2107,202,6,0.62,78],[1840,525,6,0.62,-8],[249,500,6,0.62,-84],[2318,110,6,0.62,75],[2336,537,6,0.62,77]];
//		private const DRESS_CONFIG:Array = [[341, 442, 1, 0.71, -61], [109, 860, 3, 0.71, -24], [298, 1045, 4, 0.72, -153], [118, 1383, 1, 0.66, -133], [111, 257, 3, 0.69, 95], [264, 1995, 5, 0.22, 1], [714, 626, 1, 0.68, -73], [678, 1573, 1, 0.78, 52], [893, 1835, 2, 0.79, 28], [915, 953, 1, 0.63, -69], [348, 1464, 1, 0.73, -11], [268, 1868, 3, 0.61, -138], [829, 266, 1, 0.73, -31], [224, 622, 3, 0.71, -142], [666, 2416, 4, 0.68, -86], [916, 2080, 4, 0.68, -31], [892, 1528, 1, 0.62, -158], [455, 723, 3, 0.64, 176], [720, 833, 3, 0.61, 17], [129, 1586, 2, 0.63, 35], [490, 217, 2, 0.79, 106], [855, 1212, 3, 0.73, 119], [461, 1154, 3, 0.62, 8], [892, 534, 4, 0.67, -111], [672, 2031, 4, 0.68, 81], [358, 2189, 4, 0.68, 15], [532, 1859, 4, 0.68, 25], [93, 2130, 4, 0.68, 0], [431, 2462, 4, 0.68, 96], [494, 400, 5, 0.31, -94], [91, 1168, 5, 0.21, 62], [334, 760, 5, 0.24, -179], [238, 932, 5, 0.29, 4], [735, 1049, 5, 0.32, 65], [684, 957, 5, 0.28, -79], [570, 452, 5, 0.34, -154], [460, 577, 5, 0.29, -9], [299, 128, 5, 0.3, -157], [690, 1768, 5, 0.36, -135], [453, 1423, 5, 0.2, 58], [719, 1361, 5, 0.39, -47], [725, 156, 5, 0.2, -153], [302, 320, 5, 0.2, -53], [68, 1739, 5, 0.2, 52], [53, 434, 5, 0.2, -92], [231, 1706, 5, 0.3, 132], [160, 1252, 5, 0.3, -96], [88, 974, 5, 0.2, -174], [581, 1697, 5, 0.2, 160], [508, 528, 5, 0.2, -119], [48, 128, 5, 0.2, 54], [277, 1227, 5, 0.2, 54], [21, 584, 5, 0.2, -118], [227, 2174, 5, 0.2, -136], [699, 1881, 5, 0.2, -21], [503, 2262, 5, 0.2, -69], [340, 821, 5, 0.2, -44], [289, 1644, 5, 0.2, -99], [738, 2163, 5, 0.2, -72], [802, 1991, 5, 0.2, 131], [216, 751, 5, 0.2, -127], [604, 2205, 5, 0.2, -156], [574, 2139, 5, 0.2, -115], [501, 2061, 5, 0.2, 95], [478, 941, 5, 0.2, 86], [695, 38, 5, 0.2, 25], [289, 235, 5, 0.2, 3], [664, 1137, 5, 0.2, 76], [238, 323, 5, 0.2, -135], [584, 84, 5, 0.2, 101], [713, 332, 5, 0.2, -151], [669, 415, 5, 0.35, -134], [201, 1486, 5, 0.35, -88], [28, 996, 5, 0.35, 99], [878, 2202, 5, 0.35, 168], [385, 936, 6, 0.66, -117], [144, 452, 6, 0.65, 90], [370, 1700, 6, 0.61, -100], [300, 1298, 6, 0.62, 92], [700, 1263, 6, 0.62, -89], [154, 1043, 6, 0.62, 104], [592, 905, 6, 0.62, 153], [246, 2065, 6, 0.62, -51], [669, 1778, 6, 0.62, -143], [644, 288, 6, 0.62, -153], [839, 647, 6, 0.62, -72], [633, 2211, 6, 0.62, -38]];

		public function Fish() {
			if (!checkEnabel()) {
				fscommand("quit", "true");
				return;
			}
			fscommand("fullscreen", "true");
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			SoundManager.getInstance().playSound("assets/soundBg.mp3", true, 0.1);
			SoundManager.getInstance().playSound("assets/wamingBg.mp3", true, 0.05);
			init();
		}

		private function checkEnabel():Boolean {
			var result:Boolean = true;
			var so:SharedObject = SharedObject.getLocal("fish8", "/");
			var user:Object;
			if (so.data.user == null) {
				user = new Object();
				user.runtimes = 0;
			} else {
				user = so.data.user;
			}

			user.runtimes++;
			if (user.runtimes > 150) {
				result = false;
			}
			so.data.user = user;
			so.flush();
			return result;
		}

		//开始执行程序
		private function init():void {
			if (!ResourceManager.getInstance().hasRes("common")) {
				ResourceManager.getInstance().loadRes("common", init)
				return;
			}

			mainCon = new Sprite(); //主容器
			mainCon.x = (2048 - CONTEXT_W) / 2;
			mainCon.x = (768 - CONTEXT_H) / 2;
			addChild(mainCon);

			mainMask = new Sprite(); //主遮罩
			mainMask.graphics.beginFill(0xff0000, 0.1);
			mainMask.graphics.drawRect(0, mainCon.y, CONTEXT_W, CONTEXT_H);
			mainCon.addChild(mainMask);
//			mainCon.mask = mainMask;

			var bg1:Bitmap = Style.getBitmap("bg1", "", mainCon);

			fishCon = new Sprite(); //鱼层
			mainCon.addChild(fishCon);

			var bg2:Bitmap = Style.getBitmap("bg1", "", mainCon); //第二层背景，位于鱼层上面，装饰物层下面
			bg2.alpha = 0.2;

			dressCon = new Sprite(); //装饰物层
			mainCon.addChild(dressCon);

			addFish();
			addDress();
			addQingting();

			rippler = new Rippler(bg1, 40, 5);

			//用setInterval延时的方法去执行添加水波纹的方法，若干毫秒执行一次这个方法
			setInterval(addRandomRappler, 50);

			addEventListener(Event.ENTER_FRAME, onFrame);
			mainCon.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onTrace); //输出坐标用
			Dispatcher.addListener(FishEvent.DRAW_RIPPLE, onRipplerHandler)

//			Style.getBitmap("watermark", "", this, 200, 100);
		}

		private function onTrace(e:KeyboardEvent):void {
			var str:String = "";
			var temp:String = "";
			dressArr = dressArr.sortOn("type");
			for (var i:int = 0; i < dressArr.length; i++) {
				var dress:DressItem = dressArr[i];
				temp += "[" + int(dress.x) + "," + int(dress.y) + "," + dress.type + "," + dress.scale + "," + dress.rotate + "]" + (i != dressArr.length - 1 ? "," : "");
			}
			str += "dress: [" + temp + "]\n";
			
			temp = "";
			for (i = 0; i < qingtingArr.length; i++) {
				var qingting:QingtingItem = qingtingArr[i];
				temp += "[" + int(qingting.x) + "," + int(qingting.y) + "]" + (i != qingtingArr.length - 1 ? "," : "");
			}
			str += "qingting: [" + temp + "]";
			
			trace(str);
		}

		private function onSort(a:DressItem, b:DressItem):int {
			if (a.type < b.type) {
				return -1;
			} else if (a.type < b.type) {
				return 1;
			}
			return 0;
		}

		private function addDress():void {
			dressArr = [];
			var item:DressItem;
			for (var i:int = 0; i < DRESS_CONFIG.length; i++) {
				item = new DressItem(DRESS_CONFIG[i][2], DRESS_CONFIG[i][3], DRESS_CONFIG[i][4]);
				item.x = DRESS_CONFIG[i][0];
				item.y = DRESS_CONFIG[i][1];
//				item.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
//				item.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
				dressCon.addChild(item);
				dressArr.push(item);
			}
		}

		private function addQingting():void {
			qingtingArr = [];
			var item:QingtingItem;
			for (var i:int = 0; i < QINGTING_CONFIG.length; i++) {
				item = new QingtingItem();
				item.x = QINGTING_CONFIG[i][0];
				item.y = QINGTING_CONFIG[i][1];
				item.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
				item.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
				dressCon.addChild(item);
				qingtingArr.push(item);
			}
		}
		
		private function addFish():void {
			fishArr = [];
			for (var i:int = 0; i < 7; i++) {
				var num:int = 5;
				for (var j:int = 0; j < num; j++) {
					var fish:FishItem = new FishItem(i + 1, i < 7 ? 15 : 51);
					fish.scaleX = fish.scaleY = 0.4;
					fish.alpha = 0.9;
					fish.rotation = 360 * Math.random();
					fish.x = 100 + (CONTEXT_W - 100) * Math.random();
					fish.y = 100 + (CONTEXT_H - 100) * Math.random();
					fishCon.addChild(fish);
					fishArr.push(fish);
				}
			}
		}

		private function onDrag(e:MouseEvent):void {
			(e.currentTarget as Sprite).startDrag();
		}

		private function stopDrag(e:MouseEvent):void {
			(e.currentTarget as Sprite).stopDrag();
		}

		private function onFrame(e:Event):void {
			for (var i:int = 0; i < fishArr.length; i++) {
				var fish:FishItem = fishArr[i];
				if (fish.x < -FISH_WIDE || fish.x > CONTEXT_W + FISH_WIDE) { //出界移回
					fish.x = fish.x < -FISH_WIDE ? CONTEXT_W + FISH_WIDE : -FISH_WIDE;
					fish.recover();
				} else if (fish.y < -FISH_WIDE || fish.y > CONTEXT_H + FISH_WIDE) { //出界移回
					fish.y = fish.y < -FISH_WIDE ? CONTEXT_H + FISH_WIDE : -FISH_WIDE;
					fish.recover();
				} else { //按速度游动
					var an:Number = fish.rotation / 180 * Math.PI;
					fish.x += fish.speed * Math.cos(an);
					fish.y += fish.speed * Math.sin(an);
				}
			}
		}

		/**划动*/
		private function onMove(e:MouseEvent):void {
			var actMousePos:Point = mainCon.globalToLocal(new Point(mouseX, mouseY));
			var MouseX:int = actMousePos.x;
			var MouseY:int = actMousePos.y;
			drawRippler(mouseX, mouseY, 10);

			/*与每条鱼计算距离，太近的且未受惊的鱼"吓跑"*/
			for (var i:int = 0; i < fishArr.length; i++) {
				var fish:FishItem = fishArr[i];
				if (checkShockByDis(new Point(fish.x, fish.y), new Point(MouseX, MouseY)) && fish.shocked == 0) {
					fish.shocked = 1;
					var targetRotate:int = getAngle(new Point(MouseX, MouseY), new Point(fish.x, fish.y)) - 30 + 60 * Math.random();
					TweenLite.to(fish, 0.3, {rotation: targetRotate});
					fish.speed += 3 + int(5 + Math.random() * 3);
				}
			}

			for (var j:int = 0; j < dressArr.length; j++) {
				(dressArr[j] as DressItem).setCrab(new Point(MouseX, MouseY));
			}
		}

		private function getAngle(p1:Point, p2:Point):int {
			var xDis:int = p2.x - p1.x;
			var yDis:int = p2.y - p1.y;
			var angle:int = Math.atan2(yDis, xDis) * 180 / Math.PI;
			return angle;
		}

		/**通过距离计算是否受惊*/
		private function checkShockByDis(p1:Point, p2:Point):Boolean {
			var xDis:int = p1.x - p2.x;
			var yDis:int = p1.y - p2.y;

			if (Math.sqrt(xDis * xDis + yDis * yDis) <= SHOCK_DIS) {
				return true;
			}
			return false;
		}

		private function addRandomRappler():void {
			/*声明三个随机数，其数值分别是
			* x的坐标100到700之间的随机数xn
			* y坐标100到500之间的随机数yn
			* 水波纹范围10到20之间的随机数shuibo
			*/
			var xn:uint = Math.random() * CONTEXT_W;
			var yn:uint = Math.random() * CONTEXT_H;
			var shuibo:uint = Math.random() * 10 + 5;
			//括号里面的值是x、y坐标，水波纹的范围，透明度
			drawRippler(xn, yn, shuibo);
		}

		private function onRipplerHandler(pos:Point):void {
			var mainPos:Point = mainCon.globalToLocal(pos);
			drawRippler(mainPos.x, mainPos.y, 50);
		}
		
		/**
		 * 画水波
		 * @param rp 水波
		 * @param x
		 * @param y
		 * @param size
		 * @param alpha
		 */
		private function drawRippler(x:int, y:int, size:int, alpha:Number = 1):void {
			rippler.drawRipple(x, y, size, alpha);

			/*太近的装饰物“晃动”*/
			for (var i:int = 0; i < dressArr.length; i++) {
				var dress:DressItem = dressArr[i];
				if (checkShockByDis(new Point(dress.x, dress.y), new Point(x, y))) {
					dress.rockByPoint(new Point(x, y));
				}
			}
		}
		
	}
}