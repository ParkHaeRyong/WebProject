<%@ page session="true" import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<% String id = request.getParameter("id"); %>
<% session.setAttribute("id", id); %>
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<meta name = "viewport" content = "width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel = "stylesheet" href="css/bootstrap.css">
<link href="css2/bootstrap.min.css" rel="stylesheet">
<link href="css2/jquery.bxslider.css" rel="stylesheet">
<link href="css2/style.css" rel="stylesheet">    
<script language = "javascript">
function fn_addSche(year, month, day){
	var year = year;
	var month = month;
	var day = day;
	var date = year + '.' + month + '.' + day + '일정추가';
	document.addScheduleForm.date.value = date;
	document.addScheduleForm.year.value = year;
	document.addScheduleForm.month.value = month;
	document.addScheduleForm.day.value = day;
	
	$('#scheduleDiv').show();
}

function fn_ajaxCalendar(c_key, year, month, day){
	
	$.ajax({
		url : 'editSchedule.jsp',
		data : {c_key:c_key, year:year, month:month, day:day },
		dataType : 'html',
		type : 'GET',
		success : function(data){
			$('#detScheduleDiv').html(data);
		}
	});
	
	$('#detScheduleDiv').show();
}

$('#editSchedule').live('click',function(){
	alert();
});
</script>
<%
// Global Vars
int action = 0;  // incoming request for moving calendar up(1) down(0) for month
int currYear = 0; // if it is not retrieved from incoming URL (month=) then it is set to current year
int currMonth = 0; // same as year
String boxSize = "70";  // how big to make the box for the calendar

//build 2 calendars

