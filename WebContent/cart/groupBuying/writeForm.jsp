<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="color.jsp"%>
<html>
<head>
<jsp:include page="/menu.jsp"/>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js">
</script>
</head>


<%
	String id = (String)session.getAttribute("memId"); 
	if(id==null)
	{%>
		<script>
			alert("로그인 후 글쓰기 가능합니다...!!");
			window.location='loginForm.jsp';
		</script>
	<% }
%>

<% 
  int num=0,ref=1,re_step=0,re_level=0;
 
    if(request.getParameter("num")!=null){
		num=Integer.parseInt(request.getParameter("num"));
		ref=Integer.parseInt(request.getParameter("ref"));
		re_step=Integer.parseInt(request.getParameter("re_step"));
		re_level=Integer.parseInt(request.getParameter("re_level"));
	}
%>
   
<body bgcolor="<%=bodyback_c%>">  
<center><b>글쓰기</b>
<br>
<form method="post" name="writeform" action="writePro.jsp" onsubmit="return writeSave()">
<input type="hidden" name="num" value="<%=num%>">
<input type="hidden" name="ref" value="<%=ref%>">
<input type="hidden" name="re_step" value="<%=re_step%>">
<input type="hidden" name="re_level" value="<%=re_level%>">

<table width="400" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">
   <tr>
    <td align="right" colspan="2" bgcolor="#d6cabc">
	    <a href="groupBuying.jsp"> 글목록</a> 
   </td>
   </tr>
   <tr>
    <td  width="70"  bgcolor="#d6cabc" align="center">이 름</td>
    <td  width="330">
    	<%=id %>
       <input type="hidden" name="writer" value="<%=id %>"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="#d6cabc" align="center" >제 목</td>
    <td  width="330">
    <%if(request.getParameter("num")==null){%>
       <input type="text" size="40" maxlength="50" name="subject"></td>
	<%}else{%>
	   <input type="text" size="40" maxlength="50" name="subject" value="[답변]">
	<%}%>
  </tr>
  <tr>
    <td  width="70"  bgcolor="#d6cabc" align="center" >내 용</td>
    <td  width="330" >
     <textarea name="content" rows="13" cols="40">
공동 구매 링크 : 
내용 입력 : 
</textarea> </td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="#d6cabc" align="center" >비밀번호</td>
    <td  width="330" >
     <input type="password" size="8" maxlength="12" name="passwd"> 
	 </td>
  </tr>
<tr>      
 <td colspan=2 bgcolor="#d6cabc" align="center"> 
  <input type="submit" value="글쓰기" >  
  <input type="reset" value="다시작성">
  <input type="button" value="목록보기" OnClick="window.location='groupBuying.jsp'">
</td></tr></table>    
   
</form>      
</body>
</html>      
