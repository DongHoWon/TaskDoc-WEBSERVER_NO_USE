<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
%>

</head>
<body>
<table class="table table-striped table-hover" style="width:100%;">
	<thead>
		<tr style="width:100%;">
			<th style="width: 20%;">게시글 코드</th>
			<th style="width: 47%;">방법론 제목</th>
			<th style="width: 33%;">★</th>
		</tr>
	</thead>
	<tbody id="tbodys">
	</tbody>
</table>
</body>
<script type="text/javascript">
$.ajax({
	type : 'GET',
	url : '/methodlist/' + '<%=loginid%>',
	success : function(response) {
		if(response.length>0){
			for(var i=0;i<response.length;i++){
				var $div='<tr><td style="vertical-align:middle;">'+response[i].mbcode+'</td>'
				+'<td style="bts">'+response[i].mltitle+'</td>'
				+'<td><button onclick="goBoard('+response[i].mbcode+')" class="btn" style="outline:none;border:0px;background-color:#ed8151;color:white;margin-right:5px;">'
				+'게시글로 이동</button><button onclick="deleteMethod('+response[i].mbcode+')" class="btn" style="outline:none;border:0px;background-color:#ed8151;color:white;">삭제</button></td></tr>'
				$("#tbodys").append($div);
			}
		}else{
			alert('방법론 리스트가 존재하지 않습니다.');
			window.close();
		}
	},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
}); 

function goBoard(mbcode){
	if(confirm('해당 방법론이있는 게시글로 이동하시겠습니까?')==true){
		window.close();
		opener.location.href="/methodboard/view?mbcode="+mbcode;
	}
	else return;
}

function deleteMethod(mbcode){
	if(confirm('저장된 방법론을 삭제 하시겠습니까?')==true){
		var param = {
				'uid' : '<%=loginid%>',
				'mbcode' : mbcode,
			};
			$.ajax({
				type : 'DELETE',
				url : '/methodlist',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response>0) {
						alert('나의 방법론 리스트가 삭제 되었습니다.');
						location.reload();
					} else{
						alert('나의 방법론 리스트 삭제가 실패 되었습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
	}
	else return;
}
</script>
</html>