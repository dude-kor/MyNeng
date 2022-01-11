<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "color.jsp" %>
<!DOCTYPE html>
<html>
<script>
var count = 1;

function rowAdd()
{
	//tr 생성
	var objRow;
	objRow = document.all("showTable").insertRow();
	
	
	// td 체크 박스
	var objCell_checkBox = objRow.insertCell();
	objCell_checkBox.align = 'center';
	objCell_checkBox.width = '200';
	objCell_checkBox.innerHTML = "<input type = 'checkbox' id = 'memo_check'"+count+" name = 'memo_check'"+count+">";
	
	// td 재료명 text
	var objCell_name = objRow.insertCell();
	objCell_name.innerHTML = "<input type = 'text' id = 'memo_name'"+count+" name = 'memo_name'"+count+" size = '30'>";
	
	// td 비고 text
	var objCell_explain = objRow.insertCell();
	objCell_explain.innerHTML = "<input type = 'text' id = 'memo_explain'"+count+" name = 'memo_explain'"+count+" size = '130'>";
	
	// td 행 삭제 button
	var objCell_delButton = objRow.insertCell();
	objCell_delButton.width = '200';
	objCell_delButton.align = 'center';
	objCell_delButton.innerHTML = "<input type = 'button' id = 'delBtn'"+count+" name = 'delBtn'"+count+" value = '항목 삭제' OnClick='rowDel()'>";

	count ++;
}

function rowDel()
{
	
}
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body bgcolor="<%=bodyback_c %>">
<table border="1" width="1200" cellpadding ="0" cellspacing="0" align="center" table id = "showTable">
	<form method = "post" name = memoWrite" action ="memoWritePro.jsp" onsubmit="">
	<tr height="30" bgcolor="<%=value_c%>">
		<td align = "center" width =" 200">항목체크</td>
		<td align = "center" width =" 200">재료명</td>
		<td align = "center" width =" 800">비 고</td>
		<td align = "center" width =" 200"></td>
	</tr>
	
	</table>
	<table border="0" width="1200" cellpadding ="0" cellspacing="0" align="center">
	<tr>
		<td bgcolor="<%=bodyback_c%>" align = "left">
		<input type = "button" id = "addBtn" name = "addBtn" value = "항목 추가" OnClick="rowAdd()"></td>
		<td bgcolor="<%=bodyback_c%>" align = "right">
		<input type = "submit" value = "저장하기" Onclick = "window.location = memoWritePro.jsp">
		<input type = "button" value = "초기화" Onclick ="window.location = 'memoView.jsp'">
		<input type = "button" value = "목록으로">
		</td>
	</tr>	
	</form>
	</table>
</body>
</html>