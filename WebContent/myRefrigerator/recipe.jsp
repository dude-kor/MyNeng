<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="myRef.board.NengCipeDTO" %>
<%@ page import="myRef.board.NengCipeDAO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="myRef.board.NengDAO" %>
<%@ page import="myRef.board.NengDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ include file = "../menu.jsp" %>
<link href="form.css" rel="stylesheet" type="text/css">
<body bgcolor="#f0efea">
<%	request.setCharacterEncoding("UTF-8");	
if (id == null || id == "") {%>
	<script>
		alert("아이디의 세션이 종료 되어\n로그인 화면으로 돌아갑니다.");
		window.location = "<%=request.getContextPath()%>/main.jsp";
	</script>
<%}
	String validation = "";
	System.out.println("recipe.jsp 실행 완료--------------------------");
	
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
	
	NengCipeDAO dao = new NengCipeDAO();
	NengDAO daoc = new NengDAO();
	
	dao.readCount(num);	
	int memberMaster = dao.getMemberMaster(id);
	NengCipeDTO recipe = dao.getRecipes(num);
	
	List <NengDTO> ingList = daoc.getIng(num);  
	boolean scrap = dao.isScrap(id, num);%>
<div class = "center">
<form name = "f2">
<table>
<tr>
	<td colspan="4">
<%if(recipe.getImage() == null){%>
			사진이 등록되지 않았습니다. <br />
<%}else{%>
		<img src="<%=request.getContextPath()%>/recipeSave/<%=recipe.getImage()%>"/> <br />
<%}%>
	</td>
</tr>	
<tr>
	<td>요리명</td>
	<td><%=recipe.getName() %></td>
	<td>작성자</td>
	<td><%=recipe.getWriter() %></td>					
</tr>
<tr>
	<td>재료</td>
	<td colspan="3">
<%for(int i = 0; i < ingList.size(); i++){
	NengDTO ing = (NengDTO) ingList.get(i);%>
	<%=ing.getIng_name() %> <%=ing.getAmount() %> <%=ing.getUnit() %> <br />
<%}%>
	</td>
</tr>
<tr>
	<td>요리시간</td>
	<td><%=recipe.getCooking_time()%> 분</td>
	<td>요리난이도</td>
	<td><%=recipe.getDifficulty() %></td>
</tr>
<tr>
	<td colspan="4" style = "word-break:breakall"><%=recipe.getProcess()%></td>
</tr>
</table>
<input type="button" value="추  천" onclick="javascript:recipeRec();"/>
<%if (memberMaster == 0 && recipe.getStatus() == 2){
	if(!scrap){%>
		<input type="button" value="  찜  " onclick="javascript:recipeScrap();" />
<%	}else{%>
		<input type="button" value="찜해제" onclick="javascript:recipeScrap();" />
<%	}
}%>
<input type="button" value="목  록" onclick="javascript:recipeReturn();" /><br/>
<input type="hidden" id = "pageNum" name ="pageNum" value ="<%=pageNum%>">
<input type="hidden" id = "comment_pageNum" name ="comment_pageNum" value ="<%=comment_pageNum%>">
<input type="hidden" id = "num" name ="num" value ="<%=num%>">
<input type="hidden" id = "comment_num" name ="comment_num" value ="<%=comment_num%>">
<input type="hidden" id = "random_id" name ="random_id" value = "<%=random_id%>">
</form>
</div>
<%if(recipe.getStatus() == 2){%>
	<jsp:include page="comment.jsp">
		<jsp:param name="num" value="<%=num%>" />
		<jsp:param name="pageNum" value="<%=pageNum%>" />
		<jsp:param name="comment_pageNum" value="<%=comment_pageNum%>" />  
		<jsp:param name="comment_num" value="<%=comment_num%>" />
	</jsp:include>
	<jsp:include page="commentWrite.jsp">   
		<jsp:param name="num" value="<%=num%>" />
		<jsp:param name="pageNum" value="<%=pageNum%>" />
		<jsp:param name="comment_pageNum" value="<%=comment_pageNum%>" />
		<jsp:param name="comment_num" value="<%=comment_num%>" />
	</jsp:include>
<%}%>
</body>
<script>
function recipeRec(){
	document.f2.action = "recipeRec.jsp";
	document.f2.submit();
}

function recipeScrap(){
	document.f2.action = "recipeScrap.jsp";
	document.f2.submit();
}

function recipeReturn(){
	document.f2.action = "mixList.jsp";
	document.f2.submit();
}
</script>
