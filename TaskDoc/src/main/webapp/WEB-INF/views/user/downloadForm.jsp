<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<%
String dmcode = request.getParameter("dmcode");
%>
</head>
<body>
<table class="table table-striped table-hover" style="width:100%;">
	<thead>
		<tr style="width:100%;">
			<th style="width: 50%;">파일 이름</th>
			<th style="width: 50%;">★★</th>
		</tr>
	</thead>
	<tbody id="tbodys">
	</tbody>
</table>
</body>
<script type="text/javascript">
$.ajax({
	type : 'GET',
	url : '/file/' + <%=dmcode%>,
	success : function(response) {
		if(response.length>0){
			for(var i=0;i<response.length;i++){
				var $div='<tr><td style="vertical-align:middle;">'+response[i].fname+'</td><td style="bts">'
				+'<form action="/file/download/'+response[i].fcode+'" method="POST">'
				+'<input type="submit" class="btn" value="다운로드" style="outline:none;color:white;background-color:#ed8151;"></form></td></tr>';
				$("#tbodys").append($div);
			}
		}else{
			alert('다운 받을 자료가 없습니다.');
			window.close();
		}
	},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
}); 
</script>
</html>