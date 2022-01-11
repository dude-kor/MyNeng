<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "myRef.Comment.CommentDTO" %>
<%@ page import = "myRef.Comment.CommentDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

<%	request.setCharacterEncoding("UTF-8");	
	String id = (String)session.getAttribute("memId");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
if (id == null || id == "") {%>
	<script>
		alert("아이디의 세션이 종료 되어\n로그인 화면으로 돌아갑니다.");
		window.location = "<%=request.getContextPath()%>/main.jsp";
	</script>
<%}
	String validation = "";
	System.out.println("comment.jsp 실행 완료--------------------------");
	
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
    if (comment_pageNum == null || comment_pageNum =="null" || comment_pageNum =="") {
    	comment_pageNum = "1";
    	System.out.println("null값 캐치 된 comment_pageNum의 값 : "+comment_pageNum);
    }
    
    int pageSize = 10;
    int currentPage = Integer.parseInt(comment_pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List<CommentDTO> commentList = null;
    CommentDAO dbPro =new CommentDAO();
    count = dbPro.getCommentCount(num);    
    if (count > 0) {
        commentList = dbPro.getComments(startRow, endRow, num);
        System.out.println("commentList 사이즈 : "+commentList.size());
    }

	number=count-(currentPage-1)*pageSize;%>
<html>
<head>
<title>게시판</title>
</head>
<body>
<b>댓글(전체 댓글:<%=count%>)</b>
<%if (count == 0) {%>
	<table>
		<tr>
    		<td>
    			게시판에 저장된 글이 없습니다.
    		</td>
    	</tr>
	</table>

<%} else {%>
<table>
<%	for(int i = 0 ; i < commentList.size() ; i++) {
    	CommentDTO comment = (CommentDTO)commentList.get(i);
    	int temp_comment_num = comment.getComment_num();
    	String level_space = "";
    	for(int a = 0; a < comment.getRe_level(); a++)
    	{
    		level_space = level_space + "&emsp;" + "&emsp;";
    	}%>
	<tr>
    	<td> 
    		<%=level_space%><%=comment.getComment_id()%></br>
    	 	<%=level_space%><%=comment.getComment_text()%><br>
    	 	<%=level_space%><%=sdf.format(comment.getReg_date())%></td>
    	 <td>
<%		if(comment_num != temp_comment_num || comment_num == 0){%>
   	 		<a href="recipe.jsp?pageNum=<%=pageNum%>&comment_num=<%=temp_comment_num%>&num=<%=num%>&random_id=0&comment_pageNum=<%=comment_pageNum %>">댓글달기</a>
<%		}else {%>
   	 		<a href="recipe.jsp?pageNum=<%=pageNum%>&comment_num=0&num=<%=num%>&comment_pageNum=<%=comment_pageNum %>&random_id=0">댓글달기</a>
<%		}%>    	 	
    	 </td>
<%		if(comment.getComment_id().equals(id)) {%>
    	 <td>
    	 	<a href="commentDeletePro.jsp?num=<%=num %>&pageNum=<%=pageNum %>&comment_pageNum=<%=comment_pageNum %>&comment_num=<%=temp_comment_num%>&random_id=0"
    	 	onclick="return confirm('댓글을 삭제하시겠습니까?');">
    	 	댓글삭제</a>
    	 </td>
<%		}else {%>
    		 <td>
    	 	</td>
<%		}%>
	</tr>
<%		if(comment_num == temp_comment_num)	{%>
			<tr>
				<td colspan="3">
				<form method="post" name="comment_text" action="commentWritePro.jsp" onsubmit="return writeSave()">
					<input type="hidden" name="comment_id" value="<%=id%>"><%=id%>
					<input type="hidden" name="pageNum" value=<%=pageNum%>>
					<input type="hidden" name="comment_num" value=<%=temp_comment_num%>>
					<input type="hidden" name="num" value="<%=num%>">
					<input type="hidden" name="comment_pageNum" value=<%=comment_pageNum%>>
					<textarea cols = "70" rows = "10" name="comment_text"></textarea>
				<input type="submit" value="댓글 등록"></br>
				</form></td>
			</tr>
<%		}
	}%>
</table>
<%}
if (count > 0) {
	int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);		 
    int startPage = (int)(currentPage/10)*10+1;
	int pageBlock=10;
    int endPage = startPage + pageBlock-1;
    if (endPage > pageCount) endPage = pageCount;
    if (startPage > 10) {    %>
  		<a href="recipe.jsp?pageNum=<%= pageNum %>&comment_num=0&num=<%=num %>&random_id=0&comment_pageNum=<%= startPage - 10 %>">[이전]</a>
<%  }
 	for (int i = startPage ; i <= endPage ; i++) {  %>
  		<a href="recipe.jsp?pageNum=<%= pageNum %>&comment_num=0&num=<%=num %>&random_id=0&comment_pageNum=<%= i %>">[<%= i %>]</a>
<%	}
  	if (endPage < pageCount) {  %>
  		<a href="recipe.jsp?pageNum=<%=pageNum %>&comment_num=0&num=<%=num %>&random_id=0&comment_pageNum=<%= startPage + 10 %>">[다음]</a>
<%	}
}%>
</body>
</html>