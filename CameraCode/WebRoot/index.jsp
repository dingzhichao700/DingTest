<%@ page language="java" import="java.util.*;" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>

	<title>摄像头测试</title>
	<script type="text/javascript">
	/**
	 * 提供给FLASH的接口 ： 没有摄像头时的回调方法
	 */
	function noCamera() {
		alert("没有摄像头");
	}

	/**
	 * 提供给FLASH的接口：编辑头像保存成功后的回调方法
	 */
	function avatarSaved() {
		//这里需跳转到别的页面去
		alert('保存成功');
	}

	/**
	 * 提供给FLASH的接口：编辑头像保存失败的回调方法, msg 是失败信息，
	 * 可以不返回给用户, 仅作调试使用.
	 */
	function avatarError(msg) {
		alert(msg);
	}

</script>

	</head>

	<body>

		<EMBED height="464" type="application/x-shockwave-flash"
			pluginspage="http://www.macromedia.com/go/getflashplayer" width="514"
			src="AvatarEditor.swf" quality="high" allowscriptaccess="always"
			flashvars="type=camera&amp;postUrl=servlet/testServlet?&amp;radom=1&amp;saveUrl=servlet/testServlet?radom=1">
		</EMBED>

		<br />
		<br />
		
		<EMBED height="464" type="application/x-shockwave-flash"
			pluginspage="http://www.macromedia.com/go/getflashplayer" width="514"
			src="AvatarEditor.swf" quality="high" allowscriptaccess="always"
			flashvars="type=photo&amp;photoUrl=0.jpg&amp;postUrl=servlet/testServlet?&amp;radom=1&amp;saveUrl=servlet/testServlet?radom=1">
		</EMBED>
		
	</body>
</html>