Calendar c = Calendar.getInstance();
Calendar cal = Calendar.getInstance();

	if (request.getParameter("action") == null) // Check to see if we should set the year and month to the current
	{
		currMonth = c.get(c.MONTH);
		currYear = c.get(c.YEAR);
		cal.set(currYear, currMonth,1);
	}

	else
	{
		if (!(request.getParameter("action") == null)) // Hove the calendar up or down in this if block
		{
			currMonth = Integer.parseInt(request.getParameter("month"));
			currYear = Integer.parseInt(request.getParameter("year"));

				if (Integer.parseInt( request.getParameter("action")) == 1 )
				{
					cal.set(currYear, currMonth, 1);
					cal.add(cal.MONTH, 1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
				else
				{
					cal.set(currYear, currMonth ,1);
					cal.add(cal.MONTH, -1);
					currMonth = cal.get(cal.MONTH);
					currYear = cal.get(cal.YEAR);
				}
		}
	} 
%>

<%!
    public boolean isDate(int m, int d, int y) // This method is used to check for a VALID date
    {
        m -= 1;
        Calendar c = Calendar.getInstance();
        c.setLenient(false);

        try
        {
                c.set(y,m,d);
                java.util.Date dt = new java.util.Date();
                dt = c.getTime();
        }
          catch (IllegalArgumentException e)
        {
                return false;

        }
                return true;
    }
%>
<%!
   public String getDateName (int monthNumber) // This method is used to quickly return the proper name of a month
   {
		String strReturn = "";
		switch (monthNumber)
		{ 
	case 0:
		strReturn = "01";
		break;
	case 1:
		strReturn = "02";
		break;
	case 2:
		strReturn = "03";
		break;
	case 3:
		strReturn = "04";
		break;
	case 4:
		strReturn = "05";
		break;
	case 5:
		strReturn = "06";
		break;
	case 6:
		strReturn = "07";
		break;
	case 7:
		strReturn = "08";
		break;
	case 8:
		strReturn = "09";
		break;
	case 9:
		strReturn = "10";
		break;
	case 10:
		strReturn = "11";
		break;
	case 11:
		strReturn = "12";
		break;
	}
	return strReturn;
    }
%>
<html>
<body>
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
<h1 class="text-center">일정</h1><br>
<table style="margin-left: auto; margin-right: auto;">
  <tr>
	<td width='150' align='right' valign='middle'><a href="calendar.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=0"><font size="1"><<</font></a></td>
	<td width='260' align='center' valign='middle'><b><%= cal.get(cal.YEAR) + " . " + getDateName (cal.get(cal.MONTH))%></b></td>
	<td width='173' align='left' valign='middle'><a href="calendar.jsp?month=<%=currMonth%>&year=<%=currYear%>&action=1"><font size="1">>></font></a></td>
  </tr>
</table>

<table style="margin-left: auto; margin-right: auto;">
  <td width="100%">
    <table  border="2" width="519" bordercolorlight="#C0C0C0" bordercolordark="#000000" style="border-collapse: collapse" bordercolor="#000000" cellpadding="0" cellspacing="0" bgcolor="#DFDCD8">
  	<tr>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
    		<font color="#FFFFFF"><b>Sun</b></font></td>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
    		<font color="#FFFFFF"><b>Mon</b></font></td>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
    		<font color="#FFFFFF"><b>Tue</b></font></td>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
   		<font color="#FFFFFF"><b>Wed</b></font></td>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
    		<font color="#FFFFFF"><b>Thu</b></font></td>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
    		<font color="#FFFFFF"><b>Fri</b></font></td>
    		<td width="<%=boxSize%>" align="center" nowrap bordercolor="#666666" bgcolor="#666666">
    		<font color="#FFFFFF"><b>Sat</b></font></td>
  	</tr>
<%

//'Calendar loop


	int currDay;
	String todayColor;
	int count = 1;
	int dispDay = 1;


	for (int w = 1; w < 7; w++)
	{
%>
  	<tr>
<% 
  		for (int d = 1; d < 8; d++)
		{
			if (! (count >= cal.get(c.DAY_OF_WEEK)))
			{ 

%>
		<td width="<%=boxSize%>" height="<%=boxSize%>" valign="top" align="left">&nbsp;</td>
<%
				count += 1;
			} 
			else
			{
				if (isDate ( currMonth + 1, dispDay, currYear) ) // use the isDate method
				{ 
					Class.forName("com.mysql.jdbc.Driver");
					Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test","test","123456");
					Statement stat = conn.createStatement();
					ResultSet rs = stat.executeQuery("select * from schedule where year ='"+ cal.get(cal.YEAR)+"' and month ='"+getDateName (cal.get(cal.MONTH))+"' and day ='"+dispDay+"';");
					
					
					
					if ( dispDay == c.get(c.DAY_OF_MONTH) && c.get(c.MONTH) == cal.get(cal.MONTH) && c.get(c.YEAR) == cal.get(cal.YEAR)) // Here we check to see if the current day is today
        				{
							todayColor = "#6C7EAA";
						}
						else
						{
							todayColor = "#ffffff";
						}
%> 
		<td bgcolor ="<%=todayColor%>" width="<%=boxSize%>" align="left" height="<%=boxSize%>" valign="top"><a href="#" onclick="javascript:fn_addSche(<%= cal.get(cal.YEAR)%>, <%=getDateName (cal.get(cal.MONTH))%>, <%=dispDay%>);"><%=dispDay%>&nbsp;</a><br>
		<%
		while(rs.next()){
			String title = rs.getString("title");
			String c_key = rs.getString("c_key");
		%>
		<a href="#" onclick="javascript:fn_ajaxCalendar(<%=c_key%>, <%= cal.get(cal.YEAR)%>, <%=getDateName (cal.get(cal.MONTH))%>, <%=dispDay%>);"><%=title %></a><br>
		<%
		}
		conn.close();
		stat.close();
		rs.close();
		%>
		</td>
<%
					count += 1;
					dispDay += 1;
				}
				else
				{
%>
		<td width="<%=boxSize%>" align="left" height="<%=boxSize%>" valign="top">&nbsp;</td>
<% 
				} 
			}

       } 
%>
  	</tr> 
<% 
}
%>
</table><br>

<div class="text-center" id="scheduleDiv" style="display:none;">
<form name="addScheduleForm" id="addScheduleForm" action="/webProject/editSchedule" method="post">
	<table>
		<tbody>
			<tr>
				<td></td>
				<td><input type="text" id="date" name="date" style="border:none;" readonly></td>
			</tr>
			<tr>
				<td>제목</td>
				<td><input type="text" id="title" name="title" ></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="2" class="view_text"><textarea rows="6" cols="62" title="내용" id="contents" name="contents"></textarea></td>
			</tr>
		</tbody>
	</table><br>
	
	<input type="hidden" name="year">
	<input type="hidden" name="month">
	<input type="hidden" name="day">
	
	<input type="submit" value="등록">
	<input type="button" value="닫기" onclick="$('#scheduleDiv').hide();">
</form>
</div>

<div class="text-center" id="detScheduleDiv"></div>

</body>
</html>
