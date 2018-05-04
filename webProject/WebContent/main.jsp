<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<jsp:include page="calendar.jsp" flush="false" />
<%-- 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<title>Main</title>
<head>
<meta name="viewport" 
		content="width=device-width, initial-scale=1, maximum-scale=1" />
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name = "viewport" content = "width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css2/bootstrap.min.css" rel="stylesheet">
<link href="css2/jquery.bxslider.css" rel="stylesheet">
<link href="css2/style.css" rel="stylesheet">
<% String id = request.getParameter("id"); %>
<% session.setAttribute("id", id); %>
</head>

<script type="text/javascript">
function fn_ajaxCalendar(){
	$.ajax({
		url : 'calendar.jsp',
		method : 'GET',
		dataType : 'text',
		success : function(data){
			$('#calendarDiv').html(data);
		}
	});
}
</script>

<body>
	<header>
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container">
				<div id="navbar" class="collapse navbar-collapse">
					<ul class="nav navbar-nav">
						<li><a href="calendar.jsp">일정</a></li>
						<li><a href="noticeBoard.jsp">게시판</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<div id="calendarDiv" class="container"></div>
	
</body>
</html> --%>