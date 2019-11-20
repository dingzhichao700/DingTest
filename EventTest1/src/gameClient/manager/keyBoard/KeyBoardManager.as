package gameClient.manager.keyBoard
{
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	
	import gameClient.manager.event.EventBus;

	/**
	 * 键盘事件管理器 
	 * @author ding
	 * 
	 */	
	public class KeyBoardManager
	{
		/**是否禁止键盘事件*/
		public static var BanBoard:Boolean; 
		
		public function KeyBoardManager()
		{
		}
		
		public static function init(_stage:Stage):void {
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, downHandler);
			_stage.addEventListener(KeyboardEvent.KEY_UP, upHandler);
		}
		
		/**按键按下*/
		private static function downHandler(e:KeyboardEvent):void{
			if(BanBoard){
				return;
			}
			switch(e.keyCode){
				case 65:
					EventBus.sendMsg(KeyBoardEventType.A_DOWN);
					break;
				case 66:
					EventBus.sendMsg(KeyBoardEventType.B_DOWN);
					break;
				case 67:
					EventBus.sendMsg(KeyBoardEventType.C_DOWN);
					break;
				case 68:
					EventBus.sendMsg(KeyBoardEventType.D_DOWN);
					break;
				case 69:
					EventBus.sendMsg(KeyBoardEventType.E_DOWN);
					break;
				case 70:
					EventBus.sendMsg(KeyBoardEventType.F_DOWN);
					break;
				case 71:
					EventBus.sendMsg(KeyBoardEventType.G_DOWN);
					break;
				case 72:
					EventBus.sendMsg(KeyBoardEventType.H_DOWN);
					break;
				case 73:
					EventBus.sendMsg(KeyBoardEventType.I_DOWN);
					break;
				case 74:
					EventBus.sendMsg(KeyBoardEventType.J_DOWN);
					break;
				case 75:
					EventBus.sendMsg(KeyBoardEventType.K_DOWN);
					break;
				case 76:
					EventBus.sendMsg(KeyBoardEventType.L_DOWN);
					break;
				case 77:
					EventBus.sendMsg(KeyBoardEventType.M_DOWN);
					break;
				case 78:
					EventBus.sendMsg(KeyBoardEventType.N_DOWN);
					break;
				case 79:
					EventBus.sendMsg(KeyBoardEventType.O_DOWN);
					break;
				case 80:
					EventBus.sendMsg(KeyBoardEventType.P_DOWN);
					break;
				case 81:
					EventBus.sendMsg(KeyBoardEventType.Q_DOWN);
					break;
				case 82:
					EventBus.sendMsg(KeyBoardEventType.R_DOWN);
					break;
				case 83:
					EventBus.sendMsg(KeyBoardEventType.S_DOWN);
					break;
				case 84:
					EventBus.sendMsg(KeyBoardEventType.T_DOWN);
					break;
				case 85:
					EventBus.sendMsg(KeyBoardEventType.U_DOWN);
					break;
				case 86:
					EventBus.sendMsg(KeyBoardEventType.V_DOWN);
					break;
				case 87:
					EventBus.sendMsg(KeyBoardEventType.W_DOWN);
					break;
				case 88:
					EventBus.sendMsg(KeyBoardEventType.X_DOWN);
					break;
				case 89:
					EventBus.sendMsg(KeyBoardEventType.Y_DOWN);
					break;
				case 90:
					EventBus.sendMsg(KeyBoardEventType.Z_DOWN);
					break;
			}
		}
		
		/**按键弹起*/
		private static function upHandler(e:KeyboardEvent):void{
			if(BanBoard){
				return;
			}
			switch(e.keyCode){
				case 65:
					EventBus.sendMsg(KeyBoardEventType.A_UP);
					break;
				case 66:
					EventBus.sendMsg(KeyBoardEventType.B_UP);
					break;
				case 67:
					EventBus.sendMsg(KeyBoardEventType.C_UP);
					break;
				case 68:
					EventBus.sendMsg(KeyBoardEventType.D_UP);
					break;
				case 69:
					EventBus.sendMsg(KeyBoardEventType.E_UP);
					break;
				case 70:
					EventBus.sendMsg(KeyBoardEventType.F_UP);
					break;
				case 71:
					EventBus.sendMsg(KeyBoardEventType.G_UP);
					break;
				case 72:
					EventBus.sendMsg(KeyBoardEventType.H_UP);
					break;
				case 73:
					EventBus.sendMsg(KeyBoardEventType.I_UP);
					break;
				case 74:
					EventBus.sendMsg(KeyBoardEventType.J_UP);
					break;
				case 75:
					EventBus.sendMsg(KeyBoardEventType.K_UP);
					break;
				case 76:
					EventBus.sendMsg(KeyBoardEventType.L_UP);
					break;
				case 77:
					EventBus.sendMsg(KeyBoardEventType.M_UP);
					break;
				case 78:
					EventBus.sendMsg(KeyBoardEventType.N_UP);
					break;
				case 79:
					EventBus.sendMsg(KeyBoardEventType.O_UP);
					break;
				case 80:
					EventBus.sendMsg(KeyBoardEventType.P_UP);
					break;
				case 81:
					EventBus.sendMsg(KeyBoardEventType.Q_UP);
					break;
				case 82:
					EventBus.sendMsg(KeyBoardEventType.R_UP);
					break;
				case 83:
					EventBus.sendMsg(KeyBoardEventType.S_UP);
					break;
				case 84:
					EventBus.sendMsg(KeyBoardEventType.T_UP);
					break;
				case 85:
					EventBus.sendMsg(KeyBoardEventType.U_UP);
					break;
				case 86:
					EventBus.sendMsg(KeyBoardEventType.V_UP);
					break;
				case 87:
					EventBus.sendMsg(KeyBoardEventType.W_UP);
					break;
				case 88:
					EventBus.sendMsg(KeyBoardEventType.X_UP);
					break;
				case 89:
					EventBus.sendMsg(KeyBoardEventType.Y_UP);
					break;
				case 90:
					EventBus.sendMsg(KeyBoardEventType.Z_UP);
					break;
			}
		}
		
		private static var _instance:KeyBoardManager;
		public static function instance():KeyBoardManager{
			if(!_instance){
				_instance = new KeyBoardManager();
			}
			return _instance;
		}
	}
}