<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="recipe.bean.RecipeDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="menu.jsp"/>
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/recipe/recipeBestList.jsp" />
<br />
<br />

<%	
	String id = (String) session.getAttribute("memId");
	RecipeDAO dao = new RecipeDAO();
	int master = dao.getMemberMaster(id); 		// 회원권한 조회
	if(master == 2){ %>
	<jsp:include page="/recipe/recipeNewList.jsp" />
<%	}else if(id != null){%>
	<jsp:include page="/myRefrigerator/refrigerator.jsp" />
<% 	}%>
</body>
</html>