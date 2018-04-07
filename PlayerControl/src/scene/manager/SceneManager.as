package scene.manager {
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * 场景管理器
	 * @author dingzhichao
	 *
	 */
	public class SceneManager {

		/**游戏舞台*/
		private var gameStage:Sprite;
		/**整个游戏场景容器*/
		private var _gameContainer:Sprite;
		/**地图的容器*/
		private var gameMap:Sprite;
		/**场景元素数组*/
		private var containerArr:Array;
		/**地图宽度*/
		private var mapWidth:int = 1600;
		/**地图高度*/
		private var mapHeight:int = 1389;

		public function SceneManager() {
		}

		/**以某元素为中心定位整个场景*/
		public function locateScene(ele:DisplayObjectContainer):void {
			if (_gameContainer.contains(ele)) {
				var point:Point = _gameContainer.localToGlobal(new Point(ele.x, ele.y));
				var disX:Number = GameClient.Width / 2 - point.x;
				var disY:Number = GameClient.Height / 2 + 50 - point.y;
				/*判断地图出否跑出舞台*/
				if (_gameContainer.x + disX < GameClient.Width - mapWidth) {
					_gameContainer.x = GameClient.Width - mapWidth;
				} else if (_gameContainer.x + disX > 0) {
					_gameContainer.x = 0;
				} else {
					_gameContainer.x += disX;
				}
				if (_gameContainer.y + disY < GameClient.Height - mapHeight) {
					_gameContainer.y = GameClient.Height - mapHeight;
				} else if (_gameContainer.y + disY > 0) {
					_gameContainer.y = 0;
				} else {
					_gameContainer.y += disY;
				}
			}
		}

		/**获取舞台*/
		public function getStage(stage:Sprite):void {
			gameStage = stage;
			gameMap = new Sprite();
			containerArr = new Array();
			_gameContainer = new Sprite();
			_gameContainer.addChild(gameMap);
			gameStage.addChild(_gameContainer);
		}

		/**增加元素*/
		public function addElement(ele:DisplayObjectContainer):void {
			_gameContainer.addChild(ele);
			containerArr.push(ele);
			setDepth();
		}

		/**删除元素*/
		public function removeElement(ele:DisplayObjectContainer):void {
			if (_gameContainer.contains(ele)) {
				_gameContainer.removeChild(ele);
				containerArr.splice(ele);
			}
			setDepth();
		}

		/**设置地图*/
		public function setMap(map:Bitmap):void {
			gameMap.addChild(map);
			gameMap.setChildIndex(map, 0);
			containerArr.push(gameMap);
		}

		/**设置地图格子*/
		public function setGridMap(GridContainer:Sprite):void {
			gameMap.addChild(GridContainer);
		}

		/**设置元素深度*/
		public function setDepth():void {
			containerArr.sortOn("y", Array.NUMERIC);
			for (var i:int = 0; i < containerArr.length; i++) {
				_gameContainer.setChildIndex(containerArr[i], i);
			}
		}

		/**场景容器*/
		public function get gameContainer():Sprite {
			return _gameContainer;
		}
	}
}
