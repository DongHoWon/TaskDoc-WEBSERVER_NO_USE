<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String tcode=request.getParameter("tcode");
	String pcode=request.getParameter("pcode");
	String permission=request.getParameter("permission");
%>

<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
//pro_header.jsp , pro_header.js 에서 <script>태그 안에서 변수 사용가능하다.	
</script>

</head>
<body>
	<!--자료, 회의록, 의사결정  -->
	<div class="container">
				<h2>업무별 모아보기</h2>
				<p>업무별 자료, 의사결정, 회의록을 확인할 수 있습니다.</p>

				<ul class="nav nav-tabs">
					<li class="active"><a data-toggle="tab" href="#publictaskdocument">자료</a></li>
					<li><a data-toggle="tab" href="#publictaskdecision">의사결정</a></li>
					<li><a data-toggle="tab" href="#chat">회의록</a></li>
				</ul>

				<div class="tab-content">
					<div id="publictaskdocument" class="tab-pane fade in active">
						<div class="containers">
							<table class="table table-striped table-hover">
								<thead>
									<tr style="width:100%;">
										<th style="width: 20%">날짜</th>
										<th style="width: 30%">자료제목</th>
										<th style="width: 36%">자료내용</th>
										<th style="width: 19%">아이디</th>
									</tr>
								</thead>
								<tbody id="tbodys">

								</tbody>
							</table>
						</div>

					</div>
					<div id="publictaskdecision" class="tab-pane fade">
						<div class="containers">
							<table class="table table-striped table-hover">
								<thead>
									<tr style="width:100%">
										<th style="width: 20%;">날짜</th>
										<th style="width: 60%;">투표제목</th>
										<th style="width: 20%">종료여부</th>
									</tr>
								</thead>
								<tbody id="tbodyss">

								</tbody>
							</table>
						</div>
					</div>
					<div id="chat" class="tab-pane fade">
						<div class="containers">
							<table class="table table-striped table-hover">
								<thead>
									<tr style="width:100%;">
										<th style="width: 30%;">날짜</th>
										<th style="width: 60%;">회의제목</th>
										<th style="width: 10%;">종료여부</th>
									</tr>
								</thead>
								<tbody id="tbodysss">

								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
</body>
<script type="text/javascript">
if (location.hash) {
	$("a[href='" + location.hash + "']").tab("show");
}
$(document.body).on("click", "a[data-toggle]", function(event) {
	location.hash = this.getAttribute("href");
});
$(window).on(
		"popstate",
		function() {
			var anchor = location.hash
					|| $("a[data-toggle='tab']").first().attr("href");
			$("a[href='" + anchor + "']").tab("show");
		});
//자료다운		
$.ajax({
	type : 'GET',
	url : '/document/task/'+<%=tcode%>,
	success : function(response) {
			if (response.length > 0) {
				for(var i=0;i<response.length;i++){
					var $div='<tr><td>'+response[i].dmdate+'</td><td><a style="cursor:pointer;" onclick="gofiledown('+response[i].dmcode+')">'+response[i].dmtitle+'</a></td><td>'+response[i].dmcontents+'</td>'
					+'<td>'+response[i].uid+'</td></tr>';
					$("#tbodys").append($div);
				}
		} else {
			alert('Server or Client ERROR, 자료 목록이 존재하지 않습니다.');
		}
		},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
});

function gofiledown(dmcode){
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight;
	var popW = 600; 
	var popH = 350; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2;   
	window.open('/chat/fileDownload?dmcode='+dmcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}

$.ajax({
	type : 'GET',
	url : '/decision/task/'+<%=tcode%>,
	success : function(response) {
			if (response.length > 0) {
				for(var i=0;i<response.length;i++){
					var close="";
					if(response[i].dsclose==1){
						close="O";
					}else
						close="X"
					var $div='<tr><td>'+response[i].dsdate+'</td><td><a style="cursor:pointer;" onclick="goDecision('+response[i].dscode+')">'+response[i].dstitle+'</a></td><td>'+close+'</td>'
					+'</tr>';
					$("#tbodyss").append($div);
				}
		} else {
			alert('Server or Client ERROR, 투표가 존재하지 않습니다.');
		}
		},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
});

function goDecision(dscode){
	var screenW = screen.availWidth;  // 스크린 가로사이즈
	var screenH = screen.availHeight; // 스크린 세로사이즈
	var popW = 600; // 띄울창의 가로사이즈
	var popH = 350; // 띄울창의 세로사이즈
	var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
	var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션 
	window.open("/chat/decisionSelect?chatpermission="+'<%=permission%>'+"&dscode="+dscode+"&pcode="+<%=pcode%>, "", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}

$.ajax({
	type : 'GET',
	url : '/chatroom/task/'+<%=tcode%>,
	success : function(response) {
			if (response.length > 0) {
				for(var i=0;i<response.length;i++){
					var close="";
					if(response[i].crclose==1){
						close="O";
					}else
						close="X"
					var $div='<tr><td>'+response[i].crdate+'</td><td><a style="cursor:pointer;" onclick="goDecision('+response[i].crcode+')">'+response[i].fctitle+'</a></td><td>'+close+'</td>'
					+'</tr>';
					$("#tbodysss").append($div);
				}
		} else {
			alert('Server or Client ERROR, 투표가 존재하지 않습니다.');
		}
		},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
});
</script>
</html>
