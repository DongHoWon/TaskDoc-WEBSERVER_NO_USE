<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode = request.getParameter("pcode");
%>
<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
</script>
</head>
<body>
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th style="width: 50px;text-align: center;">번호</th>
				<th style="width: 400px;text-align: center;">제목</th>
				<th style="width: 150px;text-align: center;">날짜</th>
			</tr>
		</thead>
		<tbody id="tbodys">

		</tbody>
	</table>
</body>

<script type="text/javascript">
var screenW = screen.availWidth;  // 스크린 가로사이즈
var screenH = screen.availHeight; // 스크린 세로사이즈
var popW = 600; // 띄울창의 가로사이즈
var popH = 350; // 띄울창의 세로사이즈
var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션 

$(document).ready(function(){
	
//현재 프로젝트의 모든 공지사항
$.ajax({
	type : 'GET',
	url : '/notice/project/'+'<%=pcode%>',
	success : function(response) {
		/*
		response는 List 형태로 날라옴
		ncode : ? ,  , ntitle : ?, ndate : ?'+response[i].ntitle+'
		JSON.parser 이용해서 js 변수에 담아서 뿌려보자.
		*/
		for(var i=0;i<response.length;i++){
			var $trtags='<tr class="bts"><td style="width: 5%; text-align: center;">'+ (i+1) +'</td>'
			+'<td style="width: 5%; text-align: center;"><a style="cursor:pointer;" onclick="viewNotice('+response[i].ncode+')">'+response[i].ntitle+'</a></td>'
			+'<td style="width: 5%; text-align: center;">'+response[i].ndate+'</td>';
			$("#tbodys").append($trtags);
		}
	},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
});
});

function viewNotice(ncode)
{
	window.open("/project/noticeView?ncode="+ncode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
}
</script>

</html>