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
	String nc=request.getParameter("ncode");
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
					<h4 class="modal-title">공지사항 수정 하기</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>제목</label> <input id="noticetitle" type="text" maxlength="19"
							class="form-control" style="background-color:white;"> 
						<div>
						<label style="margin-top:5px;">게시 시간 : </label><label class="asdf"></label>
						</div>	
							<label
							style="padding-top: 5px;">내용</label> <textarea id="noticecontents"
							class="form-control" style="height:100px; background-color:white;"></textarea>
					</div>
					<div class="modal-footer">
						<input type="hidden" name="isEmpty">
						<button type="button" class="btn btn-default btn-icon"
							onclick="noticeEdit()" style="background-color: #ed8151; outline: none; border: 0; color: white;">Edit
						</button>
						<button type="button" class="btn btn-default btn-icon"
							onclick="noticeCancel()" style="background-color: #ed8151; outline: none; border: 0; color: white;">Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
		type : 'GET',
		url : '/notice/'+<%=nc%>,
		success : function(response) {
			if(Object.keys(response).length>0){
				$("#noticetitle").val(response.ntitle);
				$(".asdf").text(response.ndate);
				$("#noticecontents").val(response.ncontents);
			}
			else{
				alert('공지사항이 존재하지 않습니다.')
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
});
function noticeEdit(){
	// 공지사항 수정 
	var param={
			'ncode':<%=nc%>,
			'ntitle':$("#noticetitle").val(),
			'ncontents':$("#noticecontents").val(),
	};
	$.ajax({
		type : 'PUT',
		url : '/notice',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			/*
			response는 1 or -1
			*/
			if(response>0){
				alert('공지사항 수정이 완료 되었습니다.');
				opener.parent.location.reload();
				window.close();
			}
			else{
				alert('Server or Client ERROR, 공지사항 수정에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
function noticeCancel(){
	window.close();
}
</script>

</html>