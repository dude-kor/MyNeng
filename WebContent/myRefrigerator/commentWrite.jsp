<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%
	request.setCharacterEncoding("UTF-8");	
	String id = (String)session.getAttribute("memId");
if (id == null || id == "") {%>
	<script>
		alert("아이디의 세션이 종료 되어\n로그인 화면으로 돌아갑니다.");
		window.location = "<%=request.getContextPath()%>/main.jsp";
	</script>
<%}
	String validation = "";
	System.out.println("commentWrite.jsp--------------------------");
	
	String pageNum = request.getParameter("pageNum");
    System.out.println("pageNum의 값 : "+pageNum);
	
	validation = request.getParameter("comment_num");
	System.out.println("댓글 수 : "+validation);
	int comment_num = Integer.parseInt(validation);
	
	validation = request.getParameter("num");
    int num = Integer.parseInt(validation);
    System.out.println("num의 값 : "+num);
	
    String comment_pageNum = request.getParameter("comment_pageNum");
	System.out.println("comment_pageNum : "+comment_pageNum);
	if (comment_pageNum == null || comment_pageNum =="null" || comment_pageNum =="") {
		comment_pageNum = "1";
		System.out.println("null값 캐치 된 comment_pageNum의 값 : "+comment_pageNum);
	}%>
<body>
<div class="center">
<form method="post" name="comment_text" action="commentWritePro.jsp">
<input type="hidden" name="comment_id" value="<%=id%>"><%=id%>
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="comment_num" value="0">
<input type="hidden" name="comment_pageNum" value=<%=comment_pageNum%>>
<textarea cols = "70" rows = "10" name="comment_text"></textarea>
<input type="submit" value="댓글 등록">
</form>
</div>
</body>