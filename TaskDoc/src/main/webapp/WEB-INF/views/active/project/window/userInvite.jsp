<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<%
String loginid="";
loginid=(String)session.getAttribute("loginid");
String pcode = request.getParameter("pcode");

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
			<div class="modal-content" style="height:350px;">
				<div class="modal-header">
					<h4 class="modal-title">회원찾기</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="proid">회원명</label>
						<div>
							<input id="selectuid" type="text"
								style="width: 250px; display: inline-block; margin-right: 10px;"
								class="form-control"> <input
								style="VISIBILITY: hidden; WIDTH: 0px">


							<button type="button" class="btn" style="outline:none;border:0px;background-color:#ed8151;color:white;"
								onclick="userselect()">
								<i class="fa fa-check"></i> 검색하기
							</button>
						</div>
						<div>
							<label style="padding-top: 6px">검색결과</label>
							<div id="tableDiv" style="display: none;">
								<table class="table">

									<!--Table head-->
									<thead>
										<tr>
											<th>#</th>
											<th>UserID</th>
											<th>Name</th>
											<th>★★</th>
										</tr>
									</thead>
									<!--Table head-->

									<!--Table body-->
									<tbody>
										<tr>
											<th scope="row" id="num">1</th>
											<td id="uids"></td>
											<td id="uname"></td>
											<td>
												<button type="button" class="btn"
													onclick="addProuser()" style="outline:none;border:0px;background-color:#ed8151;color:white;">추가</button>
											</td>
										</tr>
									</tbody>
									<!--Table body-->

								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<!-- <input type="hidden" name="isEmpty" value=""> -->
					<button type="button" class="btn" style="outline:none;border:0px;background-color:#ed8151;color:white;" onclick="proCancel()">
						<i class="fa fa-times-circle"></i> Cancel
					</button>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	var saveid = "";
	var pcode =<%=pcode%>;
	
	var socket = new SockJS('/goStomp'); 
	stompClient = Stomp.over(socket);
	
	//프로젝트에 초대하기 위해 아이디 검색
	function userselect() {
		//검색할때 projectjoin select해서 uid, pid 같으면 
		// 이미 초대된 아이디 , 없으면 아래ajax호출
		var param = {
			'pcode' : pcode,
			'uid' : $("#selectuid").val()
		};
		$.ajax({
			type : 'GET',
			url : '/userinfo/' + $("#selectuid").val(),
			success : function(response) {
				if ($("#selectuid").val() == response.uid) {
					$.ajax({
						type : 'POST',
						url : '/projectjoin/projectSelectid',
						contentType : 'application/json',
						data : JSON.stringify(param),
						success : function(abc) {
							if (abc.length <= 0) {
								alert('초대 가능');
								$("#tableDiv").show();
								$("#uids").html(response.uid);
								$("#uname").html(response.uname);
								saveid = response.uid;
							} else {
								alert('이미 초대된 회원입니다.');
								$("#selectuid").val("");
							}
						},
						error : function(e) {
							alert("ERROR : " + e.statusText);
						}
					});
				} else {
					alert('해당하는 아이디가 없습니다.');
					$("#tableDiv").css('display', 'none');
					$("#selectuid").val("");
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});

	}
	//프로젝트에 초대하기 위해 아이디 검색

	//아이디 검색후 프로젝트에 회원 초대, 이미 프로젝트에 추가되었는지 확인 해야함.  
	function addProuser() {
		var param = {
			'pcode' : pcode,
			'uid' : saveid
		};
		$.ajax({
			type : 'POST',
			url : '/projectjoin',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response>0) {
					alert('프로젝트에 사람 초대 완료!');
					$("#tableDiv").css('display', 'none');
					$("#selectuid").val("");
					
					var closego={
							 'message' : 'insert',
							 'type' : 'projectjoinvo',
							 'object' :{
									 'pcode' : <%=pcode%>,
									 'uid' : saveid,
								 	 'ppermission' : 'MEMBER',
									 'pinvite' : 0,
								}
						 };
						stompClient.send('/app/project/'+pcode, {},JSON.stringify(closego));
						
				} else{
					alert('이미 초대된 회원입니다.!');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}
	function proCancel() {
		window.close();
	}
</script>
</html>