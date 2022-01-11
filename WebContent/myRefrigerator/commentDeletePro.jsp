<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myRef.Comment.CommentDAO" %>
<%@ page import="myRef.board.NengCipeDAO" %>
    
<% 	request.setCharacterEncoding("UTF-8"); 
	String id = (String) session.getAttribute("memId");
	String validation = "";
	System.out.println("commentDeletePro.jsp 실행 완료--------------------------");
	
	String pageNum = request.getParameter("pageNum"); 
    System.out.println("pageNum의 값 : "+pageNum);
	
	validation = request.getParameter("comment_num");
	System.out.println("comment_num의 값 : "+validation);
	int comment_num = Integer.parseInt(validation);
	
	validation = request.getParameter("num");
    int num = Integer.parseInt(validation);
    System.out.println("num의 값 : "+num);
	
	String comment_pageNum = request.getParameter("comment_pageNum");
	System.out.println("comment_pageNum의 값 : "+comment_pageNum);
    if (comment_pageNum == null) {
    	comment_pageNum = "1";
    }
	
	NengCipeDAO dao = new NengCipeDAO();
	CommentDAO daorc = new CommentDAO();
	String comment_id = daorc.getRecipeComment_id(num, comment_num);
	System.out.println("comment_id의 값 : "+comment_id);
	int master = dao.getMemberMaster(id);
	System.out.println("master의 값 : "+master);
	System.out.println("id의 값 : "+ id);
	if(comment_id.equals(id) || master ==2){
		daorc.deleteRecipeComment(num, comment_num);
		System.out.println("실행 완료");
	}%>
<script>
	alert("댓글이 삭제되었습니다.");
	window.location="recipe.jsp?pageNum=<%=pageNum%>&comment_pageNum=<%=comment_pageNum%>&comment_num=0&num=<%=num%>&random_id=0";
</script>
