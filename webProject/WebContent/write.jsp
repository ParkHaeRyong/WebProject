<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	int grade = Integer.parseInt(request.getParameter("grade"));
	String id = request.getParameter("id");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<script type="text/javascript">
	function writeChk() {

		var form = document.writeform;

		if (!form.title.value) {
			alert("제목을 입력해주세요");
			form.title.focus;
			return;
		}
		if (!form.memo.value) {
			alert("내용을 입력해주세요");
			form.memo.focus;
			return;
		}
		form.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판</title>
</head>
<body>
	<form name="writeform" method="post" enctype="multipart/form-data" action="write_ok.jsp?id=<%=id%>&grade=<%=grade%>">
		<table>

			<tr>
				<td>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr>
							<td width="5"></td>
							<td align="center">글쓰기</td>
							<td width="5"></td>
						</tr>
					</table>
					<table>
						<tr>
							<td></td>
							<td align="center">제목</td>
							<td><input name="title" size="50" maxlength="25"></td>
							<td></td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr>
							<td></td>
							<td align="center">카테고리</td>
							<td><span class="selectCondition"><select name="sc">
							<option value="1">A</option>
							<option value="2">B</option>
							<option value="3">C</option>
							</select>
							</span>
							<td></td>
							<td></td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr>
							<td></td>
							<td align="center">아이디</td>
							<td><input name="name" size="50" maxlength="5" value=<%=id%>
								readonly="readonly"></td>
							<td></td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr>
							<td></td>
							<td align="center">파일첨부</td>
							<td><input type="file" id="FILE_TAG" name="FILE_TAG">
								
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td align="center">내용</td>
							<td><textarea name="memo" rows="13" cols="50"></textarea>
							<td></td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4"></td>
						</tr>
						<tr align="center">
							<td></td>
							<td colspan="2"><input type="button" value="등록"
								Onclick="writeChk()"> <input type="button" value="취소"
								Onclick="javascript:history.back(-1)">
							<td></td>
						</tr>
					</table>
				</td>

			</tr>

		</table>
	</form>
</body>

</html>