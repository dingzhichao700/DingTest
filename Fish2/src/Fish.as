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
	import utils.LoopManager;
	import utils.ResourceManager;
	import utils.SoundManager;
	import utils.Style;

	[SWF(width = 3192, height = 1080, backgroundColor = "0x000000", frameRate = "60")]
	public class Fish extends MovieClip {

		private var mainCon:Sprite;
		private var mainMask:Sprite;
		private var rippler:Rippler;

		/**贝壳容器*/
		private var beikeCon:Sprite;

		/**鱼容器*/
		private var fishCon:Sprite;
		private var fishArr:Array;
		private var qingtingArr:Array;

		/**装饰容器*/
		private var dressCon:Sprite;
		private var dressArr:Array;

		private const CONTEXT_W:int = 3192;
		private const CONTEXT_H:int = 1080;
		private const FISH_WIDE:int = 0;
		private const SHOCK_DIS:int = 200;
		private const QINGTING_CONFIG:Array = [[363, 462], [698, 363], [1686, 569], [1574, 226], [1073, 226], [1460, 466]];
		private const DRESS_CONFIG:Array = [[1768,574,1,0.63,-60],[190,844,1,0.72,144],[510,615,1,0.73,78],[1654,159,1,0.71,-3],[1564,455,1,0.64,-24],[2409,699,1,0.73,125],[930,687,1,0.63,88],[1473,911,1,0.74,59],[147,450,2,0.66,-151],[2355,924,2,0.8,-150],[1923,114,2,0.68,154],[2060,331,3,0.69,-99],[882,168,3,0.68,-49],[585,197,3,0.69,-1],[270,120,3,0.62,-1],[1310,580,3,0.75,-55],[1099,400,3,0.7,-164],[822,470,3,0.66,30],[902,951,3,0.62,45],[2360,324,4,0.77,69],[2765,948,4,0.74,-165],[1367,191,4,0.74,-143],[2741,191,4,0.71,71],[529,895,4,0.63,30],[2064,714,4,0.76,-120],[2709,566,4,0.64,-122],[2475,109,4,0.6,-7],[3025,594,4,0.76,164],[1888,317,5,0.13,-169],[467,462,5,0.15,81],[1812,808,5,0.14,66],[2602,955,5,0.17,51],[938,287,5,0.14,-98],[1084,671,5,0.19,-12],[723,813,5,0.14,112],[397,453,5,0.11,18],[518,315,5,0.14,95],[128,299,5,0.13,-16],[1768,690,5,0.12,95],[1423,453,5,0.12,4],[1361,719,5,0.13,20],[2187,967,5,0.15,-55],[1897,541,5,0.14,107],[1739,68,5,0.11,132],[434,53,5,0.18,79],[1715,285,5,0.14,101],[1292,297,5,0.17,-89],[1013,213,5,0.12,-67],[1639,635,5,0.16,-116],[605,417,5,0.12,-158],[128,48,5,0.13,136],[1227,277,5,0.16,-49],[584,21,5,0.15,24],[2172,219,5,0.16,159],[2266,596,5,0.13,-30],[2550,251,5,0.11,50],[821,340,5,0.13,107],[1515,230,5,0.15,143],[2026,545,5,0.17,103],[1942,866,5,0.19,-28],[751,216,5,0.18,106],[2205,604,5,0.11,-36],[2139,574,5,0.13,165],[2266,448,5,0.19,146],[941,478,5,0.16,-174],[38,695,5,0.1,32],[1007,791,5,0.18,-130],[1137,664,5,0.2,-177],[323,238,5,0.11,165],[84,584,5,0.17,91],[342,730,5,0.13,59],[342,730,5,0.1,-48],[1492,154,5,0.2,-158],[996,28,5,0.13,-27],[2227,664,5,0.18,124],[788,593,6,0.62,0],[717,328,6,0.65,0],[1603,297,6,0.61,0],[1498,734,6,0.62,0],[349,867,6,0.62,0],[1098,762,6,0.62,0],[1292,395,6,0.66,0],[2832,354,6,0.62,0],[1826,439,6,0.62,0],[307,420,6,0.62,0],[2321,148,6,0.62,0],[2217,768,6,0.62,0]];

//		private const DRESS_CONFIG:Array = [[341, 442, 1, 0.71, -61], [109, 860, 3, 0.71, -24], [298, 1045, 4, 0.72, -153], [118, 1383, 1, 0.66, -133], [111, 257, 3, 0.69, 95], [264, 1995, 5, 0.22, 1], [714, 626, 1, 0.68, -73], [678, 1573, 1, 0.78, 52], [893, 1835, 2, 0.79, 28], [915, 953, 1, 0.63, -69], [348, 1464, 1, 0.73, -11], [268, 1868, 3, 0.61, -138], [829, 266, 1, 0.73, -31], [224, 622, 3, 0.71, -142], [666, 2416, 4, 0.68, -86], [916, 2080, 4, 0.68, -31], [892, 1528, 1, 0.62, -158], [455, 723, 3, 0.64, 176], [720, 833, 3, 0.61, 17], [129, 1586, 2, 0.63, 35], [490, 217, 2, 0.79, 106], [855, 1212, 3, 0.73, 119], [461, 1154, 3, 0.62, 8], [892, 534, 4, 0.67, -111], [672, 2031, 4, 0.68, 81], [358, 2189, 4, 0.68, 15], [532, 1859, 4, 0.68, 25], [93, 2130, 4, 0.68, 0], [431, 2462, 4, 0.68, 96], [494, 400, 5, 0.31, -94], [91, 1168, 5, 0.21, 62], [334, 760, 5, 0.24, -179], [238, 932, 5, 0.29, 4], [735, 1049, 5, 0.32, 65], [684, 957, 5, 0.28, -79], [570, 452, 5, 0.34, -154], [460, 577, 5, 0.29, -9], [299, 128, 5, 0.3, -157], [690, 1768, 5, 0.36, -135], [453, 1423, 5, 0.2, 58], [719, 1361, 5, 0.39, -47], [725, 156, 5, 0.2, -153], [302, 320, 5, 0.2, -53], [68, 1739, 5, 0.2, 52], [53, 434, 5, 0.2, -92], [231, 1706, 5, 0.3, 132], [160, 1252, 5, 0.3, -96], [88, 974, 5, 0.2, -174], [581, 1697, 5, 0.2, 160], [508, 528, 5, 0.2, -119], [48, 128, 5, 0.2, 54], [277, 1227, 5, 0.2, 54], [21, 584, 5, 0.2, -118], [227, 2174, 5, 0.2, -136], [699, 1881, 5, 0.2, -21], [503, 2262, 5, 0.2, -69], [340, 821, 5, 0.2, -44], [289, 1644, 5, 0.2, -99], [738, 2163, 5, 0.2, -72], [802, 1991, 5, 0.2, 131], [216, 751, 5, 0.2, -127], [604, 2205, 5, 0.2, -156], [574, 2139, 5, 0.2, -115], [501, 2061, 5, 0.2, 95], [478, 941, 5, 0.2, 86], [695, 38, 5, 0.2, 25], [289, 235, 5, 0.2, 3], [664, 1137, 5, 0.2, 76], [238, 323, 5, 0.2, -135], [584, 84, 5, 0.2, 101], [713, 332, 5, 0.2, -151], [669, 415, 5, 0.35, -134], [201, 1486, 5, 0.35, -88], [28, 996, 5, 0.35, 99], [878, 2202, 5, 0.35, 168], [385, 936, 6, 0.66, -117], [144, 452, 6, 0.65, 90], [370, 1700, 6, 0.61, -100], [300, 1298, 6, 0.62, 92], [700, 1263, 6, 0.62, -89], [154, 1043, 6, 0.62, 104], [592, 905, 6, 0.62, 153], [246, 2065, 6, 0.62, -51], [669, 1778, 6, 0.62, -143], [644, 288, 6, 0.62, -153], [839, 647, 6, 0.62, -72], [633, 2211, 6, 0.62, -38]];

		public function Fish() {
			if (!checkEnabel()) {
				fscommand("quit", "true");
				return;
			}
			fscommand("fullscreen", "true");
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			SoundManager.getInstance().playSound("assets/soundBg.mp3", true, 0.3);
			init();
		}

		private function checkEnabel():Boolean {
			return true;
			var result:Boolean = true;
			var so:SharedObject = SharedObject.getLocal("fish_1", "/");
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

		private function init():void {
			if (!ResourceManager.getInstance().hasRes("common")) {
				ResourceManager.getInstance().loadRes("common", init)
				return;
			}

			mainCon = new Sprite(); //主容器
			addChild(mainCon);

			mainMask = new Sprite(); //主遮罩
			mainMask.graphics.beginFill(0xff0000, 0.1);
			mainMask.graphics.drawRect(0, mainCon.y, CONTEXT_W, CONTEXT_H);
			mainCon.addChild(mainMask);
			mainCon.mask = mainMask;

			var bg1:Bitmap = Style.getBitmap("bg1", "", mainCon);

			beikeCon = new Sprite(); //贝壳层
			beikeCon.alpha = 0.75;
			mainCon.addChild(beikeCon);

			fishCon = new Sprite(); //鱼层
			mainCon.addChild(fishCon);

			var bg2:Bitmap = Style.getBitmap("bg1", "", mainCon); //第二层背景，位于鱼层上面，装饰物层下面
			bg2.alpha = 0.2;

			dressCon = new Sprite(); //装饰物层
			mainCon.addChild(dressCon);

			addBeike();
			addFish();
			addDress();
			addQingting();

			rippler = new Rippler(bg1, 40, 5);

			//用setInterval延时的方法去执行添加水波纹的方法，若干毫秒执行一次这个方法
			setInterval(addRandomRappler, 50);

			//蛙鸣定时器
			onFrogSound();

			//流水声定时器
			LoopManager.getInstance().doDelay(7000, onWaterSound);

			addEventListener(Event.ENTER_FRAME, onFrame);
			mainCon.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onTrace); //输出坐标用
			Dispatcher.addListener(FishEvent.DRAW_RIPPLE, onRipplerHandler)

//			var mark:Bitmap = Style.getBitmap("watermark", "", this, 200, 100);
//			mark.alpha = 0.5;
		}

		/**定时蛙鸣一次*/
		private function onFrogSound():void {
			LoopManager.getInstance().doDelay(15000, onFrogSound);
			SoundManager.getInstance().playSound("assets/wamingBg.mp3", false, 0.03);
		}

		/**定时流水声一次*/
		private function onWaterSound():void {
			LoopManager.getInstance().doDelay(15000, onWaterSound);
			SoundManager.getInstance().playSound("assets/waterflow.mp3", false, 0.5);
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
				if (DRESS_CONFIG[i][2] == 6) {
					item = new HehuaItem(DRESS_CONFIG[i][2], DRESS_CONFIG[i][3], DRESS_CONFIG[i][4]);
				} else {
					item = new DressItem(DRESS_CONFIG[i][2], DRESS_CONFIG[i][3], DRESS_CONFIG[i][4]);
				}
				item.x = DRESS_CONFIG[i][0];
				item.y = DRESS_CONFIG[i][1];
//				item.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
//				item.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
				dressCon.addChild(item);
				dressArr.push(item);
			}
		}

		private function addBeike():void {
			for (var i:int = 0; i < 60; i++) {
				var targetX:int = 100 + Math.random() * (CONTEXT_W - 200);
				var targetY:int = 100 + Math.random() * (CONTEXT_H - 200);
				var img:Bitmap = ResourceManager.getInstance().getImage("assets/other/beike_" + (1 + int(Math.random() * 6)) + ".png", beikeCon, targetX, targetY);
				img.scaleX = img.scaleY = 0.35;
				img.rotation = Math.random() * 360;
			}
		}

		private function addQingting():void {
			qingtingArr = [];
			var item:QingtingItem;
			for (var i:int = 0; i < QINGTING_CONFIG.length; i++) {
				item = new QingtingItem();
				item.x = QINGTING_CONFIG[i][0];
				item.y = QINGTING_CONFIG[i][1];
//				item.addEventListener(MouseEvent.MOUSE_DOWN, onDrag);
//				item.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
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
					fish.speed += 20 + int(5 + Math.random() * 3);
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
