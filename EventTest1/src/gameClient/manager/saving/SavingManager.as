package gameClient.manager.saving
{
	import flash.net.SharedObject;
	import flash.system.Security;
	import flash.system.SecurityPanel;
	
	import gameClient.baseData.PlayerVo;

	/**
	 * 游戏存档管理
	 * @author ding
	 * 
	 */	
	public class SavingManager
	{
		/**存档数据*/
		private static var _savingData:Array
		private static var myLSO:SharedObject
		
		public function SavingManager()
		{
		}
		
		/**检查本地存档*/
		public static function checkSaving():void {
			myLSO = SharedObject.getLocal("saving");
			
			if(myLSO.data.saving == undefined)
			{ 
				trace("新建存档");
				_savingData = new Array();
				myLSO.data.saving = _savingData;
			} 
			else {
				_savingData = myLSO.data.saving as Array;
				trace("读取存档");
				for(var i:int = 0; i < _savingData.length; i++) {
					trace("记录" + i + ": " + _savingData[i].name + _savingData[i].index);
				}
			}
		}
		
		/**
		 * 创建一条新存档记录(SavingManager.createNewSave("ding");) 
		 * @param name 玩家名
		 * 
		 */		
		public static function createNewSave(name:String):void{
			var vo:PlayerVo = new PlayerVo();
			vo.name = "ding";
			vo.index = _savingData.length+1;
			_savingData.push(vo);
			flush();
		}
		
		/**清空所有存档记录*/
		public static function clearAll():void{
			_savingData = null;
			myLSO.data.saving = _savingData;
			flush();
		}
		
		/**写入*/
		private static function flush():void {
			if (myLSO) {
				try 
				{
					myLSO.flush();
				}
				catch (e:Error)
				{
					Security.showSettings();
					Security.showSettings( SecurityPanel.LOCAL_STORAGE );
				}
			}
		}
	}
}