package res.manager {
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import event.GameBus;
	
	import res.ResFacade;
	import res.msg.ResMsg;
	import res.vo.ResDataVo;
	import res.vo.ResPathVo;
	import res.tools.ResGroupLoader;

	/**
	 * 角色资源管理
	 * @author dingzhichao
	 *
	 */
	public class ResDataManager {

		/**动作的位图数据*/
		private var _bitmapArr:Array;
		/**成套的动作数据,以[角色名_动作名_方向值]（例 [man_stand1_2]）对应存放每套动作的数组*/
		private var _actDic:Dictionary;
		/**资源路径数组*/
		private var resContent:Vector.<ResPathVo>;
		/**总共需加载的动作套数*/
		private var totalCount:uint;
		/**加载完成的动作套数*/
		private var loadedCount:uint;
		private static var instance:ResDataManager;

		public function ResDataManager() {
			_bitmapArr = new Array();
			_actDic = new Dictionary();
		}

		/**
		 * 开始加载资源
		 * @param path 根路径
		 *
		 */
		public function startLoad():void {
			initPath();
			loadImage();
		}

		/**初始化加载路径*/
		public function initPath():void {
			var man:ResPathVo = new ResPathVo("man");
			var woman:ResPathVo = new ResPathVo("woman");
			resContent = new Vector.<ResPathVo>();
			resContent.push(man, woman);
			for (var i:int in resContent) {
				/*攻击*/
				var attack:ResPathVo = new ResPathVo("attack");
				attack.items = new Array("attack1", "attack2", "attack3");
				/*死亡*/
				var dead:ResPathVo = new ResPathVo("dead");
				dead.items = new Array("dead1");
				/*受击*/
				var hurt:ResPathVo = new ResPathVo("hurt");
				hurt.items = new Array("hurt1");
				/*奔跑*/
				var run:ResPathVo = new ResPathVo("run");
				run.items = new Array("run1");
				/*坐下*/
				var sit:ResPathVo = new ResPathVo("sit");
				sit.items = new Array("sit1");
				/*站立*/
				var stand:ResPathVo = new ResPathVo("stand");
				stand.items = new Array("stand1");

				ResPathVo(resContent[i]).items = new Array(attack, dead, hurt, run, sit, stand);
			}
		}

		/**开始加载图片（以某动作某个方向的一套图片为单位进行加载）*/
		public function loadImage():void {
			totalCount = 0;
			for (var i:int = 0; i < resContent.length; i++) {
				if (resContent[i].items) {
					for (var j:int = 0; j < resContent[i].items.length; j++) {
						for (var k:int = 0; k < resContent[i].items[j].items.length; k++) {
							/*加载任务计数*/
							totalCount++;
							var loader:ResGroupLoader = new ResGroupLoader();
							loader.loadRes(resContent[i].pathName, resContent[i].items[j].pathName, resContent[i].items[j].items[k]);
						}
					}
				}
			}
		}

		/**
		 * 保存图片（全放进数组里） 
		 * @param chara 	角色
		 * @param act 		动作
		 * @param dire		方向
		 * @param num		序号
		 * @param cutArea	裁剪区域
		 * @param bitmap	位图
		 * 
		 */		
		public function saveData(chara:String, act:String, dire:String, num:String, cutArea:Array, bitmap:Bitmap):void {
			_bitmapArr.push(new ResDataVo(chara, act, dire, int(num), cutArea, bitmap));
		}

		/**某套动作(5方向)图片载入完毕，处理排序*/
		public function actLoaded(chara:String, act:String):void {
			for (var i:int = 1; i < 6; i++) {
				var actGroup:Array = new Array();
				_actDic[chara + "_" + act + "_" + i] = actGroup;
			}
			for (var j:int = 0; j < _bitmapArr.length; j++) {
				/**核准角色名与动作，并匹配方向，加入到字典里的对应数组中*/
				var vo:ResDataVo = ResDataVo(_bitmapArr[j]);
				if (vo.chara == chara && vo.act == act) {
					(_actDic[chara + "_" + act + "_" + vo.direction] as Array).push(vo);
				}
			}
			for (var k:int = 1; k < 6; k++) {
				(_actDic[chara + "_" + act + "_" + k] as Array).sortOn("num", Array.NUMERIC);
			}
//			trace(chara + "_" + act + " 整理完成");
			/*加载完毕计数*/
			loadedCount++;
			if(loadedCount == totalCount){
				GameBus.sendMsg(ResMsg.LOAD_OVER);
			}
		}
		
		/**
		 * 获取某套动作图片 
		 * @param chara 角色
		 * @param act 动作
		 * @param direction 方向
		 * @return 
		 * 
		 */		
		public function getAnimeArr(chara:String, act:String, direction:uint):Array {
			if(_actDic[chara + "_" + act + "_" + direction]){
				return _actDic[chara + "_" + act + "_" + direction];
			}
			return null;
		}

		/**单例方法*/
		public static function getInstance():ResDataManager {
			if (!instance) {
				instance = new ResDataManager();
			}
			return instance;
		}
	}
}
