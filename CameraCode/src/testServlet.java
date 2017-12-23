import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class testServlet extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//这个方法是swf提交，如果是拍照的，有三次提交，如果是修改图片的，则有两次提交。
		String dirPath = getServletConfig().getServletContext().getRealPath("/");
		String fileName=UUID.randomUUID().toString()+".jpg";
		//request.getParameter("radom");页面传过来的参数

		try {
			File file=new File(dirPath+fileName);
			if(!file.exists()){
				file.createNewFile();
			}
			
			FileOutputStream dos=new FileOutputStream(file);  
			int x=request.getInputStream().read();
			while (x>-1) {
				dos.write(x);
				x=request.getInputStream().read();
			}
			dos.flush();
			dos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//此处必需返回这种格式,要不然不会第二次调用
		//{"data":{"urls":["1243251304_big.jpg"]},"status":1,"statusText":"保存存成功!"}
		String s= "{\"data\":{\"urls\":[\""+fileName+"\"]},\"status\":1,\"statusText\":\"保存存成功\"}";
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(s);
		out.flush();
		out.close();
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
