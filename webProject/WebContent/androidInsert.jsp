<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="webProject.DAO" %>
<%@ page import="webProject.Vo" %> 
<%
	String param = request.getParameter("param");
	String ip = request.getLocalAddr();
	String port = "10002";
	System.out.println(param+ip+port);
	try {
    
	JSONParser jsonParser = new JSONParser();
    JSONObject jsonObj = (JSONObject) jsonParser.parse(param);
    
    String ID = (String)jsonObj.get("ID");
    String PWD = (String)jsonObj.get("PWD");
    String NAME = (String)jsonObj.get("NAME");
    
    
    DAO dBDAO = new DAO();
    	int result = dBDAO.addMember(ID, PWD, NAME, ip, port);
	if(result!=0){
		out.print("ok");
	}else{
		out.print("false");
	}
    
    System.out.println(jsonObj.get("ID"));
    System.out.println(jsonObj.get("PWD"));
    System.out.println(jsonObj.get("NAME"));

    
    /*  JSOn 배열 
     	
    	for(int i=0 ; i<memberArray.size() ; i++){
        JSONObject tempObj = (JSONObject) memberArray.get(i);
        System.out.println(""+(i+1)+"번째 멤버의 이름 : "+tempObj.get("name"));
        System.out.println(""+(i+1)+"번째 멤버의 이메일 : "+tempObj.get("email"));
        System.out.println(""+(i+1)+"번째 멤버의 나이 : "+tempObj.get("age"));
        System.out.println("----------------------------");
    } */

} catch (Exception e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
} 



 %>