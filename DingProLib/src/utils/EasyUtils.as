package utils {
	
	/**
	 * 一些很赞的工具 
	 * @author dingzhichao
	 * 
	 */	
	public class EasyUtils {
		
		/**
		 * 用字符填充数字
		 * @param num 数字，位数不能大于length
		 * @param length 总长度
		 * @param charge 填充用字符，默认0
		 * @return 
		 * 
		 * e.g.
		 * 用0填充数字123，长度6位，返回"000123";
		 * 用0填充数字1234，长度4位，返回"1234";
		 * 用0填充数字000，长度3位，返回"000";
		 */		
		public static function rechargeNumByStr(num:int, length:int = 2, charge:String = "0"):String {
			var str:String = "";
			for(var i:int = String(num).length; i < length; i++) {
				str += charge;
			}
			return str + String(num);
		}
	}
}