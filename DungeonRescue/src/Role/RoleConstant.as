package Role {
	public class RoleConstant {

		private static const ACT_FRAME:Array = [{"attack": 73}, {"dead": 4}, {"hurt": 3}, {"run": 30}, {"sit": 1}, {"stand": 1}];

		public function RoleConstant() {
		}
		
		public static function getFrameNum(actName:String):int {
			for(var i:int = 0; i < ACT_FRAME.length;i++){
				if((ACT_FRAME[i] as Object).hasOwnProperty(actName)){
					return ACT_FRAME[i][actName];
				}
			}
			return 0;
		}
		
	}
}
