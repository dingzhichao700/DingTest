package res.vo {
	import flash.display.Bitmap;

	/**
	 * 图片资源VO
	 * @author dingzhichao
	 *
	 */
	public class ResDataVo {

		/**角色*/
		private var _chara:String;
		/**动作*/
		private var _act:String;
		/**方向*/
		private var _direction:String;
		/**序号*/
		private var _num:uint;
		/**图片*/
		private var _bitmap:Bitmap;
		/**裁剪范围*/
		private var _cutArea:Array;

		/**
		 * 图片资源VO
		 * @param mRole 角色
		 * @param mAct 动作
		 * @param mDirection 方向
		 * @param mNum 序号
		 * @param mCutArea 裁剪范围
		 * @param mBitmap 图片
		 * 
		 */
		public function ResDataVo(mChara:String, mAct:String, mDirection:String, mNum:uint, mCutArea:Array, mBitmap:Bitmap) {
			_chara = mChara;
			_act = mAct;
			_direction = mDirection;
			_num = mNum;
			_cutArea = mCutArea;
			_bitmap = mBitmap;
		}

		/**角色名*/
		public function get chara():String {
			return _chara;
		}

		/**动作*/
		public function get act():String {
			return _act;
		}

		/**方向*/
		public function get direction():String {
			return _direction;
		}
		
		/**序号*/
		public function get num():uint {
			return _num;
		}
		
		/**图片*/
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		
		/**裁剪范围,包含4个元素，依次是[起始x坐标，起始y坐标，终点x坐标，终点y坐标]*/
		public function get cutArea():Array {
			return _cutArea;
		}
	}
}
