<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 부트스트랩 사용하기 위해 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>게시판 글쓰기 페이지</title>
</head>
<body>
<form name = "writeform" method = "post"  action="write_ok.jsp" enctype="multipart/form-data">
	<input type="hidden" name="id" value="<%=session.getAttribute("id")%>">
<div class="container">
  <h2>게시판 글쓰기</h2>          
  <table class="table table-hover">
    <tbody>
      <tr>
      	<td>
      		<input type="text" class="form-control"  name="title" maxlength="40" placeholder="글 제목">
      	</td>
      </tr>
      <tr>
      	<td>
      		<textarea class="form-control" placeholder="글 내용을 작성하세요" name="content" maxlength="1024" style="height: 400px;"></textarea>
      		</td>
      </tr>
      <tr>
      	<td>
      		<input type="file" name="uploadFile">
      	</td>
      </tr>
    </tbody>
  </table>
    <input type=button class="btn btn-primary pull-right" value="취소" onclick = "javascript:history.back(-1)">
  	<input type=button class="btn btn-primary pull-right" value="등록" onclick = "javascript:writeCheck();">
</div>
</form>

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
		 if(!form.uploadFile.vlaue){
			 form.submit();
		 }
		 form.submit();
	}
</script>
</html>
