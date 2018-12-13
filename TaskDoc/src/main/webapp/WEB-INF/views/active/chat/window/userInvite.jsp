<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode = request.getParameter("pcode");
	String crcode = request.getParameter("crcode");
%>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">회원초대하기</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<div>
							<label style="padding-top: 6px">검색결과</label>
							<div id="tableDiv" style="display: none;">
								<table class="table">

									<!--Table head-->
									<thead id="thead">
										<tr>
											<th>UserID</th>
											<th>★★</th>
										</tr>
									</thead>
									<!--Table head-->

									<!--Table body-->
									<tbody id="userlist">

									</tbody>
									<!--Table body-->

								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<!-- <input type="hidden" name="isEmpty" value=""> -->
					<button type="button" class="btn btn-default btn-icon"
						onclick="chatCreate()">
						<i class="fa fa-times-circle"></i> ok
					</button>
					<button type="button" class="btn btn-default btn-icon"
						onclick="chatCancel()">
						<i class="fa fa-times-circle"></i> Cancel
					</button>

				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	var pcode ="<%=pcode%>";
	var crcode="<%=crcode%>";
	
	//채팅방을 생성한 회원을 제외한 프로젝트에 초대된 회원들을 조회한것을 담을 array
	var array=new Array();
	var nrray=new Array();

	//채팅방에초대할 유저들을 담는 array
	var chkarray=new Array();
	
	$(document).ready(function() {
	//채팅방에 초대하려고 프로젝트 유저리스트들 조회	
	
		var param = {
					'project': {
						'pcode' : parseInt(pcode),
					},
					'chatRoom' : {
						'crcode' : parseInt(crcode)	
					}
				};
		$.ajax({
			type : 'POST',
			url : '/chatroomjoin/userlookup',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
			 if (response.length >0) {
				for(var i=0;i<response.length;i++)
				 	array.push(response[i]);
				//채팅방을 생성한사람은 이미 채팅방에초대되어있기때문에 현재 세션아이디는 제거하고 뿌려줘야함s
				$("#tableDiv").show();

				for (var i = 0; i < array.length; i++) {
					//tr tag create
					var ttag = document.createElement("tr");
					//uid th tag
					var thuid = document.createElement("th");
					//text element저장
					var uidele = document.createTextNode(array[i]);

					ttag.appendChild(thuid);
					thuid.appendChild(uidele);

					//button th tag 
					var thck = document.createElement("th");

					var ckbox = document.createElement("input");
					ckbox.setAttribute('type', 'checkbox');
					ckbox.setAttribute('value', array[i]);
					ckbox.setAttribute('onclick', 'checkEvt(this)');

					ttag.appendChild(thck);
					thck.appendChild(ckbox);
					document.getElementById('thead').appendChild(ttag);
					}
				} else {
					alert('Server or Client ERROR, 채팅방 유저 리스트 조회에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	});
	//채팅방에 초대하려고 프로젝트 유저리스트들 조회	
	
	//채팅방에 초대할 프로젝트 유저 조회 후 체크 하게되면 chkarray에 값이 쌓임
	function checkEvt(chk) {
		if (chk.checked) {
			chkarray.push(chk.value);
		} else {
			chkarray.splice(chkarray.indexOf(chkarray.value), 1);
		}
	}
	//채팅방에 초대할 프로젝트 유저 조회 후 체크 하게되면 chkarray에 값이 쌓임

	
	//채팅 생성 logic
	function chatCreate() {
		//서버에 전송할 list들
		var listparam = [];
		for (var i = 0; i < chkarray.length; i++) {
			listparam.push({
				'crcode' : <%=crcode%>,
				'pcode' : <%=pcode%>,
				'uid' : chkarray[i]
			});
		}
		$.ajax({
			type : 'POST',
			url : '/chatroomjoin/multiple',
			contentType : 'application/json',
			data : JSON.stringify(listparam),
			success : function(response) {
				if (response.length != -1) {
					alert('채팅방에 유저를 초대 완료 하였습니다.');
					window.close();
					opener.location.reload();
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 채팅방에 유저 초대를 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}
	//채팅 생성 logic

	
	//취소시
	function chatCancel() {
		window.close();
	}
</script>
</html>