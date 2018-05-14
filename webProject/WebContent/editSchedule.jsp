<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Schedule</title>
</head>
<script type="text/javascript">
function fn_rollback(){
	history.back();
}
</script>
<body>
<%
String c_key = request.getParameter("c_key");
String year = request.getParameter("year");
String month = request.getParameter("month");
String day = request.getParameter("day");

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.1.158:3306/test","test","123456");
Statement stat = conn.createStatement();
ResultSet rs = stat.executeQuery("select * from schedule where c_key ='"+c_key+"';");

String title = "";
String contents = "";

if(rs.next()){
	title = rs.getString("title");
	contents = rs.getString("contents");
}

%>
<form name="scheduleForm" id="scheduleForm" action="/webProject/editSchedule" method="post">
	<table>
		<h2><%=year %>.<%=month %>.<%=day %> 일정상세</h2>
		<tbody>
			<tr>
				<td>제목 : </td>
				<td><%=title %></td>
			</tr>
			<tr>
				<td>내용 : </td>
				<td colspan="2" class="view_text"><%=contents %></td>
			</tr>
		</tbody>
	</table>
	
	<input type="hidden" name="" value="<%=year %>">
	<input type="hidden" name="year" value="<%=year %>">
	<input type="hidden" name="month" value="<%=month %>">
	<input type="hidden" name="day" value="<%=day %>">
	
	<input type="button" value="닫기" onclick="$('#detScheduleDiv').hide();">
</form>

<%
conn.close(); 
stat.close();
rs.close();

%>
</body>
</html>