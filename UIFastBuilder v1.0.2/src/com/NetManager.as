package com {
	import flash.display.Sprite;
	import flash.geom.Point;

	import spark.components.Group;
	import spark.core.SpriteVisualElement;

	/**
	 * 网格管理
	 * @author dingzhichao
	 *
	 */
	public class NetManager {

		private var show:Boolean;
		private var editSprite:SpriteVisualElement;
		private var mapWidth:int;
		private var mapHeight:int;
		/**网点边长数量（不是网格总数）*/
		public var tileNum:int
		/**X偏移*/
		public var overX:int;
		/**Y偏移*/
		public var overY:int;
		/**网点横向半径*/
		private const TILE_SIZE:int = 44;
		private static var _instance:NetManager;

		public static function getInstance():NetManager {
			_instance ||= new NetManager();
			return _instance;
		}

		public function NetManager() {
		}

		public function initLayer(group:Group):void {
			editSprite = new SpriteVisualElement();
			group.addElement(editSprite);
		}

		/**设置地图参数*/
		public function setMapParameter(width:int, height:int):void {
			mapWidth = width;
			mapHeight = height;
			/**地图的斜向投影长度*/
			var shadowLength:int = mapWidth + mapHeight * 2;
			tileNum = Math.ceil(shadowLength / (TILE_SIZE * 2));
			overX = mapWidth / 2;
			overY = mapHeight / 2 - (tileNum * TILE_SIZE / 2);
			overX -= overX % 44;
			overY -= overY % 22;
			editSprite.x = overX;
			editSprite.y = overY;
		}

		/**绘制编辑用网格*/
		public function drawEditTile(point:Point):void {
			editSprite.graphics.clear();
			var tilePoint:Point = getCloseTile(point)
			if (!tilePoint) {
				return;
			}
			var p:Point = getFlatCenterByXY(tilePoint.x, tilePoint.y);
			if (p) {
				editSprite.graphics.lineStyle(1, 0x000000);
				editSprite.graphics.beginFill(0x00ffff, 0.7);
				editSprite.graphics.moveTo(p.x, p.y - 22);
				editSprite.graphics.lineTo(p.x + 44, p.y);
				editSprite.graphics.lineTo(p.x, p.y + 22);
				editSprite.graphics.lineTo(p.x - 44, p.y);
				editSprite.graphics.lineTo(p.x, p.y - 22);
			}
		}

		/**清除编辑网格*/
		public function clearEdit():void {
			editSprite.graphics.clear();
		}

		/**距离最近的网格坐标点*/
		public function getCloseTile(point:Point):Point {
			for (var i:int = 0; i < tileNum; i++) {
				for (var j:int = 0; j < tileNum; j++) {
					var tilePoint:Point = getFlatCenterByXY(i, j);
					tilePoint.x += overX;
					tilePoint.y += overY;
					if (checkDistance(point, tilePoint)) {
						return new Point(i, j);
					}
				}
			}
			return null;
		}

		/**检查两点距离是否小于半个TILE_SIZE*/
		private function checkDistance(pointA:Point, pointB:Point):Boolean {
			var dis:int = Math.sqrt(Math.pow(Math.abs(pointA.x - pointB.x), 2) + Math.pow(Math.abs(pointA.y - pointB.y), 2));
			if (dis <= (TILE_SIZE / 2 + 3)) {
				return true;
			}
			return false;
		}

		/**检查网点坐标是否在图像范围内*/
		private function checkPoint(p:Point):Boolean {
			var point:Point = new Point(p.x + overX, p.y + overY);
			if (point.x < 0 || point.x > mapWidth || point.y < 0 || point.y > mapHeight) {
				return false;
			}
			return true;
		}

		/**通过网格坐标获取实际位置*/
		public function getFlatCenterByXY(tx:int, ty:int):Point {
			var p:Point = indexToFlat2(tx, ty);
			return new Point(p.x, p.y + TILE_SIZE / 2);
		}

		/**检查网格是否存在*/
		public function isPosExsit(pos:Point):Boolean {
			if (0 <= pos.x && pos.x <= tileNum && 0 <= pos.y && pos.y <= tileNum) {
				return true;
			}
			return false;
		}

		private function indexToFlat2(tx:int, ty:int):Point {
			var x:Number = tx - ty;
			var y:Number = (tx + ty) * .5;
			return new Point(x * TILE_SIZE, y * TILE_SIZE)
		}
	}
}
