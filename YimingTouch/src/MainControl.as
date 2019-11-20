package {
	import module.FileView;
	import module.HomeView;
	import module.IndexView;
	import module.PicSmallView;
	import module.PicView;
	import module.PicView2;
	import module.PicView3;
	import module.falv.FalvfaguiMainView;
	import module.lingdao.LingdaoguanhuaiMainView;
	import module.sanxia.SanxiaMainView;
	import module.zhengce.Sigebang_bangfazhanView;
	import module.zhengce.Sigebang_bangguanliView;
	import module.zhengce.Sigebang_bangjieyouView;
	import module.zhengce.Sigebang_bangrongheView;
	import module.zhengce.ZhengceMainView;
	import module.zhuzhi.ZuzhijiagouMainView;

	public class MainControl {

		private var index:HomeView;
		private var index2:IndexView;

		private var sanxia:SanxiaMainView;

		private var zuzhi:ZuzhijiagouMainView;

		private var zhengce:ZhengceMainView;
		private var zhengce_sigebang_bangronghe:Sigebang_bangrongheView;
		private var zhengce_sigebang_bangfazhan:Sigebang_bangfazhanView;
		private var zhengce_sigebang_bangjieyou:Sigebang_bangjieyouView;
		private var zhengce_sigebang_bangguanli:Sigebang_bangguanliView;

		private var lingdao:LingdaoguanhuaiMainView;

		private var falv:FalvfaguiMainView;

		private var picView:PicView;
		
		private var picSmallView:PicSmallView;

		private var picView2:PicView2;
		
		private var picView3:PicView3;
		
		private var fileView:FileView;

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

		public function openZhengce_bangrongheView():void {
			zhengce_sigebang_bangronghe ||= new Sigebang_bangrongheView();
			zhengce_sigebang_bangronghe.open();
		}

		public function openZhengce_bangfazhanView():void {
			zhengce_sigebang_bangfazhan ||= new Sigebang_bangfazhanView();
			zhengce_sigebang_bangfazhan.open();
		}

		public function openZhengce_bangjieyouView():void {
			zhengce_sigebang_bangjieyou ||= new Sigebang_bangjieyouView();
			zhengce_sigebang_bangjieyou.open();
		}

		public function openZhengce_bangguanliView():void {
			zhengce_sigebang_bangguanli ||= new Sigebang_bangguanliView();
			zhengce_sigebang_bangguanli.open();
		}

		public function openLingdaoguanhuaiIndex():void {
			lingdao ||= new LingdaoguanhuaiMainView();
			lingdao.open();
		}

		public function openFalvfaguiIndex():void {
			falv ||= new FalvfaguiMainView();
			falv.open();
		}

		private function openPicView():void {
			picView ||= new PicView();
			picView.open();
		}

		public function showPic(url:String):void {
			openPicView();
			picView.showPic(url);
		}

		private function openSmallPicView():void {
			picSmallView ||= new PicSmallView();
			picSmallView.open();
		}

		public function showSmallPic(url:String):void {
			openSmallPicView();
			picSmallView.showPic(url);
		}

		public function openPicView2():void {
			picView2 ||= new PicView2();
			picView2.open();
		}

		private function openPicView3():void {
			picView3 ||= new PicView3();
			picView3.open();
		}

		public function showPicView3(index:int):void {
			openPicView3();
			picView3.showPic(index);
		}

		public function openFileView():void {
			fileView ||= new FileView();
			fileView.open();
		}

		public function showFile(url:String):void {
			openFileView();
			fileView.showFile(url);
		}

	}
}
