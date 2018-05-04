<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*" %>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<%
	
	request.setCharacterEncoding("UTF-8"); //받아오는 값들을 한글로 인코딩합니다.
	
	String id = (String)session.getAttribute("id");
	
	// 10Mbyte 제한
    int maxSize  = 1024*1024*10;       
    // 웹서버 컨테이너 경로
    String root = request.getSession().getServletContext().getRealPath("/");
    // 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
    String savePath = root + "upload/";
    // 업로드 파일명
    String uploadFile = "";
    // 실제 저장할 파일명
    String newFileName = "";
 
    int read = 0;
    byte[] buf = new byte[1024];
    FileInputStream fin = null;
    FileOutputStream fout = null;
    long currentTime = System.currentTimeMillis(); 
    SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss"); 
    try{
        MultipartRequest multi = new MultipartRequest(request, savePath, maxSize, "UTF-8", new DefaultFileRenamePolicy());
        // 전송받은 parameter의 한글깨짐 방지
        String board_Title = multi.getParameter("title");
		String board_Content = multi.getParameter("content");
        // 파일업로드
       
        // 실제 저장할 파일명(ex : 20140819151221.zip)
       
        Class.forName("com.mysql.jdbc.Driver");
    	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.100.65:3306/test" , "test", "123456");  
		
		String sql = "INSERT INTO board(board_Writer,board_Title,board_Content,board_Time,board_delcode) VALUES(?,?,?,now(),0)";
		PreparedStatement pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, id);
		pstmt.setString(2, board_Title);
		pstmt.setString(3, board_Content);
		
		pstmt.execute();
		pstmt.close();
		
		if(multi.getFilesystemName("uploadFile") != null){
			 newFileName = simDf.format(new Date(currentTime)) +"."+ uploadFile.substring(uploadFile.lastIndexOf(".")+1);
		        // 업로드된 파일 객체 생성
		        File oldFile = new File(savePath + uploadFile);
		        // 실제 저장될 파일 객체 생성
		        File newFile = new File(savePath + newFileName);
		        // 파일명 rename
		        if(!oldFile.renameTo(newFile)){
		            // rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제
		            buf = new byte[1024];
		            fin = new FileInputStream(oldFile);
		            fout = new FileOutputStream(newFile);
		            read = 0;
		            while((read=fin.read(buf,0,buf.length))!=-1){
		                fout.write(buf, 0, read);
		            }
		            fin.close();
		            fout.close();
		            oldFile.delete();
		        }
		        
			String fileSql = "INSERT INTO file (fileName, originalFilename, savePath, board_seq) VALUES(?,?,?,last_insert_Id())";
			PreparedStatement pstmt1 = conn.prepareStatement(fileSql);
			
			pstmt1.setString(1, newFileName); 
			pstmt1.setString(2, uploadFile);
			pstmt1.setString(3, savePath);
			
			pstmt1.execute();
			pstmt1.close();
			conn.close();
		}
    }catch(Exception e){
        e.printStackTrace();
    }
%>
<script>
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="noticeBoard.jsp"; 
</script>

