<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% String id = (String)session.getAttribute("id"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 부트스트랩 사용하기 위해 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>글 보기</title>
</head>
<body>
<%
		int seq = 1;
		seq = Integer.parseInt(request.getParameter("seq")); // pg를 저장함 
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
	try{
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test" , "test", "123456"); 
		Statement stat = conn.createStatement();  
		rs = stat.executeQuery("SELECT Board_Title, Board_Content FROM Board WHERE Board_seq = '"+seq+"'");
		
		if(rs.next()){
		String board_Title = rs.getString("Board_Title");
		String board_Content =rs.getString("Board_Content");
%>
	<form name = "writeform" method = "post" action="modify_ok.jsp?seq=<%=seq%>">
		<div class="container">
		  <h2>글 보기</h2>          
		  <table class="table table-hover">
		    <tbody>
		      <tr>
		      	<td><input type="text" class="form-control" name="title" maxlength="40"  value=<%=board_Title %>></td>
		      </tr>
		      <tr>
		      	<td><textarea type="text" class="form-control" name="content"  style="height: 400px;" ><%=board_Content %></textarea></td>
		      </tr>
		    </tbody>
		  </table>
		  	<input type=button class="btn btn-primary pull-right" value="취소" onclick = "javascript:history.back(-1);">
		  	<input type=button class="btn btn-primary pull-right" value="저장" onclick = "javascript:modifyCheck();">
		</div>
	</form>
<%}
	}finally {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			System.out.println("@@@@@@!!@!@!@@");
			System.out.println(e.getMessage());
		}
	}	
	%>

</body>
<script language = "javascript">
	function modifyCheck()
	{
		 var form = document.writeform;
		 
		 if( !form.title.value ){
			 alert( "제목을 적어주세요" );
			 form.title.focus();
			 return;
		 }
		
		 if( !form.content.value ){
			 alert( "내용을 적어주세요" );
			 form.memo.focus();
			 return;
		 }
		 form.submit();
	}
	
</script>
</html> 