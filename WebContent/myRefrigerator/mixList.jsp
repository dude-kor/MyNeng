<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="myRef.board.NengCipeDTO" %>
<%@ page import="myRef.board.NengCipeDAO" %>
<%@ include file = "../menu.jsp" %>
<link href="form.css" rel="stylesheet" type="text/css">
<body bgcolor="#f0efea">
<%	request.setCharacterEncoding("UTF-8");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
if (id == null || id == "") {%>
	<script>
		alert("아이디의 세션이 종료 되어\n로그인 화면으로 돌아갑니다.");
		window.location = "<%=request.getContextPath()%>/main.jsp";
	</script>	
<%}
if(session.getAttribute("random_id") != null){
		session.removeAttribute("random_id");			
	}
	
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
		pageNum = "1";
	}
	
	int pageSize = 10; 
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize; //
	int count = 0; // 전체게시물 수
	int number = 0; // 한 페이지에 보일 글 목록 수
	
	NengCipeDAO dao = new NengCipeDAO();
	
	List<NengCipeDTO> recipeList = null;
	List<Integer> recList = (List) session.getAttribute("recList");
	System.out.println(recList);
	int master = dao.getMemberMaster(id); 		// 회원권한 조회
	System.out.println("회원권한 : "+master);
	if (recList == null) {%>
	<script>
		alert("입력이 잘못 되었습니다! 해당 담당자에게 문의해주세요!");
		window.history.go(-1);
	</script>
<%}else{
	count = dao.getRecipeCount(recList, master, id); 	// 작성된 게시글 숫자
	System.out.println("count : "+count);
		if(count > 0){
			recipeList = dao.getRecipes(recList, startRow, endRow, master, id);
		}
	}
		
		number = count-(currentPage-1)*pageSize;
%>
<div class = "center">
<form name="f2" action="mixListSearch.jsp" method="post" >
	<select name="col">
		<option value="name||process||writer">전체</option>
		<option value="name">요리명</option>
		<option value="process">요리과정</option>
		<option value="writer">작성자</option>
	</select>
	<input type="hidden" id="search" name="search">
	<input type="text" id="keyword" /><input type="submit" value="검색" onclick="javascript:goSearch()"><br/>
<table>
<tr>
	<td >번 호</td>
	<td >요리명</td>
	<td >작성자</td>
	<td >작성일</td>
	<td >조 회</td>
	<td >추 천</td>
	<%
	if(master == 2) {
	%>
		<td >승 인</td>
	<%
	}
	%>
</tr>
<%
System.out.println("레시피 수 : "+recipeList.size());
for(int i = 0; i < recipeList.size(); i++){
	NengCipeDTO recipe = (NengCipeDTO)recipeList.get(i);
	System.out.println("레시피 번호 : "+recipe.getNum());
	int status = recipe.getStatus();
%>
<tr>
  	<td>
  	<%=number%>
  	</td>
	<td >
	<a href="javascript:goRecipe(<%=recipe.getNum()%>);">
<%	if(recipe.getReccommend() >= 5){%> 
		<font color="red"> ☆
<%	}%>
	<%=recipe.getName() %>
<%	if(recipe.getReccommend() >= 5){%> 
		★</font></a>
<%	}%>
</td>
<td ><%=recipe.getWriter() %></td>
<td ><%=recipe.getDay() %></td>
<td ><%=recipe.getReadcount() %></td>
<td ><%=recipe.getReccommend() %></td>
<%	number --;
}%>
</table>
<%
if (count > 0) {
	int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
	int startPage = (int)(currentPage/10)*10+1;
	int pageBlock = 10;
	int endPage = startPage + pageBlock-1;
	if (endPage > pageCount) {
		endPage = pageCount;
	}      
	if (startPage > 10) {%>
		<a href="javascript:page(<%= startPage - 10 %>);">[이전]</a>
<%	}
	for (int i = startPage ; i <= endPage ; i++) {  %>
		<a href="javascript:page(<%=i%>);">[<%=i%>]</a>
<%	}
	if (endPage < pageCount) {%>
		<a href="javascript:page(<%= startPage + 10 %>);">[다음]</a>
	<%}
}%>
<input type="hidden" id="currentPage" name="currentPage" value = "<%=currentPage%>">
<input type="hidden" id="pageNum" name="pageNum" value = "<%=pageNum %>">
<input type="hidden" id="num" name="num">
<input type="hidden" id="random_id" name="random_id">
<input type="hidden" id="comment_num" name="comment_num">
</form>
</div>
</body>
<script>
function goSearch(){
	var key = document.getElementById("keyword").value;
	
	document.getElementById("search").value = key;
	
	if(key == null || key.trim() == ""){
		alert("검색어가 입력되지 않았습니다!")
		document.f2.action = "mixList.jsp";
		document.f2.submit();
	}
}

function page(pageNum){
	document.f2.action = "mixList.jsp";
	document.getElementById("pageNum").value = pageNum;
	document.f2.submit();
}

function goRecipe (num){
	document.f2.action = "recipe.jsp";
	document.getElementById("random_id").value = "0";
	document.getElementById("num").value = num;
	document.getElementById("comment_num").value = "0";
	document.f2.submit();
}
</script>