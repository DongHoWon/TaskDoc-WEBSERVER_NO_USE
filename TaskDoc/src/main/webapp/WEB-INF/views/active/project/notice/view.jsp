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
					<h4 class="modal-title">공지사항을 상세보기</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>제목</label> <input id="noticetitle" type="text"
							class="form-control"readonly="readonly" style="background-color:white;"> 
						<div>
						<label style="margin-top:5px;">게시 시간 : </label><label class="asdf"></label>
						</div>	
							<label
							style="padding-top: 5px;">내용</label> <textarea id="noticecontents"
							class="form-control" readonly="readonly" style="height:100px; background-color:white;"></textarea>
					</div>
					<div class="modal-footer">
						<input type="hidden" name="isEmpty">
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
				alert('공지사항 상세보기에 실패 했습니다.')
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
});
function noticeCancel(){
	window.close();
}
</script>

</html>