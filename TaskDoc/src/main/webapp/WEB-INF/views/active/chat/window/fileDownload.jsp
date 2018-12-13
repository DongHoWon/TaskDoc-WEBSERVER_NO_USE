<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%
String dmcode=request.getParameter("dmcode");
String loginid = "";
loginid = (String) session.getAttribute("loginid");
%>
</head>
<body>
	<table class="table table-striped table-hover" style="width:100%;">
		<thead>
			<tr style="width:100%;">
				<th style="width: 15%;">자료제목</th>
				<th style="width: 30%;">자료내용</th>
				<th style="width: 25%;">파일이름</th>
				<th style="width: 10%;">아이디</th>
				<th style="width: 20%;">날짜</th>
			</tr>
		</thead>
		<tbody id="tbodys">
		</tbody>
	</table>
	
	<div>
		<span style="font-size:15px;font-weight: bold;">자료 피드백</span>
		<table class="table table-striped table-hover" style="width:100%;">
		<thead>
			<tr style="width:100%;">
				<th style="width: 15%;">번호</th>
				<th style="width: 15%;">아이디</th>
				<th style="width: 45%;">내용</th>
				<th style="width: 15%;">날짜</th>
				<th style="width: 10%;">-</th>
			</tr>
		</thead>
		
		<tbody id="tbodyss">
		
		</tbody>
	</table>
	</div>
	
	<div class="bts">
		<button type="button" onclick="feedbackadd()" class="btn" style="background-color:#ed8151;color:white;outline:none;border:0px;" >피드백 추가하기</button>
		
		<div id="feedbacklist">
			
		</div>
	</div>
	
</body>
<script type="text/javascript">
$(function(){
	$.ajax({
		type : 'GET',
		url : '/document/' + <%=dmcode%>,
		success : function(response) {
			if(response.file.length>0){
				for(var i=0;i<response.file.length;i++){
					var $div='<tr><td>'+response.document.dmtitle+'</td><td>'+response.document.dmcontents+'</td>'
					+'<td class="bts">'+response.file[i].fname+'<form action="/file/download/'+response.file[i].fcode+'" method="POST">'
					+'<button class="btn" type="submit" style="background-color:#ed8151;color:white;outline:none;border:0px;">다운로드</button></form>'
					+'</td><td>'+response.document.uid+'</td><td>'+response.document.dmdate+'</td></tr>';
					$("#tbodys").append($div);
				}
			}else{
				alert('다운 받을 자료가 없습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
	$.ajax({
		type : 'GET',
		url : '/feedback/' + <%=dmcode%>,
		success : function(response) {
			if(response.length>0){
				for(var i=0;i<response.length;i++){
					if(response[i].uid=='<%=loginid%>'){
						var $div='<tr><td>'+ (i+1) +'</td><td>'+response[i].uid+'</td>'
						+'<td class="bts">'+response[i].fbcontents+'</td><td>'+response[i].fbdate+'</td>'
						+'<td><button type="button" class="btn" onclick="feedbackdel('+response[i].fbcode+')"style="background-color:#ed8151;color:white;outline:none;border:0px;">삭제</button></td></tr>';
						$("#tbodyss").append($div);
					}
					else{
						var $div='<tr><td>'+ (i+1) +'</td><td>'+response[i].uid+'</td>'
						+'<td class="bts">'+response[i].fbcontents+'</td><td>'+response[i].fbdate+'</td></tr>';
						$("#tbodyss").append($div);
					}
				}
			}else{
				alert('피드백이 없습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
})

var count=0;
function feedbackadd(){
	count++;
	if(count<=1){
		var $fflist = '<div class="bts" style="display:-webkit-box;"><span style="line-height:34px;margin-right:10px;">피드백 :</span>'
		+'<input type="text" id="fbcontents" class="form-control" style="width:80%;">'
		+'<button style="background-color:#ed8151;color:white;outline:none;border:0px;" class="btn" type="button" onclick="createfeedback()" >생성</button></div>';
		$("#feedbacklist").append($fflist);
	}
	else 
		alert('피드백은 하나씩 추가해주세요');
}

function createfeedback(){
	var param={
		'uid' :  '<%=loginid%>',
		'dmcode' :  parseInt(<%=dmcode%>),
		'fbcontents': $("#fbcontents").val()
	};
	$.ajax({
		type : 'POST',
		url : '/feedback',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (Object.keys(response).length>0) {
				alert('피드백 추가가 완료 되었습니다.');
				location.reload();
			} else {
				alert('Server or Client ERROR, 피드백 생성에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}

function feedbackdel(fbcode){
	$.ajax({
		type : 'DELETE',
		url : '/feedback/'+fbcode,
		success : function(response) {
			if(response>0){
				alert('피드백 삭제가 완료 되었습니다.');
				location.reload();
			}
			else
				alert('피드백 삭제가 실패 되었습니다.');
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
</script>
</html>