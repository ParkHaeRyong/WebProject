package webProject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EditSchdule")
public class EditSchedule extends HttpServlet{
	
	public EditSchedule() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		String year = request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		
		System.out.println(title);
		System.out.println(contents);
		
		Connection connection = null;
        Statement st = null;
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://192.168.100.64:3306/test" , "test", "123456");
            st = connection.createStatement();
            
            String sql;
            sql = "insert into schedule(title, contents, ins_id, ins_dt, year, month, day) values('"+title+"', '"+contents+"', '', '', '"+year+"', '"+month+"', '"+day+"')";
            st.executeUpdate(sql);
            
            st.close();
            connection.close();
            
        } catch(Exception ex){
        	ex.printStackTrace();
        }
        
        response.sendRedirect("calendar.jsp");
        
	}
}
