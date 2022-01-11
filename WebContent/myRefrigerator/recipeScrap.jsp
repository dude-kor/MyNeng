<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myRef.board.NengCipeDAO" %>
<%@ include file = "../menu.jsp" %>

<% request.setCharacterEncoding("UTF-8");
if (id == null || id == "") {%>
	<script>
		alert("아이디의 세션이 종료 되어\n로그인 화면으로 돌아갑니다.");
		window.location = "<%=request.getContextPath()%>/main.jsp";
	</script>
<%}	
	String validation = "";
	System.out.println("recipeScrap.jsp 실행 완료-----------------------------------------------------");
	String pageNum = request.getParameter("pageNum");
	System.out.println("pageNum의 값 : "+pageNum);
	
	String comment_pageNum = request.getParameter("comment_pageNum");
	System.out.println("댓글 페이지 : "+comment_pageNum);
	if (comment_pageNum == null || comment_pageNum =="null" || comment_pageNum =="") {
		comment_pageNum = "1";
		System.out.println("null값 캐치 된 comment_pageNum의 값 : "+comment_pageNum);
	}
	
	String comment_num = request.getParameter("comment_num");
	System.out.println("comment_num의 값 : "+comment_num);
	
	validation = request.getParameter("num");
	System.out.println("num의 값 : "+validation);
	int num = Integer.parseInt(validation);
	
	validation = request.getParameter("random_id");
	System.out.println("random_id의 값 : "+validation);
	int random_id = Integer.parseInt(validation);
	if(session.getAttribute("validation") != null){
		random_id = (int) session.getAttribute("random_id");
	}
   	
	String alert = "";    	
	NengCipeDAO dao = new NengCipeDAO();
   	// 찜 버튼을 누르면 -> id_scrap 테이블(id마다 달라짐)에 num(rec_id)를 추가
   	if(!dao.isScrap(id, num)){
   		dao.setScrap(id, num);
		alert = "찜 목록에 추가되었습니다."; 
   	}else{	
		dao.cancleScrap(id, num); 
		alert = "찜 목록에서 제외되었습니다.";	
	}
%>
<script>
var war = "<%=alert%>";
	alert(war);
	window.location = "recipe.jsp?pageNum=<%=pageNum%>&comment_pageNum=<%=comment_pageNum%>&comment_num=0&num=<%=num%>&random_id=0";
</script>
