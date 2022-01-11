<%@page import="cook.bean.CookDAO"%>
<%@page import="cook.bean.CookDTO"%>
<%@page import="myRef.food.MaNengDataBean"%>
<%@page import="java.util.List"%>
<%@page import="myRef.food.MaNengDBBean"%>
<%@page import="recipe.bean.RecipeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.bean.ManagerDAO"%>
<%@ include file = "../menu.jsp" %>

<style>
.box {
	display: inline-block;
	padding-left:20px;
	text-align:center;
	vertical-align:middle;
}
#insert {
	margin-left:100px;
}
#list {
	width:200px;
	height:300px;
	overflow:scroll;
}
</style>

<body bgcolor="#f0efea">
<br/>

<div class="box" id="list">
<%
	ManagerDAO dao = new ManagerDAO();
	List<String> ing = dao.getIng();
	for(String i : ing) {
		%>
		<p><%=i %>
		<%
	}
	%>
</div>


<div class="box" id="insert">
<center>
	<h2 align="center">재료 추가</h2>
	<br/><br/>
    <form action="addIngPro.jsp" method="post">
    	<table align="center">
		<tr>
			<td>재료 이름</td>
			<td><input type ="text" name="ing_name" /> </td>
		</tr>

		
		<tr>
			<td rowspan="2"><input type="submit" value="추가"/></td>
		</tr>
    </form>
    </center>
    </div>
   </body> 