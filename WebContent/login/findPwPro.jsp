<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="member.bean.MemberDAO" %>
<style>
	.bt{ 
		font-size:20px;
		cursor: pointer;
		text-align: center;
    	background: #808080;
		outline: none;
		border: none;
		color:#ffffff;
		width: 200;	
		padding: 10px;
		margin-right:-1px;
		margin-left:-1px;
		
		}

</style>
<%request.setCharacterEncoding("UTF-8");%>
<%
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	
	MemberDAO dao = new MemberDAO();

	String pw = dao.findPw(id, name, email);
	boolean masterCheck = dao.masterCheck(id); 

	if(pw!=null){
	
%>

<center>
<input class="bt" type="button" value="아이디 찾기" onclick="window.location='findId.jsp'" />
	<input class="bt" type="button" value="비밀번호 찾기" onclick="window.location='findPw.jsp'" />
	<h2>비밀번호 찾기</h2>
<h5>회원가입시 사용한 비밀번호는<%=pw%> 입니다.</h5>
<input type="button" value="닫기" onclick="self.close();" />
</center>
<%}else if(masterCheck){%>
<script>
	alert("탈퇴한 회원입니다.");
	history.go(-1);
</script>

<%}else{%>
<script>
	alert("잘못된 정보입니다.");
	history.go(-1);
</script>

<%}%>