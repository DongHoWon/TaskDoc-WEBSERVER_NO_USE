<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<%
String tcode = request.getParameter("tcode");
String pcode = request.getParameter("pcode");
String loginid = "";
loginid = (String) session.getAttribute("loginid");
%>
</head>
<script type="text/javascript">
var pcode=<%=pcode%>;
</script>
<body>
	<div class="bts" style="width:100%;height:10%;">
		<button id="downform" onclick="godownloform(<%=tcode %>)" class="btn" type="button" style="outline:none; border:0px; background-color:#ed8151; color:white;">자료 리스트로 돌아가기</button>
	</div>
	
	<div id="doculist" style="width:100%;height:90%;">
		<table class="table table-striped table-hover" style="width:100%;">
			<thead>
				<tr style="width:100%;">
					<th style="width: 30%;">자료제목</th>
					<th style="width: 36%;">자료내용</th>
					<th style="width: 19%;">아이디</th>
					<th style="width: 20%;">날짜</th>
				</tr>
			</thead>
			<tbody id="tbodys<%=tcode%>">
			
			</tbody>
		</table>
	</div>
</body>
<script type="text/javascript">
var socket = new SockJS('/goStomp'); 
stompClient = Stomp.over(socket);
stompClient.connect({}, function() { //접속
stompClient.subscribe('/project/'+pcode, function(msg) {
	/* alert(msg); */
	var test=msg.body;
	 	var concat=JSON.parse(test);
	 	if(concat.message=="insert"){
	 		if(concat.type="documentvo"){
	 		 var $div='<tr><td><a style="cursor:pointer;" onclick="gofiledown('+concat.object.dmcode+')">'+concat.object.dmtitle+'</a></td><td>'+concat.object.dmcontents+'</td><td>'+concat.object.uid+'</td><td>'+concat.object.dmdate+'</td></tr>';
	 		$("#tbodys"+concat.object.tcode).append($div); 
	 			}
	 		}
	});
});


$(function(){
	$.ajax({
		type : 'GET',
		url : '/document/task/' + <%=tcode%>,
		success : function(response) {
			if(response.length>0){
				for(var i=0;i<response.length;i++){
					var $div='<tr><td><a style="cursor:pointer;" onclick="gofiledown('+response[i].dmcode+')">'+response[i].dmtitle+'</a></td><td>'+response[i].dmcontents+'</td>'
					+'<td>'+response[i].uid+'</td><td>'+response[i].dmdate+'</td></tr>';
					$("#tbodys"+<%=tcode%>).append($div);
				}
			}
			else alert('자료가 존재하지 않습니다.');
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
})

function gofiledown(dmcode){
	$("#doculist").load('/chat/fileDownload?dmcode='+dmcode);
}

function godownloform(code){
	location.href='/project/file/downloadForm?tcode='+code;
}
</script>
</html>