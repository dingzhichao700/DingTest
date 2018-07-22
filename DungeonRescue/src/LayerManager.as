package {
	import flash.display.Sprite;
	import flash.display.Stage;

	public class LayerManager {
		
		/**背景层*/
		public var LAYER_BG:Sprite;
		/**角色层*/
		public var LAYER_PLAYER:Sprite;
		/**顶层*/
		public var LAYER_TOP:Sprite;
		
		private var _stage:Stage;
		
		private static var instance:LayerManager;
		public static function getInstance():LayerManager {
			instance ||= new LayerManager();
			return instance;
		}
		
		public function clearAll():void {
			LAYER_BG.removeChildren();
			LAYER_PLAYER.removeChildren();
			LAYER_TOP.removeChildren();
		}
		
		public function init(stage:Stage):void {
			_stage = stage;
			
			LAYER_BG = new Sprite();
			_stage.addChild(LAYER_BG);
			
			LAYER_PLAYER = new Sprite();
			_stage.addChild(LAYER_PLAYER);
			
			LAYER_TOP = new Sprite();
			_stage.addChild(LAYER_TOP);
		}
		
		public function LayerManager() {
		}
	}
}
