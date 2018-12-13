<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
	String pcode=request.getParameter("pcode");
	String crcode=request.getParameter("crcode");
%>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">회의록을 만들어주세요!</h4>
				</div>

				<div class="modal-body">
					<div class="form-group">
						<label>회의록 제목</label> <input id="focusName" type="text" class="form-control">
					</div>

					<div class="btn-group">
						<div>
							<label>투표를 할 공용업무를 선택해주세요</label>
							<select class="form-control" id="whattask">
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn" onclick="focusOK()" style="background-color:#ed8151;color:white;">
							생성하기
						</button>
						<button type="button" class="btn"
							onclick="decisionCancel()" style="background-color:#ed8151;color:white;">
							 Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">

	//userlist
	var aJsonArray=new Array();

$(function(){
	
	//공용 업무 불러오기
	$.ajax({
		type : 'GET',
		url : '/publictask/' + <%=pcode%>,
		success : function(response) {
			if (response.length != 0) {
				for(var i=0;i<response.length;i++){
					$whattask='<option value="'+response[i].tcode+'">'+ (i+1 )+'.' +response[i].tcode+ response[i].ttitle + '</option>';
					$("#whattask").append($whattask);
				}
				alert('공용업무 리스트를 불러옵니다.');
			} else if (response.length == 0) {
				alert('Server or Client ERROR, 공용업무 리스트 불러오기에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
	//프로젝트에 가입되있는 회원들 불러서 array에 삽입
	 $.ajax({
			type : 'GET',
			url : '/projectjoin/collaboration/'+<%=pcode%>,
			success : function(response) {
				for(var i=0;i<response.projectJoinList.length;i++){
					var obj=new Object();
					obj.uid=response.projectJoinList[i].uid;
					aJsonArray.push(obj);
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
});

//포커스 생성하기
function focusOK(){
	var ulist=[];
	
	var param = {
			'chatRoom' : {
				//회의록 형식이므로 crmode 3번
				'crmode' : 3,
				'crclose' : 0,
				'fctitle' : $("#focusName").val(),
				'tcode' : $("#whattask option:selected").val(),
				'crcoderef': <%=crcode%>
			},
			'userInfo' : aJsonArray,
			'project' : {
				'pcode' : <%=pcode%>,
			}
	};
	$.ajax({
		type : 'POST',
		url : '/chatroom/multicreate',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (Object.keys(response).length>0) {
				alert('채팅방 생성이 완료 되었습니다.');
				opener.parent.focutest(response.crcode,response.crdate,response.crmode,response.fctitle,response.crclose,response.tcode,response.crcoderef);
				//채팅에 넣을것 -> chatcontents db  dmcode,dscode,crcoderef,crcode,dstitle
				opener.parent.chattest(0,0,response.crcode,response.crcode,response.fctitle);
				window.close();
				
				}
			else if(response<0){
				alert('Server or Client ERROR, 채팅방 생성에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
</script>
</html>