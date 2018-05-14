<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


 
<% 
	
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.1.158:3306/test","test","123456"); 
	Statement stat = conn.createStatement();  
	ResultSet rs = stat.executeQuery("select * from USER where usrid ='"+id+"' and password ='"+pwd+"';"); 
	
	
	if (rs.next())
	{
		String usrid = rs.getString("usrid");
		String password = rs.getString("password");
		String username = rs.getString("username");
		%>
		
		 <form name ="blockChain" method="post" action="/webProject/webProject">
		 <input type="hidden" name="id" value="<%=usrid %>">
		 <input type="hidden" name="password" value="<%=password %>">
		 <input type="hidden" name="name" value="<%=username %>">
		 
		 </form>
		 

		 <script>document.blockChain.submit();</script>
		  
		 <script type="text/javascript" language="javascript">
		 location.href = "main.jsp";
		 </script>
		 
		 <%
	}
	else
	{
		%>
		 <script type="text/javascript">
		 alert("사용자 정보가 없습니다.");
		 location.href = "index.jsp";
		 </script>
		 <% 
	}
	rs.close();
	conn.close();
%>

 