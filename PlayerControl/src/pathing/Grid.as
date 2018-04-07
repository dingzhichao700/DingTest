package pathing {

	/**
	 * 地图节点 
	 * @author dingzhichao
	 * 
	 */	
	public class Grid {
		
		/**父节点*/
		public var parrentGrid:Grid;  
		/**自身的G值*/
		public var gValue:int;  
		/**横向序号*/
		private var _horiNum:int;
		/**纵向序号*/
		private var _vertNum:int;
		/**是否可通过*/
		private var _passAble:Boolean;
		
		public function Grid(mHoriNum:int, mVertNum:int, mPassAble:Boolean) {
			_horiNum = mHoriNum;
			_vertNum = mVertNum;
			_passAble = mPassAble;
		}
		
		/**横向序号*/
		public function get horiNum():int {
			return _horiNum;
		}
		
		/**纵向序号*/
		public function get vertNum():int {
			return _vertNum;
		}
		
		/**是否可通过*/
		public function get passAble():Boolean {
			return _passAble;
		}
		
		/**比对两个节点是否相同*/
		public function equalTo(grid:Grid):Boolean {
			if (_horiNum == grid.horiNum && _vertNum == grid.vertNum) {
				return true;
			}
			return false;
		}
		
		/**拷贝*/
		public function copy():Grid {
			var copyGrid:Grid = new Grid(_horiNum, _vertNum, _passAble);
			return copyGrid;
		}
	}
}
