<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<body>
<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">메모 생성을 환영합니다.</h4>
				</div>
				
				<div class="modal-body">
					<div class="form-group">
						<label>메모내용</label> 
						<textarea id="mcontents"class="form-control"></textarea>
					</div>
					
					<div class="modal-footer">
						
						<button type="button" class="btn btn-success btn-icon"
							onclick="memocreate()" style="background-color:#ed8151;color:white;border:0px;outline:noen;">
							Create Memo
						</button>
						
						<button type="button" class="btn btn-default btn-icon"
							onclick="memoCancel()" style="background-color:#ed8151;color:white;border:0px;outline:noen;">
							Cancel
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
function memocreate(){
	//개인업무 내 메모 생성
	var param = {
			'ptcode': ptcode,
			'mcontents' : $("#mcontents").val()
	};
	$.ajax({
		type : 'POST',
		url : '/memo',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			alert(response);
			if (response>0) {
				alert('메모 생성이 완료 되었습니다.');
				location.href='/project/memo/main?ptcode='+ptcode;
			} else{
				alert('Server or Client ERROR, 메모 생성에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}

function memoCancel(){
	location.href='/project/memo/main?ptcode='+ptcode;
}
</script>
