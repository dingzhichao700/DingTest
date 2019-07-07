package util {

	public class MainControl {
		
		private var index:HomeView;
		private var index2:IndexView;
		private var zhengce:ZhengceMainView;
		private var zhengce_sigebang:Zhengce_sigebangView;
		
		private static var _ins:MainControl;
		public static function get ins():MainControl {
			_ins ||= new MainControl();
			return _ins;
		}
		
		public function MainControl() {
		}
		
		/**首页*/
		public function openHome():void {
			index ||= new HomeView();
			index.open();
		}
		
		/**目录*/
		public function openIndex():void {
			index2 ||= new IndexView();
			index2.open();
		}
		
		public function openZhengceIndex():void {
			zhengce ||= new ZhengceMainView();
			zhengce.open();
		}
		
		public function openZhengce_sigebangView():void {
			zhengce_sigebang ||= new Zhengce_sigebangView();
			zhengce_sigebang.open();
		}
		
	}
}
