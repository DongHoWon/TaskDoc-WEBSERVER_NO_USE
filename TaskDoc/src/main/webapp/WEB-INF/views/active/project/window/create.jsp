<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
%>
<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/user/login';
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
					<h4 class="modal-title">프로젝트 개설을 환영합니다.</h4>
				</div>
				
				<div class="modal-body">
					<div class="form-group">
						<label>프로젝트명</label> <input id="ptitle" type="text"
							class="form-control" maxlength="20"> <label
							style="padding-top: 5px;">부제목명</label> <input id="psubtitle"
							type="text" class="form-control" maxlength="255">
					</div>
					
					<div class="btn-group">
					
					</div>
					<p>
						시작날짜: <input type="text" id="psdate">
					</p>
					<p>
						종료날짜: <input type="text" id="pedate">
					</p>
					<div class="modal-footer">
						<input type="hidden" name="isEmpty">
						
						<button type="button" class="btn"
							onclick="projectCreate()" style="color:white;background-color:#ed8151;outline:none;border:0px;">
							Create Project
						</button>
						
						<button type="button" class="btn"
							onclick="proCancel()" style="color:white;background-color:#ed8151;outline:none;border:0px;">
							 Cancel
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
//프로젝트생성
function projectCreate(){
	//특수문자
	re = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	if($("#ptitle").val()=="" || $("#psdate").val()=="" ||  $("#pedate").val()==""){
		alert('정보를 모두 입력해 주시길 바랍니다.');
	}

	//특수문자 체크
	else if(re.test($("#ptitle").val())){
		alert("프로젝트 제목에 특수문자를 포함할수 없습니다.");
	}

	
	else{
	var param = {
			'userInfo' : {
				'uid' : id,
				},
				'project' : {
					'ptitle' : $("#ptitle").val(),
					'psubtitle' : $("#psubtitle").val(),
					'psdate' : $("#psdate").val(),
					'pedate' : $("#pedate").val()
				}
			};
			$.ajax({
				type : 'POST',
				url : '/project',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response > 0) {
						alert('프로젝트 생성 완료! 프로젝트의 pid값은' + response);
						window.close();
						opener.parent.location='/project/main';
						} else {
						alert('Server or Client ERROR, 프로젝트 생성 실패');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		}
	}

//datepicker api
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
	$("#psdate").datepicker("option", "minDate", 0);
	$('#psdate').datepicker("option", "maxDate", $("#toDate").val());
	$('#psdate').datepicker("option", "onClose", function(selectedDate) {
		$("#pedate").datepicker("option", "minDate", selectedDate);
	});

	$('#pedate').datepicker();
	$("#pedate").datepicker("option", "minDate", 0);
	$('#pedate').datepicker("option", "minDate", $("#psdate").val());
	$('#pedate').datepicker("option", "onClose", function(selectedDate) {
		$("#psdate").datepicker("option", "maxDate", selectedDate);
	});
});
</script>
</html>