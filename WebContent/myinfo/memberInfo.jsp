<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="groupBuying.board.BoardDBBean"%>
<%@page import="recipe.bean.RecipeDAO"%>
<%@page import="member.bean.ManagerDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "../menu.jsp" %>
<%@ page import="java.util.HashMap" %>
<%
	
	ManagerDAO dao = new ManagerDAO();
	int totalmember = dao.getMemberCount();
	int q_member = dao.getquitMemberCount();
	
	int count = 0;
	RecipeDAO r_dao = new RecipeDAO();
	int master = r_dao.getMemberMaster(id); 		// 회원권한 조회
	if(master != 2) {
		%>
		<script>
			alert("권한이 없습니다.");
			history.go(-1);
		</script>
<%	}
	
	count = r_dao.getRecipeCount(master, id); 
	int a_count = r_dao.getRecipeCount(0, id);
	
	int c_count = 0;
	BoardDBBean dbPro = new BoardDBBean();
	c_count = dbPro.getArticleCount();
	
	int r_count = 0; 
	recipeRequest.board.BoardDBBean dbPro2 = new recipeRequest.board.BoardDBBean();
	r_count = dbPro2.getArticleCount();
	
	int s_count = 0;
	shoppingInfoShare.board.BoardDBBean dbPro3 = new shoppingInfoShare.board.BoardDBBean();
	s_count = dbPro3.getArticleCount();
	
	HashMap <String, Integer> daytotal = dao.getDayTotal();
	SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
	Calendar cal = Calendar.getInstance();
	cal.add(Calendar.DAY_OF_MONTH, -7);
	int[] daycount = new int[7];
	int[] daycount2 = new int[7];
	int[] daycount3 = new int[7];
	int[] daycount4 = new int[7];

	for(int i = 0; i < 7; i ++) {
		cal.add(Calendar.DAY_OF_MONTH, 1);
		String day = format.format(cal.getTime());
		daycount[i] = dao.getcount(day);
		daycount2[i] = dao.groupbuyingcount(day);
		daycount3[i] = dao.recipeRequestcount(day);
		daycount4[i] = dao.shoppingcount(day);
	}
	
	
		
%> 
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<body bgcolor="#f0efea">
<center>
<p><b>회원 수 : <%=totalmember %></b></p>
<p><b>탈퇴 회원수 : <%=q_member %></b></p><br/>

<p><b>레시피 갯수 : <%=count %> (승인된 글 : <%=a_count %>)</b></p>


<canvas id="myChart" width="400" height="150" bg-color="white"></canvas>
<script>
var currentDay = new Date();  
var theYear = currentDay.getFullYear();
var theMonth = currentDay.getMonth();
var theDate  = currentDay.getDate() -6;
var theDayOfWeek = currentDay.getDay();
 
var thisWeek = [];
var count = [<%=daycount[0]%>, <%=daycount[1]%>, <%=daycount[2]%>, <%=daycount[3]%>,
	<%=daycount[4]%>, <%=daycount[5]%>, <%=daycount[6]%>];
 
for(var i=0; i < 7; i++) {
  var resultDay = new Date(theYear, theMonth, theDate + i );
  var yyyy = resultDay.getFullYear();
  var mm = Number(resultDay.getMonth()) + 1;
  var dd = resultDay.getDate();
 
  mm = String(mm).length === 1 ? '0' + mm : mm;
  dd = String(dd).length === 1 ? '0' + dd : dd;
 
  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
}
var ctx = document.getElementById('myChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: thisWeek,
        datasets: [{
            label: 'number of Articles',
            data: count,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(0, 0, 135, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(0, 0, 135, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>

<br><p><b>공동구매 게시글 갯수 : <%=c_count %></b></p>
<canvas id="myChart2" width="400" height="150" bg-color="white"></canvas>
<script>
var currentDay = new Date();  
var theYear = currentDay.getFullYear();
var theMonth = currentDay.getMonth();
var theDate  = currentDay.getDate() -6;
var theDayOfWeek = currentDay.getDay();
 
var thisWeek = [];
var count = [<%=daycount2[0]%>, <%=daycount2[1]%>, <%=daycount2[2]%>, <%=daycount2[3]%>,
	<%=daycount2[4]%>, <%=daycount2[5]%>, <%=daycount2[6]%>];
 
for(var i=0; i < 7; i++) {
  var resultDay = new Date(theYear, theMonth, theDate + i );
  var yyyy = resultDay.getFullYear();
  var mm = Number(resultDay.getMonth()) + 1;
  var dd = resultDay.getDate();
 
  mm = String(mm).length === 1 ? '0' + mm : mm;
  dd = String(dd).length === 1 ? '0' + dd : dd;
 
  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
}
var ctx = document.getElementById('myChart2').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: thisWeek,
        datasets: [{
            label: 'number of Articles',
            data: count,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(0, 0, 135, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(0, 0, 135, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>

<br><p><b>레시피 요청 게시글 갯수 : <%=r_count %></b></p>
<canvas id="myChart3" width="400" height="150" bg-color="white"></canvas>
<script>
var currentDay = new Date();  
var theYear = currentDay.getFullYear();
var theMonth = currentDay.getMonth();
var theDate  = currentDay.getDate() -6;
var theDayOfWeek = currentDay.getDay();
 
var thisWeek = [];
var count = [<%=daycount3[0]%>, <%=daycount3[1]%>, <%=daycount3[2]%>, <%=daycount3[3]%>,
	<%=daycount3[4]%>, <%=daycount3[5]%>, <%=daycount3[6]%>];
 
for(var i=0; i < 7; i++) {
  var resultDay = new Date(theYear, theMonth, theDate + i );
  var yyyy = resultDay.getFullYear();
  var mm = Number(resultDay.getMonth()) + 1;
  var dd = resultDay.getDate();
 
  mm = String(mm).length === 1 ? '0' + mm : mm;
  dd = String(dd).length === 1 ? '0' + dd : dd;
 
  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
}
var ctx = document.getElementById('myChart3').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: thisWeek,
        datasets: [{
            label: 'number of Articles',
            data: count,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(0, 0, 135, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(0, 0, 135, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>

<br><p><b>장보기 공유 게시글 갯수 : <%=s_count %></b></p>
<canvas id="myChart4" width="400" height="150" bg-color="white"></canvas>
<script>
var currentDay = new Date();  
var theYear = currentDay.getFullYear();
var theMonth = currentDay.getMonth();
var theDate  = currentDay.getDate() -6;
var theDayOfWeek = currentDay.getDay();
 
var thisWeek = [];
var count = [<%=daycount4[0]%>, <%=daycount4[1]%>, <%=daycount4[2]%>, <%=daycount4[3]%>,
	<%=daycount4[4]%>, <%=daycount4[5]%>, <%=daycount4[6]%>];
 
for(var i=0; i < 7; i++) {
  var resultDay = new Date(theYear, theMonth, theDate + i );
  var yyyy = resultDay.getFullYear();
  var mm = Number(resultDay.getMonth()) + 1;
  var dd = resultDay.getDate();
 
  mm = String(mm).length === 1 ? '0' + mm : mm;
  dd = String(dd).length === 1 ? '0' + dd : dd;
 
  thisWeek[i] = yyyy + '-' + mm + '-' + dd;
}
var ctx = document.getElementById('myChart4').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: thisWeek,
        datasets: [{
            label: 'number of Articles',
            data: count,
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)',
                'rgba(0, 0, 135, 0.2)'
            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)',
                'rgba(0, 0, 135, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        }
    }
});
</script>
</center>
</body>