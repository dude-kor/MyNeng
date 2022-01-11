function test(comment_id, num, comment_listNum, pageNum, comment_num){
	var context = document.getElementById("commentContext").value;
	window.location = "commentWrite.jsp?pageNum="+pageNum+"&num="+num+"&random_id=0&comment_list="+comment_listNum+"&comment_id="+comment_id+"&comment_num="+comment_num;
}