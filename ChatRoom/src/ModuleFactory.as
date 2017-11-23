package {
	import module.MainControl;
	import module.login.LoginControl;

	public class ModuleFactory {
		public function ModuleFactory() {

			MainControl.getInstance();
			LoginControl.getInstance();
		}
	}
}
