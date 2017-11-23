package module {
	import flash.display.Stage;

	public class MainModel {
		
		private var _stage:Stage;
		private static var _instance:MainModel;

		public static function getInstance():MainModel {
			_instance ||= new MainModel;
			return _instance;
		}

		public function MainModel() {
		}
		
		public function set stage(stage:Stage):void {
			_stage = stage;
		}
		
		public function get stage():Stage {
			return _stage;
		}
	}
}
