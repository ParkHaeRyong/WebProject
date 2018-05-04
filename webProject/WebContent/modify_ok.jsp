<%@ page import="java.sql.*"%> 
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<% 	request.setCharacterEncoding("UTF-8"); //받아오는 값들을 한글로 인코딩합니다.
	
	String board_Title = request.getParameter("title");
	String board_Content = request.getParameter("content");

	int seq = 1;
	seq = Integer.parseInt(request.getParameter("seq")); // pg를 저장함 
	Connection conn = null;
	PreparedStatement pstmt = null;
try{
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test" , "test", "123456"); 
	String sql = "UPDATE BOARD SET Board_Title ='"+board_Title+"', Board_Content ='"+board_Content+"' WHERE Board_seq = '"+seq+"'";
	pstmt = conn.prepareStatement(sql);  
	pstmt.executeUpdate();
	}finally{
			try {
			if (pstmt != null)
				pstmt.close();
			if (conn != null)
				conn.close();
		} catch (SQLException e) {
			System.out.println("@@@@@@!!@!@!@@");
			System.out.println(e.getMessage());
		}
	}	
%>
<script>
	alert("수정 되었습니다.");
	location.href="viewBoard.jsp?seq=<%=seq%>"; 
</script>