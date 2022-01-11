<%@page import="member.bean.ManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../menu.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String g_name = request.getParameter("ing_name");
	ManagerDAO dao = new ManagerDAO();
	if(!dao.checkIng(g_name)){
		dao.addIngredient(g_name);
		response.sendRedirect("addIng.jsp");
		%>
		<script>
			alert("추가가 완료되었습니다.");
		</script>
<%
	} else {
		%>
		<script>
			alert("이미 존재하는 재료입니다.");
			history.go(-1);
		</script>
<%	}
	%>