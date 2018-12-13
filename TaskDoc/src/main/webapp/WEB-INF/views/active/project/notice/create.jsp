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
	String pc=request.getParameter("pcode");
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
					<h4 class="modal-title">공지사항을 게시해주세요</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label>공지사항 제목</label> <input id="noticetitle" type="text"
							class="form-control" maxlength="19"> <label
							style="padding-top: 5px;">공지사항 내용</label> <textarea id="noticecontents"
							class="form-control" style="height:100px;"></textarea>
					</div>
					<div class="modal-footer">
						<input type="hidden" name="isEmpty">
						<button type="button" class="btn" style="background-color:#ed8151;color:white;border:0px;outline:none;"
							onclick="noticeCreate()">
							Create Notice
						</button>
						<button type="button" class="btn" style="background-color:#ed8151;color:white;border:0px;outline:none;"
							onclick="noticeCancel()">
							Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
function noticeCreate(){
	/* 공지사항 생성 */
	var param={
			'pcode': <%=pc%>,
			'ntitle':$("#noticetitle").val(),
			'ncontents':$("#noticecontents").val(),
	};
	$.ajax({
		type : 'POST',
		url : '/notice',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if(Object.keys(response).length>0){
				alert('공지사항 생성 완료');
				opener.parent.location.reload();
				window.close();
			}
			else{
				alert('Server or Client ERROR, 공지사항 생성 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	/* /공지사항 생성  */
}

function noticeCancel(){
	window.close();
}
</script>

</html>