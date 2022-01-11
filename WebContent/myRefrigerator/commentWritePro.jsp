<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myRef.Comment.CommentDAO" %>
<%@ page import="java.sql.Timestamp" %>
 
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="comment" class="myRef.Comment.CommentDTO" />
<jsp:setProperty name="comment" property="*" />

<%	String validation ="";
	System.out.println("commentWritePro.jsp--------------------------");
	
	String pageNum = request.getParameter("pageNum");
	System.out.println("pageNum의 값 : "+pageNum);
	
	validation = request.getParameter("comment_num");
	System.out.println("댓글 수 : "+validation);
	int comment_num = Integer.parseInt(validation);
	
	validation = request.getParameter("num");
	int num = Integer.parseInt(validation);
	System.out.println("num의 값 : "+num);
	
	String comment_pageNum = request.getParameter("comment_pageNum");
	System.out.println("댓글 페이지 : "+comment_pageNum);
	if (comment_pageNum == null || comment_pageNum =="null" || comment_pageNum =="") {
		comment_pageNum = "1";
		System.out.println("null값 캐치 된 comment_pageNum의 값 : "+comment_pageNum);
	}
	
	comment.setReg_date(new Timestamp(System.currentTimeMillis()));
	
	String alert = "댓글을 입력해주세요.";
	
	CommentDAO daorc = new CommentDAO();
	if(!comment.getComment_text().equals(" ")){
		if(comment_num == 0){
			daorc.insertRecipeComment(comment);
		}else{
			comment_num = Integer.parseInt(request.getParameter("comment_num"));
			daorc.insertRecipeComment(comment, comment_num);
		}
		alert = "댓글이 입력되었습니다.";
	}%>
<script>
	alert('<%=alert%>');
	window.location="recipe.jsp?pageNum=<%=pageNum%>&comment_num=0&num=<%=num%>&random_id=0&comment_pageNum=<%=comment_pageNum%>";
</script>