<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="webProject.DAO" %>
<%@ page import="webProject.Vo" %>  
<%
	String ID = request.getParameter("ID");
	String PWD = request.getParameter("PWD");
	
	System.err.println(ID);
	System.err.println(PWD);
	
	Vo vo = new DAO().login(ID, PWD);
	
	if(vo != null){
		if(vo.getID()!=null && vo.getPWD()!=null  && vo.getTYPE()==0){
		out.print("true");
		}
	}else{
		out.print("false");
	}
	
%>
