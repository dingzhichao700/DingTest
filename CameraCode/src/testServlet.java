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
		//���������swf�ύ����������յģ��������ύ��������޸�ͼƬ�ģ����������ύ��
		String dirPath = getServletConfig().getServletContext().getRealPath("/");
		String fileName=UUID.randomUUID().toString()+".jpg";
		//request.getParameter("radom");ҳ�洫�����Ĳ���

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
		
		//�˴����践�����ָ�ʽ,Ҫ��Ȼ����ڶ��ε���
		//{"data":{"urls":["1243251304_big.jpg"]},"status":1,"statusText":"�����ɹ�!"}
		String s= "{\"data\":{\"urls\":[\""+fileName+"\"]},\"status\":1,\"statusText\":\"�����ɹ�\"}";
		
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
