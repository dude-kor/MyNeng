<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myRef.board.NengCipeDAO" %>
<%@ include file = "../menu.jsp" %>

    <% 
    	int num = Integer.parseInt(request.getParameter("num"));
    	
    	NengCipeDAO dao = new NengCipeDAO();
    	dao.reccRecipe(num); 	 
    %>
    <script>
    	alert("추천되었습니다");
    	history.go(-1);
    </script>