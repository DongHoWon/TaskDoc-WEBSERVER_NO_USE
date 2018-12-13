<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script  src="${pageContext.request.contextPath }/resources/js/task/jscolor.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String tcode = request.getParameter("tcode");
	String pcode = request.getParameter("pcode");
	String tsdate = request.getParameter("tsdate");
	String tedate = request.getParameter("tedate");
	String tcolor = request.getParameter("tcolor");
%>


</head>
<body>
	<div class="container">
		<h2>공용업무 수정</h2>
		<p>공용업무를 수정해보세요</p>
			<div  class="bts" style="width: 100%; margin-top: 10px;">
				<span>공용업무 제목</span> <input id="pttitle"
					style="width: 80%; margin-top: 5px;" type="text"
					class="form-control" maxlength="20">
			</div>
			
			<div  class="bts" style="width: 100%; margin-top: 10px;">
				<p style="margin-top:20px;"> 공용업무 색상: <input class="jscolor" onchange="update(this.jscolor)" value="" style="width:60px;"> </p>
			</div>
			
			<div class="bts" style="width: 100%; margin-top: 10px;">
				<span>시작날짜</span> <input id="ptsdate" class="form-control"
					style="width: 80%; margin-top: 5px;" type="text">
			</div>
			
			<div  class="bts" style="width: 100%; margin-top: 10px;">
				<span>종료날짜</span> <input id="ptedate" class="form-control"
					style="width: 80%; margin-top: 5px;" type="text">
			</div>
			
			<div  class="bts" style="width: 100%; margin-top: 10px;">
				<span>진행도</span> <input id="ptpercent" class="form-control"
					style="width: 80%; margin-top: 5px;" type="text">
			</div>
			
			<div  class="bts" style="width: 100%; margin-top: 10px;">
				<span>참조</span> <input id="ptrefference" class="form-control" readonly="readonly"
					style="width: 80%; margin-top: 5px;" type="text">
			</div>
			
			<div  class="bts" style="width: 100%; margin-top: 10px;">
				<span>순서</span> <input id="ptsequence" class="form-control" readonly="readonly"
					style="width: 80%; margin-top: 5px;" type="text">
			</div>
			
			<div id="7" style="width: 100%; margin-top: 30px;">
				<div class="bts" style="height: 70%; margin-top: 16px;">
					<button type="button"
						style="float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;"
						class="btn btn-success" onclick="cancel()">Cancel</button>
					<button type="button" class="btn btn-success" onclick="edit()"
						style="margin: auto 0; margin-left: 6px; float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;">Edit</button>
				</div>
			</div>
		</div>
	</body>

<script type="text/javascript">
var pcode=<%=pcode%>;
var mycolor="";
//공용업무 정보받아오기
$(document).ready(function() {
	$.ajax({
		type : 'GET',
		url : '/publictask/publicTaskView/'+<%=tcode%>,
		success : function(response) {
			if (Object.keys(response).length>0) {
				alert('공용업무 조회가 완료 되었습니다.');
				$("#pttitle").val(response.ttitle);
				$(".jscolor").val(response.tcolor);
				mycolor=response.tcolor;
				$("#ptsdate").val(response.tsdate);
				$("#ptedate").val(response.tedate);
				$("#ptpercent").val(response.tpercent);
				$("#ptsequence").val(response.tsequence);
				$("#ptrefference").val(response.trefference);
			} else {
				alert('Server or Client ERROR, 공용업무 조회에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
			}
	});
	
});


function update(jscolor) {
    // 'jscolor' instance can be used as a string
    $("#rect").css('background-color','#'+jscolor);
    var removeData='#'+jscolor;
    //#제거
    mycolor=removeData.replace("#","");
}	 


var fixpsdate='<%=tsdate%>';
var fixpedate='<%=tedate%>';

//프로젝트 수정시 datepicker api사용
$(function() {
	$.datepicker.regional['ko'] = {
		closeText : '닫기',
		prevText : '이전달',
		nextText : '다음달',
		currentText : '오늘',
		monthNames : [ '1월(JAN)', '2월(FEB)', '3월(MAR)', '4월(APR)',
				'5월(MAY)', '6월(JUN)', '7월(JUL)', '8월(AUG)', '9월(SEP)',
				'10월(OCT)', '11월(NOV)', '12월(DEC)' ],
		monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
				'9월', '10월', '11월', '12월' ],
		dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
		dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
		weekHeader : 'Wk',
		dateFormat : 'yy-mm-dd',
		firstDay : 0,
		isRTL : false,
		showMonthAfterYear : true,
		yearSuffix : '',
		changeMonth : true,
		changeYear : true,
		showButtonPanel : false,
		yearRange : 'c-99:c+99',
	};
	$.datepicker.setDefaults($.datepicker.regional['ko']);

	$('#ptsdate').datepicker();
	$("#ptsdate").datepicker("option", "minDate",fixpsdate);
	$('#ptsdate').datepicker("option", "maxDate",fixpedate);
	$('#ptsdate').datepicker("option", "onClose", function(selectDate) {
	$("#ptedate").datepicker("option", "minDate", selectDate);
	});

	$('#ptedate').datepicker();
	$("#ptedate").datepicker("option", "minDate",fixpsdate);
	$("#ptedate").datepicker("option", "maxDate",fixpedate);
	$('#ptedate').datepicker("option", "onClose", function(selectDate) {
	$("#ptsdate").datepicker("option", "maxDate", selectDate);
	});
	
	var socket = new SockJS('/goStomp'); 
	stompClient = Stomp.over(socket);
});

//돌아가기
function cancel() {
	window.close();
}


//공용업무 수정.
function edit(){
		var param = {
			'ttitle' : $("#pttitle").val(),
			'tcolor' : mycolor,
			'tsdate' : $("#ptsdate").val(),
			'tedate' : $("#ptedate").val(),
			'tpercent' : $("#ptpercent").val(),
			'trefference' : $("#ptrefference").val(),
			'tsequence' : $("#ptsequence").val(),
			'tcode' : <%=tcode%>
		};
		$.ajax({
			type : 'PUT',
			url : '/publictask',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response>0) {
					alert('공용업무 수정 완료!');
					//stomp 서버전송
					var peram={
							 'message' : 'update',
							 'type' : 'publictaskvo',
							 'object' : param
						 };
						stompClient.send('/app/project/'+pcode, {},JSON.stringify(peram));
				} else{
					alert('Server or Client ERROR, 공용업무 수정 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
				}
		});
	}
/* } */

</script>
</html>