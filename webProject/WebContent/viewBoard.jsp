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
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
		
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://192.168.1.158:3306/test" , "test", "123456"); 
		String sql ="SELECT a.Board_Title, a.Board_Content, a.Board_Writer, b.originalFilename, b.fileName FROM Board a LEFT JOIN file b ON a.board_seq = b.board_seq WHERE a.Board_seq = '"+seq+"'";
		
		pstmt = conn.prepareStatement(sql); 
		rs = pstmt.executeQuery();
		
		if(rs.next()){
		String board_Title = rs.getString("Board_Title");
		String board_Content = rs.getString("Board_Content");
		String board_Writer = rs.getString("Board_Writer");
		String originalFilename = rs.getString("originalFilename"); 
		String fileName = rs.getString("fileName");
		
		
%>
	<form name = "writeform" method = "post" action="write_ok.jsp">
	<div class="container">
	  <h2>글 보기</h2>          
	  <table class="table table-hover">
	    <tbody>
	      <tr>
	      	<td><input type="text" class="form-control" name="title" maxlength="40" readonly value="<%=board_Title %>"></td>
	      </tr>
	      <tr>
	      	<td><textarea class="form-control" name="content" style="height: 400px;" readonly><%=board_Content %></textarea></td>
	      </tr>
	    </tbody>
	    	<tr>
	    		<%
	    			if(originalFilename == null || fileName == null){
	    		%>
	    		<td>
	    			첨부파일 : 파일없음
	    		</td>
	    		<%
	    			}else{
	    		%>
	    		<td>
	    			
	    			첨부파일 : <a href="filedown.jsp?fileName=<%=fileName%>&originalFilename=<%=originalFilename%>"><%=originalFilename %></a>
	    		</td>
	    		<%
	    			}
	    		%>
	    	</tr>
	  </table>
   		<%
	    	if(board_Writer.equals(id)){
	    %>
	    <input type=button class="btn btn-primary pull-right" value="삭제" onclick=  "javascript:deleteCheck();">
	  	<input type=button class="btn btn-primary pull-right" value="수정" onclick = "location.href='modifyBoard.jsp?seq=<%=seq%>'">
	  	<%
	    	}
	  	%>
	  	<input type=button class="btn btn-primary pull-right" value="목록" onclick = "location.href='noticeBoard.jsp?id=<%=id%>'">
	</div>
</form>
<%		}
	}finally {
		try {
			if (rs != null)
				rs.close();
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
</body>
<script language = "javascript">
	function writeCheck()
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
	function deleteCheck(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			location.href="boardDel.jsp?seq=<%=seq%>&id=<%=id%>";
		}else{
			return ;
		}
	}
</script>
</html> 