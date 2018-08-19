package Role {
	

	public class Friend extends RoleView {
		public function Friend() {
			super();
			
			_positionSp.graphics.clear()
			_positionSp.graphics.beginFill(0x00ff00, 0);
			_positionSp.graphics.drawCircle(0, 0, 40);
		}
	}
}
