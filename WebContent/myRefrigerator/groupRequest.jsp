<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file = "../menu.jsp" %>
<body bgcolor="#f0efea">
<br/>
	<h2 align="center">그룹 신청</h2>
	<br/><br/>
    <form action="groupRequestPro.jsp" method="post">
    	<table align="center">
		<tr>
			<td>그룹장 아이디</td>
			<td><input type ="text" name="g_id" /> </td>
		</tr>

		<tr>
			<td>인증번호</td>
			<td><input type ="group_pw" name="g_pw" /></td>
			
		</tr>
		
		<tr>
			<td rowspan="2"><input type="submit" value="신청"/></td>
		</tr>
    </form>
   </body>