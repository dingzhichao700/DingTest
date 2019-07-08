package  {
	import module.HomeView;
	import module.IndexView;
	import module.falv.FalvfaguiMainView;
	import module.lingdao.LingdaoguanhuaiMainView;
	import module.sanxia.SanxiaMainView;
	import module.zhengce.ZhengceMainView;
	import module.zhengce.Zhengce_sigebangView;
	import module.zhuzhi.ZuzhijiagouMainView;

	public class MainControl {
		
		private var index:HomeView;
		private var index2:IndexView;
		
		private var sanxia:SanxiaMainView;
		
		private var zuzhi:ZuzhijiagouMainView;
		
		private var zhengce:ZhengceMainView;
		private var zhengce_sigebang:Zhengce_sigebangView;
		
		private var lingdao:LingdaoguanhuaiMainView;
		
		private var falv:FalvfaguiMainView;
		
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
		
		public function openSanxiaIndex():void {
			sanxia ||= new SanxiaMainView();
			sanxia.open();
		}
		
		public function openZuzhijiagouIndex():void {
			zuzhi ||= new ZuzhijiagouMainView();
			zuzhi.open();
		}
		
		public function openZhengceIndex():void {
			zhengce ||= new ZhengceMainView();
			zhengce.open();
		}
		
		public function openZhengce_sigebangView():void {
			zhengce_sigebang ||= new Zhengce_sigebangView();
			zhengce_sigebang.open();
		}
		
		public function openLingdaoguanhuaiIndex():void {
			lingdao ||= new LingdaoguanhuaiMainView();
			lingdao.open();
		}
		
		public function openFalvfaguiIndex():void {
			falv ||= new FalvfaguiMainView();
			falv.open();
		}
		
	}
}
