<%@ page import="java.sql.*"%> 
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	int seq = Integer.parseInt(request.getParameter("seq")); // pg를 저장함 
	String id = (String)session.getAttribute("id");
	
	try {	
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test" , "test", "123456"); 
		
		String sql = "UPDATE board SET board_delCode = 1 WHERE board_seq = '"+seq+"' AND board_delCode = 0 ";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.execute();
		pstmt.close();
		
		conn.close();
	} catch(SQLException e) {
		out.println( e.toString() );
	} 

%>
<script>
   self.window.alert("입력한 글을 삭제하였습니다.");
   location.href="noticeBoard.jsp?id=<%=id%>"; 
</script>

