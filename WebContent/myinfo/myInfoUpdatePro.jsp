<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.bean.MemberDTO" %>
<%@ page import="member.bean.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="member.bean.MemberDTO" />
<jsp:setProperty property="*" name="dto" />

<% 

	String id = (String)session.getAttribute("memId");
	dto.setId(id);
	MemberDAO dao = new MemberDAO();
	dao.updateMember(dto);
%>	
	<script>
	alert("수정되었습니다.");
	window.location='/myneng/main.jsp';
	</script>
	




