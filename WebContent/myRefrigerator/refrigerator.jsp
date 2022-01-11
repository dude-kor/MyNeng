<%@page import="member.bean.MemberDTO"%>
<%@page import="member.bean.MemberDAO"%>
<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import = "myRef.food.MaNengDBBean" %>
<%@ page import = "myRef.food.MaNengDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>

<center><h1>나의 냉장고</h1>
<%
	// 인코딩
	request.setCharacterEncoding("UTF-8");
	
	//memId 호출
	String memId = (String)session.getAttribute("memId");		// 리펙으로 ingList 호출한 부분으로 합침
	
	// 임의 페이지 수 게시글 수 정의
	int pageSize = 10;
	
	// 페이지 유효성 검사
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null || pageNum == "") {
        pageNum = "1";
    }
	
	int currentPage = Integer.parseInt(pageNum);		// 현재 페이지
    int startRow = (currentPage - 1) * pageSize + 1;	// 현재 페이지 시작 줄 수
    int endRow = currentPage * pageSize;				// 현재 페이지 마지막 줄 수
    int count = 0;										// 재료 수
    int number = 0;										// 재료 순번
    
 	// 재료 list 가져오기
    List<MaNengDataBean> ingList = null;
	MaNengDBBean mnDB = new MaNengDBBean();
	if (memId == null || memId == "") {%>
		<script>
			alert("아이디의 세션이 종료 되어\n로그인 화면으로 돌아갑니다.");
			window.location="<%=request.getContextPath()%>/main.jsp"
		</script>
	<%																		
	}else{
		MemberDAO m_dao = new MemberDAO();
		MemberDTO m_dto = m_dao.getMember2(memId);
		count = mnDB.getRefCount(m_dto.getGroup_id());						// memId_refrigerator의 재료 수 (추후 aaa에 memId 넣기)
		if(count>0){
	    	 ingList = mnDB.getRefs(m_dto.getGroup_id(), startRow, endRow);	// memId_refrigerator의 starRow에서 endRow까지 재료 호출 (추후 aaa에 memId 넣기)
	  
		}
	}
	 
	// list session 선언
    session.setAttribute("ingList", ingList);
    
    number=count-(currentPage-1)*pageSize;
%>

<form name="f2" >
<table> 
	<tr> 
		<td width="150">재료명</td> 
	    <td width="50">수량</td>
	    <td width="50">단위</td>
	    <td width="100">유통기한</td>
    </tr>

<%if (count == 0) {%>

	<tr>
   		<td rowspan ="5" colspan = "5">
   			냉장고에 저장된 재료가 없습니다.
   		</td>
   	</tr>

<%}else{
	for (int i = 0 ; i < ingList.size() ; i++) {	
		MaNengDataBean ing = (MaNengDataBean)ingList.get(i);	// 받은 DB들 풀기
%>	

	<tr>
    	<td width="150">
    	<%=ing.getIngname()%>
    	</td>   	
    	<td width="50">
    	<%=ing.getAmount()%>
    	<td width="50">
    	<%=ing.getUnit()%>
    	</td>
    	<td width="100">
    	<%=ing.getFreshness()%>
	</tr>
<%}}%>
</table>

<%
	// 페이지 이동
		if (count > 0) {
			int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
			int startPage = (int)(currentPage/10)*10+1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock-1;
			if (endPage > pageCount) {endPage = pageCount;}      
			if (startPage > 10) {%>
		<a href="javascript:page(<%= startPage - 10 %>);">[이전]</a>
		 <%}
		for (int i = startPage ; i <= endPage ; i++) {  %>
			<a href="javascript:page(<%=i%>);">[<%=i%>]</a>
		<%}
		if (endPage < pageCount) {  %>
		<a href="javascript:page(<%= startPage + 10 %>)">[다음]</a>
		<%}}%>
<input type="hidden" id="pageNum" name="pageNum">
</form>
</div>
<input type="button" value="냉장고 정리" onclick="window.location='/myneng/myRefrigerator/update.jsp'" />
<input type="button" value="재료  추가" onclick="window.location='/myneng/myRefrigerator/insert.jsp'" />
<input type="button" value="레시피 추천" onclick="window.location='/myneng/myRefrigerator/mixRecipe.jsp'" />
</center>
</body>
<script type="text/javascript">

function page(pageNum){
	document.f2.action = "main.jsp";
	document.getElementById("pageNum").value = pageNum;
	document.f2.submit();
}
</script>
