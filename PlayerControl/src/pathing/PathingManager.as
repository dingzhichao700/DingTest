package pathing {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import event.GameBus;
	
	import map.MapFacade;
	
	import role.view.RoleBase;
	
	import scene.SceneFacade;

	/**
	 * 寻路管理
	 * @author dingzhichao
	 *
	 */
	public class PathingManager {

		/**地图节点大小*/
		public static const GRID_SIZE:int = 40;

		/**节点数组*/
		private var _gridList:Dictionary;

		/**地图宽度*/
		private var mapWidth:int;
		/**地图高度*/
		private var mapHeight:int;

		/**横向节点数*/
		private var horizonNum:int
		/**纵向节点数*/
		private var verticalNum:int

		/**舞台*/
		private var gameStage:Sprite;
		/**容器*/
		private var container:Sprite;
		/**寻路容器*/
		private var gridContainer:Sprite;

		/**网格图片*/
		private var netImage:Bitmap;
		/**节点图片*/
		private var gridImage:Bitmap;
		/**移动区域图片*/
		private var areaImage:Bitmap;
		/**路径图片*/
		private var routeImage:Bitmap;

		/**绘图Shape*/
		private var shape:Shape;

		public function PathingManager() {
		}

		/**初始化节点地图*/
		public function initGridMap():void {
			mapWidth = MapFacade.dataManager.mapWidth;
			mapHeight = MapFacade.dataManager.mapHeight;
			horizonNum = mapWidth / GRID_SIZE + 1;
			verticalNum = mapHeight / GRID_SIZE + 1;
			shape = new Shape();

			drawPassArea();
			drawGridArea();
			drawNetArea();

			addToScene();
		}

		/**绘制矢量化的移动区域*/
		private function drawPassArea():void {
			/*先画矢量区*/
			shape.graphics.beginFill(0xFF0000, 0.3);
			for (var l:int = 0; l < MapFacade.dataManager.zoneArr.length; l++) {
				if (l == 0) {
					shape.graphics.moveTo(MapFacade.dataManager.zoneArr[l].x, MapFacade.dataManager.zoneArr[l].y);
				}
				shape.graphics.lineTo(MapFacade.dataManager.zoneArr[l].x, MapFacade.dataManager.zoneArr[l].y);
			}
			areaImage = getImageByShape(shape);
			gameStage.addChild(shape);

			/*点碰撞判断，保存节点信息*/
			_gridList = new Dictionary();
			for (var m:int = 0; m < horizonNum; m++) {
				for (var n:int = 0; n < verticalNum; n++) {
					var hitBoo:Boolean;
					if (shape.hitTestPoint(GRID_SIZE * m, GRID_SIZE * n, true)) {
						hitBoo = true;
					} else if (shape.hitTestPoint(GRID_SIZE * (m + 1), GRID_SIZE * n, true)) {
						hitBoo = true;
					} else if (shape.hitTestPoint(GRID_SIZE * m, GRID_SIZE * (n + 1), true)) {
						hitBoo = true;
					} else if (shape.hitTestPoint(GRID_SIZE * (m + 1), GRID_SIZE * (n + 1), true)) {
						hitBoo = true;
					} else {
						hitBoo = false;
					}
					var grid:Grid = new Grid(m, n, hitBoo);
					_gridList[m + "_" + n] = grid;
				}
			}
			/*检测完毕，从舞台移除，并清除绘制*/
			gameStage.removeChild(shape);
			shape.graphics.clear();
		}

		/**绘制节点化的移动区域*/
		private function drawGridArea():void {
			for (var q:int = 0; q < horizonNum; q++) {
				for (var p:int = 0; p < verticalNum; p++) {
					var targetGrid:Grid = Grid(_gridList[q + "_" + p]);
					if (targetGrid.passAble) {
						fillGridBox(targetGrid.horiNum, targetGrid.vertNum);
					}
				}
			}
			gridImage = getImageByShape(shape);
			shape.graphics.clear();
		}

		/**绘制网格*/
		private function drawNetArea():void {
			shape.graphics.lineStyle(1, 0x000000, 0.25);
			for (var i:int = 0; i < horizonNum; i++) {
				shape.graphics.moveTo(GRID_SIZE * i, 0);
				shape.graphics.lineTo(GRID_SIZE * i, mapHeight);
			}
			for (var j:int = 0; j < verticalNum; j++) {
				shape.graphics.moveTo(0, GRID_SIZE * j);
				shape.graphics.lineTo(mapWidth, GRID_SIZE * j);
			}
			netImage = getImageByShape(shape);
			shape.graphics.clear();
		}

		/**添加到主场景*/
		private function addToScene():void {
			gridContainer = new Sprite();
			gridContainer.addChild(gridImage);

			areaImage.visible = false;
			gridContainer.visible = false;
			netImage.visible = false;

			container = new Sprite();
			container.addChild(areaImage);
			container.addChild(gridContainer);
			container.addChild(netImage);
			SceneFacade.manager.setGridMap(container);
		}

		/**
		 * 寻找路径, 并将路径节点传给需要移动的角色
		 * @param start 出发点
		 * @param end	终点
		 * @param role	角色
		 */
		public function searchPath(start:Point, end:Point, role:RoleBase):void {
			var startGrid:Grid = getGridByPoint(start);
			var endGrid:Grid = getGridByPoint(end);
			/*终点在障碍区*/
			if (!endGrid.passAble) {
				return;
			}
			/*起点终点相同*/
			if (startGrid.equalTo(endGrid)) {
				return;
			}
			/*重复向当前终点寻路*/
			if (PathingCalculate.getInstance().endGrid && endGrid.equalTo(PathingCalculate.getInstance().endGrid)) {
				return;
			}
			var pathArr:Array = PathingCalculate.getInstance().getPath(startGrid, endGrid);
			role.vo.routeArr = pathArr;

			/*绘制路径*/
			shape.graphics.clear();
			if (routeImage && gridContainer.contains(routeImage)) {
				gridContainer.removeChild(routeImage);
			}
			for (var i:int = 0; i < pathArr.length; i++) {
				fillGridBox(Grid(pathArr[i]).horiNum, Grid(pathArr[i]).vertNum, 0x0000FF);
			}
			routeImage = getImageByShape(shape);
			gridContainer.addChild(routeImage);
			/*绘制好路径图，再抛出消息*/
			GameBus.sendMsg(PathingMsg.PATH_FIGURE_OUT, role.vo);
		}

		/**通过坐标点获取对应节点*/
		private function getGridByPoint(point:Point):Grid {
			var hori:int = Math.floor(point.x / GRID_SIZE);
			var vert:int = Math.floor(point.y / GRID_SIZE);
			if (_gridList[hori + "_" + vert]) {
				return _gridList[hori + "_" + vert] as Grid;
			}
			return null;
		}

		/**获取某节点对应的点坐标*/
		public function getPointByGrid(grid:Grid):Point {
			return new Point((grid.horiNum + 0.5) * GRID_SIZE, (grid.vertNum + 0.5) * GRID_SIZE);
		}

		/**
		 * 指定shape用某颜色填充某节点格子
		 * （单次执行不会清除上一次的绘制，谨慎使用）
		 * @param horiNum 节点横向序号
		 * @param vertNum 节点纵向序号
		 * @param color	      颜色
		 */
		private function fillGridBox(horiNum:int, vertNum:int, color:int = 0x00FF00):void {
			shape.graphics.beginFill(color, 0.3);
			shape.graphics.moveTo(GRID_SIZE * horiNum, GRID_SIZE * vertNum);
			shape.graphics.lineTo(GRID_SIZE * (horiNum + 1), GRID_SIZE * vertNum);
			shape.graphics.lineTo(GRID_SIZE * (horiNum + 1), GRID_SIZE * (vertNum + 1));
			shape.graphics.lineTo(GRID_SIZE * horiNum, GRID_SIZE * (vertNum + 1));
			shape.graphics.lineTo(GRID_SIZE * horiNum, GRID_SIZE * vertNum);
			shape.graphics.endFill();
		}

		/**将Shape数据保存为位图*/
		private function getImageByShape(shape:Shape):Bitmap {
			var imageData:BitmapData = new BitmapData(mapWidth, mapHeight, true, 0);
			imageData.draw(shape);
			return new Bitmap(imageData);
		}

		/**设置寻路相关的可见性*/
		public function showGrid(type:int):void {
			switch (type) {
				/*网格*/
				case 74:
					netImage.visible = !netImage.visible;
					break;
				/*区域地图*/
				case 75:
					areaImage.visible = !areaImage.visible;
					break;
				/*寻路节点容器*/
				case 76:
					gridContainer.visible = !gridContainer.visible;
					break;
			}
		}

		/**获取舞台*/
		public function getStage(stage:Sprite):void {
			gameStage = stage;
		}

		/**节点数组*/
		public function get gridList():Dictionary {
			return _gridList;
		}
	}
}
