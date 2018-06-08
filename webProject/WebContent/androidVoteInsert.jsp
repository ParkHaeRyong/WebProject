<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="webProject.DAO" %>
<%@ page import="webProject.Vo" %> 
<%
	String param = request.getParameter("param");
	
	try {
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObj = (JSONObject) jsonParser.parse(param);
	
		String chk = (String)jsonObj.get("chk");
		String title = (String)jsonObj.get("title");
	
		System.out.println("CHK =="+chk+"title=="+title);
	
	
		
	}catch (Exception e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
} 



 %>