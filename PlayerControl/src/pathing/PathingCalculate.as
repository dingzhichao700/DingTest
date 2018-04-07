package pathing {
	import flash.utils.Dictionary;
	import flash.utils.getTimer;


	/**
	 * 寻路演算
	 * @author dingzhichao
	 *
	 */
	public class PathingCalculate {

		/**节点字典*/
		private var gridDic:Dictionary;
		/**是否找到终点*/
		private var findBoo:Boolean;

		private var startGrid:Grid;
		private var _endGrid:Grid;
		/**开放列表*/
		private var openList:Array;
		/**封闭列表*/
		private var closedList:Array;
		private var curGrid:Grid;

		private static var _instance:PathingCalculate;

		public static function getInstance():PathingCalculate {
			if (!_instance) {
				_instance = new PathingCalculate();
			}
			return _instance;
		}

		public function PathingCalculate() {
		}

		/**获取移动路径*/
		public function getPath(start:Grid, end:Grid):Array {
			gridDic = PathingFacade.manager.gridList;
			startGrid = start;
			_endGrid = end;
			openList = [];
			closedList = [startGrid];

			getAroundGrids(startGrid);

			findBoo = false;
			while (openList.length > 0 && !findBoo) {
				curGrid = findLowestGrid();
				getAroundGrids(curGrid);
			}

			if(findBoo){
				var time:int = getTimer();
//				trace("寻路耗时: " + (getTimer() - time) + "毫秒");
				var finalRoute:Array = makeRoute(curGrid);
				return finalRoute;
			}
			return [];
		}
		
		private function makeRoute(grid:Grid):Array {
			var result:Array = [grid];
			while(grid.parrentGrid){
				result.unshift(grid.parrentGrid);
				grid = grid.parrentGrid;
			}
			return result;
		}

		/**从开放列表里找F值最小的节点*/
		private function findLowestGrid():Grid {
			var lowest:Grid = openList[0];
			for (var i:int = 0; i < openList.length; i++) {
				if(getFValue(openList[i] as Grid) < getFValue(lowest)){
					lowest = openList[i];
				}
			}
			for (var j:int = 0; j < openList.length; j++) { //将这个F值最小的节点，从开放列表里删除，加入封闭列表
				if(Grid(openList[j]).equalTo(lowest)){
					closedList.push(openList.splice(j, 1)[0]);
				}
			}
			return lowest;
		}

		/** 获取F值，
		 * F值 = G值 + H值
		 */
		private function getFValue(grid:Grid):int {
			return getGValue(grid) + getHValue(grid);
		}

		/** 获取G值，
		 * G值的概念：父节点到当前点的移动代价的一种系数
		 * G值 = 父节点的G值 + 自身G值
		 * 自身G值会在getAroundGrids()时赋值给格子
		 */
		private function getGValue(grid:Grid):int {
			return grid.gValue + grid.parrentGrid ? grid.parrentGrid.gValue : 0;
		}

		/** 获取H值
		 * H值 = 当前点到结束点的曼哈顿距离
		 */
		private function getHValue(grid:Grid):int {
			var disX:int = Math.abs(_endGrid.horiNum - grid.horiNum); 
			var disY:int = Math.abs(_endGrid.vertNum - grid.vertNum); 
			return disX + disY;
		}

		/**
		 * 检查周围的节点（排除不可通过的节点）
		 *  
		 */
		private function getAroundGrids(pGrid:Grid):void {
			var hori:int = pGrid.horiNum;
			var vert:int = pGrid.vertNum;
			var arr:Array = [
				[hori - 1, vert - 1],
				[hori, vert - 1], 
				[hori + 1, vert - 1], 
				[hori - 1, vert], 
				[hori + 1, vert],
				[hori - 1, vert + 1],
				[hori, vert + 1], 
				[hori + 1, vert + 1]];
			for (var i:int = 0; i < arr.length; i++) {
				if (Grid(gridDic[arr[i][0] + "_" + arr[i][1]])) {
					var grid:Grid = Grid(gridDic[arr[i][0] + "_" + arr[i][1]]).copy();
					if (grid.passAble) {
						if (grid.equalTo(endGrid)) { //找到，这个点就是终点
							grid.parrentGrid = pGrid;
							curGrid = grid;
							findBoo = true;
							break;
						} else { //没找到，尝试继续找
							if(inOpenList(grid) || inClosedList(grid)){
								continue;
							} 
							if (arr[i][0] == hori || arr[i][1] == vert) { //根据相对pGrid的位置，分别赋予G值
								grid.gValue = 10;
							} else {
								grid.gValue = 14;
							}
							grid.parrentGrid = pGrid;
							openList.push(grid);
						}
					}
				}
			}
		}
		
		/**是否在开放列表中*/
		private function inOpenList(grid:Grid):Boolean {
			var findBoo:Boolean = false;
			for(var i:int = 0 ; i < openList.length;i++){
				if(Grid(openList[i]).equalTo(grid)){
					findBoo = true;
				}
			}
			return findBoo;
		}
		
		/**是否在开放列表中*/
		private function inClosedList(grid:Grid):Boolean {
			var findBoo:Boolean = false;
			for(var i:int = 0 ; i < closedList.length;i++){
				if(Grid(closedList[i]).equalTo(grid)){
					findBoo = true;
				}
			}
			return findBoo;
		}

		/**终点节点*/
		public function get endGrid():Grid {
			return _endGrid;
		}
	}
}
