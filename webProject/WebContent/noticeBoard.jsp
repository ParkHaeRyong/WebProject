<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<% String id = (String)session.getAttribute("id"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content = "width=device-width, initial-scale=1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel = "stylesheet" href="css/bootstrap.css">
<link href="css2/bootstrap.min.css" rel="stylesheet">
<link href="css2/jquery.bxslider.css" rel="stylesheet">
<link href="css2/style.css" rel="stylesheet">
<script src = "js/bootstrap.js"></script>
<title>게시판</title>
</head>
<style>
.bg{
	height: 0;
	padding-top: 20%;
	background : url(img/blockchain.png);
	background-repeat:no-repeat;
	background-position: center;
	background-size: contain;
} 

 body{

	 margin-bottom: 120px;
}   

</style>
<header>
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div id="navbar" class="collapse navbar-collapse">
					<ul class="nav navbar-nav">
						<li><a href="noticeBoard.jsp">게시판</a></li>
						<li><a href="calendar.jsp">일정</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>
<body>
<h1 class= "text-center">게시판</h1>
	<%
		final int ROWSIZE = 10; // 한페이지에 보일 게시물의 수
		final int BLOCK = 5; // 아래에 보일 페이지 최대 개수

		int pg = 1;

		if (request.getParameter("pg") != null) { // 받아온 pg 값이 있을경우에
			pg = Integer.parseInt(request.getParameter("pg")); // pg를 저장함 
		}

		int start = ((pg-1)/10)*10+1; //해당페이지에서 시작번호 (step2) 1
		int end = (start+ROWSIZE)-1;; //해당페이지에서 끝번호(step2) 10

		int allPage = 0; //전체 페이지수

		int startPage = ((pg - 1) / BLOCK * BLOCK) + 1; //시작블럭숫자 (1-5 page일경우)1 (6-10일경우)6
		int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK; // 끝 블럭숫자(1-5일경우 5) 6~10일경우 10
	%>
	<%
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test" , "test", "123456"); 
		String sql = "SELECT COUNT(*) FROM Board where board_delCode=0 ";
		pstmt = conn.prepareStatement(sql);  
		rs = pstmt.executeQuery();
		
		int numberOfRecords = 0;
		
		if(rs.next()){
			numberOfRecords = rs.getInt(1);
		}
		
		rs.close();
		
		
		allPage=(int) Math.ceil(numberOfRecords/(double)ROWSIZE);
		
		if (endPage > allPage){
			endPage = allPage;
		}
		
		int Limit = 10;
		int Offset = pg * ROWSIZE - 10;
		
%>
	<div class = "container">
		
	<table class="table table-striped" style=TABLE-layout:fixed>
	<thead>
		<tr align="center">
			<td>글 번호</td>
			<td>글 제목</td>
			<td>작성자</td>
			<td>작성 시간</td>
		</tr>
	</thead>
<%	
	out.print("총 게시물 :"+numberOfRecords+"개");

/* 	rs = pstmt.executeQuery("SELECT (select count(*) from board b where a.board_seq <= b.board_seq and board_delCode=0)as rowNumber, board_seq, board_title, board_writer, board_time "
							+"FROM BOARD a "
							+"WHERE board_delCode= 0 "
							+"ORDER BY board_time DESC "
							+"LIMIT "+Limit+" OFFSET "+Offset);  */
	String S = " SELECT (@rownum:=@rownum+1) as rowNumber, board_seq, board_title, board_writer, DATE_FORMAT(board_time,'%Y-%m-%d %H:%i') as board_time "
			  +"FROM board , (SELECT @rownum:="+Offset+") TMP "
			  +"WHERE board_delCode = 0 "
			  +"ORDER BY rowNumber DESC, board_time DESC "
			  +"LIMIT "+Limit+" OFFSET "+Offset;
	
							
	rs = pstmt.executeQuery(S);
	
	
	while(rs.next()){
	int rowNumber = rs.getInt("rowNumber");
	int board_seq = rs.getInt("board_seq");
	String board_Writer = rs.getString("board_Writer");
	String board_Title = rs.getString("board_Title");
	String board_time =rs.getString("board_Time");
	
%>
	<tbody>
		<tr align="center">
			<td><%=rowNumber%></td>
			<td style="text-overflow : ellipsis;overflow : hidden;"><nobr>
			<a href="viewBoard.jsp?seq=<%=board_seq%>&id=<%=id%>"><%=board_Title%></a></nobr></td>
			<td><%=board_Writer%></td>
			<td><%=board_time%></td>
		</tr>
	</tbody>
<% 
			}
			rs.close();
			pstmt.close();
			conn.close();
			} catch (SQLException e) {
				System.out.println(e.getMessage());
			} finally {
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
</table>
	<hr/>
	<input type="button" value="글 작성" onclick="btn_Insert();" class="btn btn-primary pull-right">
	<div class ="text-center">
		<ul class = "pagination">
		<%
			if(pg>BLOCK){
		%>
			<li><a href="#">◀◀</a></li>
			<li><a href="#">◀</a></li>
		<%
			}
		%>
		<%
			for(int i = startPage; i<=endPage; i++){
				if( i == pg){
		%>
			<li><a href="#"><%=i %></a></li>
		<%
				}else{
		%>
			<li><a href="noticeBoard.jsp?pg=<%=i%>"><%=i%></a></li>
		<%
				}
			}
		%>
		<%
			if (endPage < allPage){
		%>
			<li><a href="noticeBoard.jsp?pg=<%=endPage + 1%>">▶</a></li> 
 			<li><a href="noticeBoard.jsp?pg=<%=allPage%>">▶▶</a></li>
 		<%
			}
 		%>
		</ul>
	</div>
</div>
<div class="bg" style="bottom:0px;">
</div>

</body>
<script>
	function btn_Insert(){
		
		location.href="insertBoard.jsp";
	}
</script>
</html>