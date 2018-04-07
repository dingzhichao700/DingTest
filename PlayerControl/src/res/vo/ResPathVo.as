package res.vo
{
	/**
	 * 资源路径类 
	 * @author dingzhichao
	 * 
	 */	
	public class ResPathVo
	{
		private var _pathName:String;
		private var _items:Array;
		
		public function ResPathVo(mPathName:String)
		{
			_pathName = mPathName;
		}
		
		/**路径名*/
		public function get pathName():String {
			return _pathName;
		}
		
		/**子文件夹数组*/
		public function set items(arr:Array):void {
			_items = arr;
		}
		public function get items():Array {
			return _items;
		}
	}
}