package webProject;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginValue
 */
@WebServlet("/LoginValue")
public class LoginValue extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	static String id = null;
	static String password = null;
	static String name = null;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginValue() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		
		/*서버 생성*/
		try {
            System.out.println("접속을 기다립니다.");
            ServerSocket serverSocket = new ServerSocket(10002);
            AcceptThread acceptThread = new AcceptThread(serverSocket);
            // 여기서 새로운 쓰레드가 생성
            new Thread(acceptThread).start();
        } catch (Exception e) {
        }
		
		
		request.setCharacterEncoding("UTF-8");
	     
	    // 값가져오기 
	    id = request.getParameter("id");
	    password = request.getParameter("password");
	    name = request.getParameter("name");
	     System.out.println(name);
	    // 출력하기 
	    String transactions = id+","+password+","+name;
	    try {
			BlockchainDriver.BlockChain(transactions);
			response.sendRedirect("main.jsp?id="+id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//System.out.println("!!");
			RequestDispatcher view = request.getRequestDispatcher("error.jsp");
			view.forward(request, response);
			//response.sendRedirect("/index.jsp");
			e.printStackTrace();
		}
	    
	    
	}

}
