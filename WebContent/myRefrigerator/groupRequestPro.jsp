<%@page import="member.bean.MemberDTO"%>
<%@page import="member.bean.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../menu.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String g_id = request.getParameter("g_id");
	String g_pw = request.getParameter("g_pw");
	MemberDAO dao = new MemberDAO(); 
	MemberDTO dto = dao.getRefrigerator(g_id);
	
	if(dto == null){ %>
		<script>
			alert("존재하지 않는 회원입니다.");
			history.go(-1);
		</script>	
		 
	<%}else{
		boolean check = dao.certifyPw(g_id, g_pw);
		if(!check) { %>
			<script>
				alert("인증번호가 잘못되었습니다.");
				history.go(-1);
			</script>	
			
	<%
		} else {%>
			<script>
			if(confirm(<%=dto.getName()%> + "님의 그룸에 들어가시겠습니까?")) {
				</script>
			<%		
			
			dao.changeRefri((String)session.getAttribute("memId"), dto);
			response.sendRedirect("/myneng/myRefrigerator/update.jsp");
			%>
			<script>
			} else {
				history.go(-1);
			}
			</script>
	
	
		
	<%}}%>