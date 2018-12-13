<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
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
	
var pcode=<%=pcode%>;
</script>
</head>

<body>
<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">폴더 생성을 환영합니다.</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>폴더 명</label> 
						<input id="pttitle" type="text"	class="form-control" maxlength="20">
					</div>
					
					<div class="modal-footer">
						
						<button type="button" class="btn btn-success btn-icon" style="outline: none;border:0px;background-color:#ed8151;color:white;"
							onclick="ptCreate()">
							<i class="fa fa-check"></i> Create PublicTask
						</button>
						
						<button type="button" class="btn btn-default btn-icon" style="outline: none;border:0px;background-color:#ed8151;color:white;"
							onclick="Cancel()">
							<i class="fa fa-times-circle"></i> Cancel
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
var socket = new SockJS('/goStomp'); 
stompClient = Stomp.over(socket);

 
function Cancel(){
	window.close();
} 
function ptCreate(){
	//공용 업무 생성 
	var param = {
		'ttitle' : $("#pttitle").val(),
		'trefference' : null,
		'pcode' : pcode
	};
	$.ajax({
		type : 'POST',
		url : '/publictask',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response > 0) {
				alert('폴더 생성이 완료 되었습니다.');
				//stomp 서버전송
				var peram={
						 'message' : 'insert',
						 'type' : 'publictaskvo',
						 'object' :{
								 'ttitle' : $("#pttitle").val(),
								 'trefference' : null,
								 'tcode' : response,
								 'pcode' : parseInt(pcode)
							}
					 };
					stompClient.send('/app/project/'+pcode, {},JSON.stringify(peram));
					window.close();
					
			} else  {
				alert('Server or Client ERROR, 폴더 생성에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
	
</script>
</html>