<%@page import="member.bean.ManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@include file="../menu.jsp" %>
<head>
<style>
.box {
	display: inline-block;
	margin: 5px;
	margin-botton: 20px;
	padding: 3px;
	text-align:center;
	vertical-align: middle;
}

table {
	border-collapse : collapse;
	border-spacing : 30px;
}

td, tr, th{
	border : 1px solid black;
	background-color:#eae4dc;
}

th{
	margin-top: 20px;
}
#frame {
	padding-left: 30px;
	padding-right:30px;
}
</style>
</head>
<body bgcolor="#f0efea">
    <div id="frame">
    <%
    ManagerDAO dao = new ManagerDAO();
    List <String> groups = dao.getGrooupId();
    for(int i = 0; i < groups.size(); i++) {
		%>
		<table class="box">
		<tr background-color="#eae4dc"><th width="170px"><%=groups.get(i) %></th></tr>
		<%
    	List <String> members = dao.getGroupMember(groups.get(i));
    	for(int j = 0; j < members.size(); j++) {    	
    		%>
    		<tr background-color="#eae4dc"><td width="170px">
    		<%=members.get(j) %>
    		</td></tr>
    		<%
    	}
    	%>
		</table>
		<%
    }
    %>
    </div>
    </body>