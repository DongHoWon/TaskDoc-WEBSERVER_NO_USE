
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/project/circleChart.css" />
<script
	src="${pageContext.request.contextPath }/resources/js/project/jsgantt.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/project/jsgantt.css">
	
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
%>

<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
$(document).ready(function(){
	var contentheight = $("#contentwrap").height();
	var contentwidth = $("#contentwrap").width();
	$(".container").css('height', contentheight);
	$(".container").css('width', contentwidth / 1.1);
});
</script>

</head>
<body>
	<!--FRAME  -->
	<div id="frame">
		<!--MAIN HEADER  -->
		<%@include file="/WEB-INF/views/fix/main_header.jsp"%>
		<!--MAIN HEADER  -->

		<!--WRAPPER  -->
		<div id="wrapper">

			<!--SIDE BAR  -->
			<%@include file="/WEB-INF/views/fix/left_side.jsp"%>
			<!--SIDE BAR  -->

			<!--CONTENTWRAP  -->
			<div id="contentwrap" style="background-color: #e0e0e0;">
				<div class="container"
					style="background-color: white; overflow: auto;">

					<!-- TASK CONTENTS  -->
					<div id="publictaskWRAP" style="width: 100%; /* height: 93%; */ padding-left:15px;">
						<div id="publictaskTOP" class="bts" style="margin-bottom:30px;">
							<span id="spans" style="font-size:30px;">개인 업무가 포함된 공용업무 리스트</span>
							<div id="Zz">
								<button id="gochart" type="button" class="btn" style="outline:none;border:0px;color:white;background-color:#ed8151;">간트차트로보기</button>
							</div>
						</div>	
						
						<div id="publictaskBOTTOM">
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- FOOTER -->
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
		<!-- FOOTER -->

	</div>
	<!--FRAME  -->
</body>
<script type="text/javascript">
var screenW = screen.availWidth; 
var screenH = screen.availHeight;
var posL=( screenW-popW ) / 2;  
var posT=( screenH-popH ) / 2;  
$(function(){
	$.ajax({
		type : 'GET',
		url : '/privatetask/user/plist/' + id,
		success : function(response) {
			if (response.length > 0 ) {
				for(var i=0;i<response.length;i++){
					var $append = '<div id="publictask'+response[i].tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
					+'<div id="color'+response[i].ptcode+'" onclick="godowntask('+response[i].tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+response[i].tcolor+';"><span>'+ (i+1) +'. : '+response[i].ttitle+'</span></div>'
					+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
					+'<div style="margin-left:20px;" id="chart'+response[i].tcode+'" class="progress-pie-chart" data-percent="'+response[i].tpercent+'">'
					+'<div class="ppc-progress">'
					+'<div class="ppc-progress-fill" id="fill'+response[i].tcode+'"></div></div>'
					+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ response[i].tcode +'">%</span></div></div></div>'
					+'<div><div><span id="tsdate'+response[i].tcode+'">시작 날짜 : '+response[i].tsdate+'</span></div><div><span id="tedate'+response[i].tcode+'">종료 날짜 : '+response[i].tedate+'</span></div>'
					+'</div></div></div>';
					
					$("#publictaskBOTTOM").append($append);
					var a = $("#chart"+response[i].tcode.toString());
					var percent = parseInt(a.data('percent'));
					var deg = 360 * percent / 100;
						if (percent > 50) {
							a.addClass("gt-50");
						}
					var b=$("#fill"+response[i].tcode.toString());
					b.css('transform', 'rotate(' + deg + 'deg)');
					$('#num'+response[i].tcode.toString()).html(percent + '%');	
					
					}
				} else{
				alert('Server or Client ERROR, 개인 업무 조회에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
});

$("#gochart").on('click',function(){
	$("#spans").hide();
	$("#gochart").hide();
	$div='<button type="button" onclick="goptlist()"class="btn" style="outline:none;border:0px;color:white;background-color:#ed8151;margin-top:10px;">개인업무리스트로 돌아가기</button>';
	$("#Zz").append($div);
	$("#publictaskBOTTOM").load("/user/gantt/view");
});
//개인 업무 삭제
function ptdel(ptcode){
	 event.stopPropagation();
	 if(confirm('개인 업무를 삭제하시겠습니까?')==true){
		$.ajax({
			type : 'DELETE',
			url : '/privatetask/' + ptcode,
			success : function(response) {
				if (response == 1) {
					alert('개인 업무가 삭제 되었습니다.');
					location.reload();
				} else if (response == -1) {
					alert('Server or Client ERROR, 개인 업무 삭제에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	 }
	 else return;
}

//개인 업무 수정
function ptedit(ptcode){
	 event.stopPropagation();
	 var popW = 400; // 띄울창의 가로사이즈
	 var popH = 560; // 띄울창의 세로사이즈
	 if(confirm('개인 업무를 수정하시겠습니까?')==true){
			window.open("/project/privateTask/edit?ptcode="+ptcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	 }
	 else return;
}

//메모 생성
function goMemo(ptcode){
	 event.stopPropagation();
	 var popW = 500; // 띄울창의 가로사이즈
	 var popH = 450; // 띄울창의 세로사이즈
	 if(confirm('메모를 확인하시겠습니까??')==true){
			window.open("/project/memo/main?ptcode="+ptcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	 }
	 else return;
}

//하위업무로이동
function godowntask(tcode){
	 if(confirm('하위 업무로 이동하시겠습니까?')==true){
		 $("#ptcreatebtn").hide();
		 $("#publictaskBOTTOM").load("/project/privateTask/downTask?tcode="+tcode); 
		 $("#spans").hide();
		 $btntag='<button class="btn" type="button" onclick="gotasklist()" style="background-color:#ed8151; border:0;outline:none; color:white;">개인업무 리스트로 이동</button>';
		 $("#publictaskTOP").append($btntag);
	 }else return;
}

//모든 개인업무 리스트로 이동
function gotasklist(){
	 location.href='/project/privateTask/main';
}

function goptlist(){
	 location.href='/project/privateTask/main';
	
}
</script>

</html>