<%@page import="member.bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	String id = (String)session.getAttribute("memId");
	MemberDAO dao = new MemberDAO();
	dao.quitGroup(id);
	response.sendRedirect("update.jsp"); 
	%>