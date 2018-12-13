<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script  src="${pageContext.request.contextPath }/resources/js/task/jscolor.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String tcode=request.getParameter("tcode");
	String tsdate=request.getParameter("tsdate");
	String tedate=request.getParameter("tedate");
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
<div class="container">
		<div class="row">
			<div class="modal-content">
				
				<div class="modal-header">
					<button type="button" class="close">
						<i class="fa fa-times"></i>
					</button>
					<h4 class="modal-title">개인 업무 생성을 환영합니다.</h4>
				</div>
				
				<div class="modal-body">
					
					<div class="form-group">
						<label>개인 업무명</label> 
						<input id="pttitle" type="text"	class="form-control" maxlength="20">
						<p style="margin-top:20px;"> 개인 업무 색상: <input class="jscolor" onchange="update(this.jscolor)" value="" style="width:60px;"> </p>	
					</div>
					
					<div>
						시작날짜: <input class="form-control" type="text" id="psdate">
					</div>
					
					<div>
						종료날짜: <input class="form-control" type="text" id="pedate">
					</div>
					
					<div class="modal-footer">
						
						<button type="button" class="btn btn-success btn-icon" style="outline: none;border:0px;background-color:#ed8151;color:white;"
							onclick="ptCreate()">
							Create PrivateTask
						</button>
						
						<button type="button" class="btn btn-default btn-icon" style="outline: none;border:0px;background-color:#ed8151;color:white;"
							onclick="Cancel()">
							Cancel
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
var mycolor="";
var fixpsdate='<%=tsdate%>';
var fixpedate='<%=tedate%>';
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
	
	$('#psdate').datepicker();
	$("#psdate").datepicker("option", "minDate",fixpsdate);
	$('#psdate').datepicker("option", "maxDate",fixpedate);
	$('#psdate').datepicker("option", "onClose", function(selectDate) {
	$("#pedate").datepicker("option", "minDate", selectDate);
	});

	$('#pedate').datepicker();
	$("#pedate").datepicker("option", "minDate",fixpsdate);
	$("#pedate").datepicker("option", "maxDate",fixpedate);
	$('#pedate').datepicker("option", "onClose", function(selectDate) {
	$("#psdate").datepicker("option", "maxDate", selectDate);
	});
});


function update(jscolor) {
    // 'jscolor' instance can be used as a string
    $("#rect").css('background-color','#'+jscolor);
    var removeData='#'+jscolor;
    //#제거
    mycolor=removeData.replace("#","");
}
 
function Cancel(){
	window.close();
} 
function ptCreate(){
	//개인 업무 생성 
	var param = {
		'pttitle' : $("#pttitle").val(),
		'ptcolor' : mycolor,
		'ptsdate' : $("#psdate").val(),
		'ptedate' : $("#pedate").val(),
		'ptrefference' : null,
		'tcode' : <%=tcode%>,
		'uid' : id
	}; 
	$.ajax({
		type : 'POST',
		url : '/privatetask',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response>0) {
				alert('개인 업무 생성이 완료 되었습니다.');
				window.close();
			} else{
				alert('Server or Client ERROR, 개인 업무 생성에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
</script>
</html>