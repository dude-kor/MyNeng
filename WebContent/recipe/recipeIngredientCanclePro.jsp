<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="cook.bean.CookDAO" %>

<% 
	String id = (String) session.getAttribute("memId");

	int rec_id = Integer.parseInt(request.getParameter("rec_id"));
	int random_id = (int) session.getAttribute("random_id");
	
	CookDAO daoc = new CookDAO();
	
	daoc.cancleIng(random_id);							// 수정한 재료 취소
	daoc.changeRec_id(random_id+1000000, rec_id);		// 삭제한 재료 취소
%>
 
<script>
	alert("재료를 수정한 내용이 취소되었습니다.");
	window.location = "recipeIngredientUpdateForm.jsp?num=<%=rec_id %>&random_id=<%=random_id %>";
</script>