<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/project/circleChart.css" />
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode=request.getParameter("pcode");
%>

<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
//pro_header.jsp , pro_header.js 에서 <script>태그 안에서 변수 사용가능하다.	
var pcode=<%=pcode%>;

$(function(){
	$(".ptask_hover").css('color','#ed8151').css('border-bottom','1px solid #ed8151');
	$(".chat_hover").css('color','#6d6d6d').css('border-bottom','none');
	$(".gantt_hover").css('color','#6d6d6d').css('border-bottom','none');
	$(".files_hover").css('color','#6d6d6d').css('border-bottom','none');
	
	if(chatpermission=="MEMBER"){
		$("#ptcreatebtn").hide();
		$("#methodptcreatebtn").hide();
		$("#mymethodptcreatebtn").hide();
	}
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

					<!-- PROJECT_FIX_HEADER  -->
					<%@include file="/WEB-INF/views/active/project/fix/pro_header.jsp"%>

					<!-- TASK CONTENTS  -->
					<div id="publictaskWRAP" style="width: 100%; /* height: 93%; */ padding-left:15px;">
						<div id="publictaskTOP" class="bts" style="margin-bottom:30px;">
							<button id="ptcreatebtn"  class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="ptcreate(<%=pcode%>)">공용업무 생성하기</button>
							<button id="methodptcreatebtn"class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="methodptcreate()">방법론으로 공용업무 생성하기</button>
							<button id="mymethodptcreatebtn"class="btn" type="button" style="background-color:#ed8151; color:white;" onclick="mymethodptcreate()">내 방법론으로 공용업무 생성하기</button>
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


$(document).ready(function() {
	//특정 프로젝트의 모든 공용업무를 보여준다.
	$.ajax({
		type : 'GET',
		url : '/publictask/root/' + pcode,
		success : function(response) {
			if (response.length != 0) {
				for(var i=0;i<response.length;i++){
					if(response[i].tsdate!=null && !response[i].tedate!=null){
						if(chatpermission=="OWNER"){
							var $append = '<div id="publictask'+response[i].tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
							+'<div class="bts" data-toggle="tootlip" data-placement="right" title="하위 업무 보기" id="color'+response[i].tcode+'" onclick="godowntask('+response[i].tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+response[i].tcolor+';"><span>'+ (i+1) +'. : </span><span id="ttitle'+response[i].tcode+'">'+response[i].ttitle+'</span></div>'
							+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
							+'<div style="margin-left:20px;" id="chart'+response[i].tcode+'" class="progress-pie-chart" data-percent="'+response[i].tpercent+'">'
							+'<div class="ppc-progress">'
							+'<div class="ppc-progress-fill" id="fill'+response[i].tcode+'"></div></div>'
							+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ response[i].tcode +'">%</span></div></div></div>'
							+'<div><div><span id="tsdate'+response[i].tcode+'">시작 날짜 : '+response[i].tsdate+'</span></div><div><span id="tedate'+response[i].tcode+'">종료 날짜 : '+response[i].tedate+'</span></div>'
							+'<div class="bts"><button onclick="downtaskcreate(\''+response[i].tsdate+ ',' +response[i].tedate+'\','+response[i].tcode+')" style="border:0px;outline:none;color:white;background-color:#ed8151; margin-right:5px; font-size:12px;" class="btn"type="button">하위 업무 생성</button>'
							+'<button style="border:0px;outline:none;color:white;background-color:#ed8151;margin-right:5px;font-size:12px;" class="btn" onclick= "ptedit(\''+response[i].tsdate+ ',' +response[i].tedate+',' + response[i].tcolor + '\','+response[i].tcode+')" type="button">수정</button>'
							+'<button style="border:0px;outline:none;color:white;background-color:#ed8151;font-size:12px;" class="btn" type="button" onclick="ptdel('+response[i].tcode+')">삭제</button></div></div></div></div>';
							$("#ptcreatebtn").show();
						}
						else if(chatpermission=="MEMBER"){
							var $append = '<div id="publictask'+response[i].tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
							+'<div class="bts" data-toggle="tootlip" data-placement="right" title="하위 업무 보기" onclick="godowntask('+response[i].tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+response[i].tcolor+';"><span>'+ (i+1) +'. : </span><span>'+response[i].ttitle+'</span></div>'
							+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
							+'<div style="margin-left:20px;" id="chart'+response[i].tcode+'" class="progress-pie-chart" data-percent="'+response[i].tpercent+'">'
							+'<div class="ppc-progress">'																		
							+'<div class="ppc-progress-fill" id="fill'+response[i].tcode+'"></div></div>'
							+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ response[i].tcode +'">%</span></div></div></div>'
							+'<div><div><span>시작 날짜 : '+response[i].tsdate+'</span></div><div><span>종료 날짜 : '+response[i].tedate+'</span>'
							+'<div class="bts"><button style="border:0px;outline:none;color:white;background-color:#ed8151; margin-right:5px; font-size:12px;" class="btn" onclick= "privateCreate(\''+response[i].tsdate+ ',' +response[i].tedate+'\','+response[i].tcode+')" type="button">개인업무생성</button></div><div></div></div></div></div>';
							$("#ptcreatebtn").hide();
						}
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
				}
			} else if (response.length == 0) {
				alert('Server or Client ERROR, 공용업무 리스트 불러오기에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
	var socket = new SockJS('/goStomp'); 
	
	stompClient = Stomp.over(socket);
	
	//채팅 append 여기서다함
    stompClient.connect({}, function() { //접속
         stompClient.subscribe('/project/'+pcode, function(msg) {
        	 var test=msg.body;
        	 var concat=JSON.parse(test);
        	 if(concat.message=="insert"){
        		 if(concat.type=="publictaskvo"){
        	     	if(concat.object.tcode==concat.object.trefference){
	        			 if(chatpermission=="OWNER"){
	        				 var $append = '<div id="publictask'+concat.object.tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
								+'<div data-toggle="tootlip" data-placement="right" title="하위 업무 보기" onclick="godowntask('+concat.object.tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+concat.object.tcolor+';"><span>'+ 11 +'. : '+concat.object.ttitle+'</span></div>'
								+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
								+'<div style="margin-left:20px;" id="chart'+concat.object.tcode+'" class="progress-pie-chart" data-percent="'+concat.object.tpercent+'">'
								+'<div class="ppc-progress">'
								+'<div class="ppc-progress-fill" id="fill'+concat.object.tcode+'"></div></div>'
								+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ concat.object.tcode +'">%</span></div></div></div>'
								+'<div><div><span>시작 날짜 : '+concat.object.tsdate+'</span></div><div><span>종료 날짜 : '+concat.object.tedate+'</span></div>'
								+'<div class="bts"><button onclick="downtaskcreate(\''+concat.object.tsdate+ ',' +concat.object.tedate+'\','+concat.object.tcode+')" style="border:0px;outline:none;color:white;background-color:#ed8151; margin-right:5px; font-size:12px;" class="btn"type="button">하위 업무 생성</button>'
								+'<button style="border:0px;outline:none;color:white;background-color:#ed8151;margin-right:5px;font-size:12px;" class="btn" onclick= "ptedit(\''+concat.object.tsdate+ ',' +concat.object.tedate+'\','+concat.object.tcode+')" type="button">수정</button>'
								+'<button style="border:0px;outline:none;color:white;background-color:#ed8151;font-size:12px;" class="btn" type="button" onclick="ptdel('+concat.object.tcode+')">삭제</button></div></div></div></div>';
								$("#ptcreatebtn").show();
	        			 }
	        			 else if(chatpermission=="MEMBER"){
	        					var $append = '<div id="publictask'+concat.object.tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
								+'<div data-toggle="tootlip" data-placement="right" title="하위 업무 보기" onclick="godowntask('+concat.object.tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+concat.object.tcolor+';"><span>'+ 11 +'. : '+concat.object.ttitle+'</span></div>'
								+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
								+'<div style="margin-left:20px;" id="chart'+concat.object.tcode+'" class="progress-pie-chart" data-percent="'+concat.object.tpercent+'">'
								+'<div class="ppc-progress">'
								+'<div class="ppc-progress-fill" id="fill'+concat.object.tcode+'"></div></div>'
								+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ concat.object.tcode +'">%</span></div></div></div>'
								+'<div><div><span>시작 날짜 : '+concat.object.tsdate+'</span></div><div><span>종료 날짜 : '+concat.object.tedate+'</span>'
								+'<div class="bts"><button style="border:0px;outline:none;color:white;background-color:#ed8151; margin-right:5px; font-size:12px;" class="btn" onclick= "privateCreate(\''+concat.object.tsdate+ ',' +concat.object.tedate+'\','+concat.object.tcode+')" type="button">개인업무생성</button></div><div></div></div></div></div>';
								$("#ptcreatebtn").hide();
								$("#methodptcreatebtn").hide();
								$("#mymethodptcreatebtn").hide();
	        			 }
	        			 $("#publictaskBOTTOM").append($append);
	        			 
	        			 var a = $("#chart"+concat.object.tcode.toString());
	 					 var percent = parseInt(a.data('percent'));
	 					 var deg = 360 * percent / 100;
	 						if (percent > 50) {
	 							a.addClass("gt-50");
	 						}
	 					 var b=$("#fill"+concat.object.tcode.toString());
	 					 b.css('transform', 'rotate(' + deg + 'deg)');
	 					 $('#num'+concat.object.tcode.toString()).html(percent + '%'); 
        	     	}
        		}else if(concat.type=="publictasks"){
        			for(var a=0;a<concat.object.response.length;a++){
	        			if(concat.object.response[a].tcode==concat.object.response[a].trefference){
		        			 if(chatpermission=="OWNER"){
		        				 var $append = '<div id="publictask'+concat.object.response[a].tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
									+'<div data-toggle="tootlip" data-placement="right" title="하위 업무 보기" onclick="godowntask('+concat.object.response[a].tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+concat.object.response[a].tcolor+';"><span>'+ 11 +'. : '+concat.object.response[a].ttitle+'</span></div>'
									+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
									+'<div style="margin-left:20px;" id="chart'+concat.object.response[a].tcode+'" class="progress-pie-chart" data-percent="'+concat.object.response[a].tpercent+'">'
									+'<div class="ppc-progress">'
									+'<div class="ppc-progress-fill" id="fill'+concat.object.response[a].tcode+'"></div></div>'
									+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ concat.object.response[a].tcode +'">%</span></div></div></div>'
									+'<div><div><span>시작 날짜 : '+concat.object.response[a].tsdate+'</span></div><div><span>종료 날짜 : '+concat.object.response[a].tedate+'</span></div>'
									+'<div class="bts"><button onclick="downtaskcreate(\''+concat.object.response[a].tsdate+ ',' +concat.object.response[a].tedate+'\','+concat.object.response[a].tcode+')" style="border:0px;outline:none;color:white;background-color:#ed8151; margin-right:5px; font-size:12px;" class="btn"type="button">하위 업무 생성</button>'
									+'<button style="border:0px;outline:none;color:white;background-color:#ed8151;margin-right:5px;font-size:12px;" class="btn" onclick= "ptedit(\''+concat.object.response[a].tsdate+ ',' +concat.object.response[a].tedate+'\','+concat.object.response[a].tcode+')" type="button">수정</button>'
									+'<button style="border:0px;outline:none;color:white;background-color:#ed8151;font-size:12px;" class="btn" type="button" onclick="ptdel('+concat.object.response[a].tcode+')">삭제</button></div></div></div></div>';
									$("#ptcreatebtn").show();
		        			 }
		        			 else if(chatpermission=="MEMBER"){
		        					var $append = '<div id="publictask'+concat.object.response[a].tcode+'" style="float: left; width: 24%; margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
									+'<div data-toggle="tootlip" data-placement="right" title="하위 업무 보기" onclick="godowntask('+concat.object.response[a].tcode+')" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+concat.object.response[a].tcolor+';"><span>'+ 11 +'. : '+concat.object.response[a].ttitle+'</span></div>'
									+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
									+'<div style="margin-left:20px;" id="chart'+concat.object.response[a].tcode+'" class="progress-pie-chart" data-percent="'+concat.object.response[a].tpercent+'">'
									+'<div class="ppc-progress">'
									+'<div class="ppc-progress-fill" id="fill'+concat.object.response[a].tcode+'"></div></div>'
									+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ concat.object.response[a].tcode +'">%</span></div></div></div>'
									+'<div><div><span>시작 날짜 : '+concat.object.response[a].tsdate+'</span></div><div><span>종료 날짜 : '+concat.object.response[a].tedate+'</span>'
									+'<div class="bts"><button style="border:0px;outline:none;color:white;background-color:#ed8151; margin-right:5px; font-size:12px;" class="btn" onclick= "privateCreate(\''+concat.object.response[a].tsdate+ ',' +concat.object.response[a].tedate+'\','+concat.object.response[a].tcode+')" type="button">개인업무생성</button></div><div></div></div></div></div>';
									$("#ptcreatebtn").hide();
									$("#methodptcreatebtn").hide();
									$("#mymethodptcreatebtn").hide();
		        			 }
		        			 $("#publictaskBOTTOM").append($append);
		        			 
		        			var ab = $("#chart" + concat.object.response[a].tcode.toString());
		 					var percent = parseInt(ab.data('percent'));
		 					var deg = 360 * percent / 100;
		 						if (percent > 50) {
		 							ab.addClass("gt-50");
		 						}
		 					var b=$("#fill" + concat.object.response[a].tcode.toString());
		 					b.css('transform', 'rotate(' + deg + 'deg)');
		 					$('#num'+concat.object.response[a].tcode.toString()).html(percent + '%'); 
       	     			}
        			}
        		}
        	 }
        	 
        	 if(concat.message=="update"){
        	 	if(concat.type=="publictaskvo"){
        	 		//퍼센트 , 날짜, 제목
        	 		$("#ttitle" + concat.object.tcode).text(concat.object.ttitle);
        	 		$("#tsdate" + concat.object.tcode).text('시작 날짜 : '+concat.object.tsdate);
        	 		$("#tedate" + concat.object.tcode).text('종료 날짜 : '+concat.object.tedate);
        	 		$("#color" + concat.object.tcode).css('border', '3px solid #'+concat.object.tcolor);
        	 		$("#chart" + concat.object.tcode).attr("data-percent", parseInt(concat.object.tpercent));
        	 		
        	 		var a = $("#chart"+concat.object.tcode.toString());
					var percent = parseInt(a.data('percent'));
					var deg = 360 * percent / 100;
						if (percent > 50) {
							a.addClass("gt-50");
						}
					var b=$("#fill"+concat.object.tcode.toString());
					b.css('transform', 'rotate(' + deg + 'deg)');
					$('#num'+concat.object.tcode.toString()).html(percent + '%'); 
        	 		
        	 	}
        	 }
        	 
        	 if(concat.message=="delete"){
        		 if(concat.type=="publictaskvo") {
        			 $("#publictask"+concat.object.tcode).remove();
        		 }
        	 }
         });
    });
    $('[data-toggle="tootlip"]').tooltip();
});


 //공용업무 생성하기
 function ptcreate(pcode){
	 var popW = 500; // 띄울창의 가로사이즈
	 var popH = 400; // 띄울창의 세로사이즈
	 window.open("/project/publicTask/create?pcode="+pcode+"&tsdate="+fixpsdate+"&tedate="+fixpedate,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
 }
 
// 공용업무 삭제
 function ptdel(tcode){
	 event.stopPropagation();
	 if(confirm('업무를 삭제하시겠습니까?')==true){
		$.ajax({
			type : 'DELETE',
			url : '/publictask/' + tcode,
			success : function(response) {
				if (response>0) {
					alert('공용업무 삭제에 성공 했습니다.');
					var peram={
							 'message' : 'delete',
							 'type' : 'publictaskvo',
							 'object' :{
									 'tcode' : tcode
								}
						 };
					stompClient.send('/app/project/'+pcode, {},JSON.stringify(peram));
				} else{
					alert('Server or Client ERROR, 공용업무 삭제에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	 }
	 else return;
 }
 
 //공용업무 수정
 function ptedit(date, tcode){
	 event.stopPropagation();
	 var popW = 400; // 띄울창의 가로사이즈
	 var popH = 600; // 띄울창의 세로사이즈
	 
	 var list={};
	 list = date.split(',');
	 
	 if(confirm('업무를 수정하시겠습니까?')==true){
			window.open("/project/publicTask/edit?tsdate="+list[0]+"&tedate="+list[1]+"&tcolor="+list[2]+"&tcode="+tcode+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	 }
	 else return;
 }
 
 //하위업무로 이동
  function godowntask(tcode){
	event.stopPropagation();
	 if(confirm('하위 업무로 이동하시겠습니까?')==true){
		 $("#ptcreatebtn").hide();
		 $("#methodptcreatebtn").hide();
		 $("#mymethodptcreatebtn").hide();
		 $("#publictaskBOTTOM").load("/project/publicTask/downTask?tcode="+tcode); 
		 $btntag='<button class="btn" type="button" onclick="goroottask('+pcode+')" style="background-color:#ed8151; border:0;outline:none; color:white;margin-right:5px;">최상위 공용업무로 이동</button>'
		 +'<button class="btn" type="button" onclick="gotasklist('+pcode+')" style="background-color:#ed8151; border:0;outline:none; color:white;">공용업무 리스트로 이동</button>';
		 $("#publictaskTOP").append($btntag);
	 }else return;
 } 
 
 //개인 업무 생성
 function privateCreate(date,tcode){
	 event.stopPropagation();
	 var popW = 500; 
	 var popH = 400; 
	 var list={};
	 list = date.split(',');
	 
	 window.open("/project/privateTask/create?tsdate="+list[0]+"&tedate="+list[1]+"&tcode="+tcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
 }
 
 //하위 업무 생성
 function downtaskcreate(date,tcode){
	 event.stopPropagation();
	 var popW = 500; 
	 var popH = 400; 
	 var list={};
	 list=date.split(',');
	 window.open("/project/publicTask/downTaskCreate?tsdate="+list[0]+"&tedate="+list[1]+"&tcode="+tcode+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
 	}
 
 //저장된 방법론으로 공용업무 생성하기
 function methodptcreate(){
	 var popW = 500; 
	 var popH = 400; 
	 window.open("/project/method/publicTask/create?tsdate="+fixpsdate+"&tedate="+fixpedate+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
 }
 
 function mymethodptcreate(){
	 var popW = 500; 
	 var popH = 400; 
	 window.open("/project/mymethod/publicTask/create?tsdate="+fixpsdate+"&tedate="+fixpedate+"&realpcode="+<%=pcode%>,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	 
 }
  
</script>

</html>