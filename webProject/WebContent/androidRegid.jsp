<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ page import="webProject.DAO" %>
<%@ page import="webProject.Vo" %>  
<%
	String ID = request.getParameter("param");
	
	Vo vo = new DAO().regId(ID);
	
	if(vo!=null && vo.getID().equals(ID)){
	 	out.print("true");
	}else{
		out.print("false");
	} 
%>    
