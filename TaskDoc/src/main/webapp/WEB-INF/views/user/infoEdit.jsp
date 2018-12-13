<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String paramId=request.getParameter("id");
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
	<!--FRAME  -->
	<div id="frame">

		<!--MAIN HEADER  -->
		<%@include file="/WEB-INF/views/fix/main_header.jsp"%>
		<!--MAIN HEADER  -->

		<!--WRAPPER  -->
		<div id="wrapper">

			<!--SIDE BAR  -->
			<%@include file="/WEB-INF/views/fix/left_side.jsp"%>
			<!--SIDE BAR  -->

			<!--CONTENTWRAP  -->
			<div id="contentwrap" style="background-color: #e0e0e0;">
				<div class="container" style="display: table; vertical-align: middle;">
					<div class="main"
						style="border: 1px solid rgba(0, 0, 0, 0.2); box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5); background-color: white; display: table-cell;">
						<div id="1"
							style="width: 100%; border-bottom: 1px solid rgba(0, 0, 0, 0.2);">
							<span id="u" style="margin-left: 20px; font-size: 20px;">회원
								정보 수정</span>
						</div>
						<div id="2" class="bts" style="width: 100%; margin-top: 10px;">
							<span>아이디</span> <input id="uid"
								style="width: 80%; margin-top: 5px;" type="text"
								class="form-control" readonly="readonly">
						</div>
						<div id="3" class="bts" style="width: 100%;">
							<span>비밀번호</span> <input id="upasswd"
								style="width: 80%; margin-top: 5px;" type="password"
								class="form-control">
						</div>
						<div id="4" class="bts" style="width: 100%;">
							<span>이름</span> <input id="uname"
								style="width: 80%; margin-top: 5px;" type="text"
								class="form-control">
						</div>
						<div id="5" class="bts" style="width: 100%;">
							<span>상태메세지</span> <input id="ustate"
								style="width: 80%; margin-top: 5px;" type="text"
								class="form-control">
						</div>
						<div id="6" class="bts" style="width: 100%;">
							<span>휴대폰번호(' - ' 는 빼주시고 입력해주세요.)</span> <input id="uphone"
								style="width: 80%; margin-top: 5px;" type="text"
								class="form-control">
						</div>
						<div id="7"
							style="width: 100%; border-top: 1px solid rgba(0, 0, 0, 0.2);">
							<div style="width: 100%; height: 30%;">
								<span id="userinfor"
									style="float: right; margin-right: 5px; margin-top: 5px; color: rgba(0, 0, 0, 0.8);'">TASKDOC
									(은)는 개인정보 방침을 준수합니다.</span>
							</div>

							<div class="bts" style="height: 70%; margin-top: 16px;">
								<button type="button"
									style="margin-left: 7px; float: left; background-color: #ed8151; border: 0; outline: none;"
									class="btn btn-success" onclick="userdel()">회원탈퇴</button>
								<button type="button"
									style="float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;"
									class="btn btn-success" onclick="cancel()">Cancel</button>
								<button type="button" class="btn btn-success" onclick="edit()"
									style="margin: auto 0; margin-left: 6px; float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;">Edit</button>
								<button type="button" class="btn btn-success" onclick="gomymethodlist()"
									style="margin: auto 0; margin-left: 6px; float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;">내 방법론 리스트 보기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--PROJECT_WRAP -->

		</div>
		<!--CONTENTWRAP  -->

		<!-- FOOTER -->
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
		<!-- FOOTER -->
	</div>
	<!--FRAME  -->

</body>


<script>
var savepasswd="";

	$(document).ready(function() {
		var contentwWidth = $("#contentwrap").width();
		var contentHeight = $("#contentwrap").height();

		var mainwidth = parseFloat(contentwWidth / 2.4);
		$(".main").css('width', mainwidth);

		var mainheight = parseFloat(contentHeight / 1.3);
		$(".main").css('height', mainheight);

		$("#1").css('height', mainheight / 7 + "px");
		$("#1").css('line-height', mainheight / 7 + "px");
		for (var i = 2; i < 7; i++) {
			$("#" + i).css('height', mainheight / 7 + "px");
			$("#" + i).css('margin-left', "20px");
		}
		$("#7").css('height', mainheight / 7 + "px");

		var buttonwidth = parseFloat(mainheight / 3 + "px");
		$("#a").css('width', buttonwidth + "px");
		$("#b").css('width', buttonwidth + "px");
		$("#c").css('width', buttonwidth + "px");

		var margintop = parseFloat(contentHeight / 10);
		$(".container").css('margin-top', margintop + "px");
		
		/*회원 정보 수정을위해 정보를 불러오기*/
		$.ajax({
			type : 'GET',
			url : '/userinfo/' + '<%=paramId%>',
			success : function(response) {
				//Object.keys(response).length --> 자바리턴값이 Object일때 Object 의 크기 구하는법
				if (Object.keys(response).length > 0) {
					alert('유저정보 조회가 완료 되었습니다.');
					savepasswd=response.upasswd;
					$('#uid').val(response.uid);
					$('#upasswd').val(response.upasswd);
					$('#uname').val(response.uname);
					$('#ustate').val(response.ustate);
					$('#uphone').val(response.uphone);
				} else {
					alert('유저정보 조회가 실패 되었습니다.')
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	});
	/*/회원 정보 수정을위해 정보를 불러오기*/
	
	

/* 회원 정보 수정 처리*/
function edit() {
	var param = {
		'uid' : '<%=loginid%>',
		'upasswd':savepasswd,
		'uname' : $("#uname").val(),
		'ustate' : $("#ustate").val(),
		'uphone' : $("#uphone").val()
	};
	$.ajax({
		type : 'PUT',
		url : '/userinfo',
		contentType : 'application/json',
		data : JSON.stringify(param),
		success : function(response) {
			if (response >0) {
				alert('회원정보 수정이 완료 되었습니다.');
			} else {
				alert('Server or Client ERROR, 회원정보 수정이 실패 되었습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
/*/회원 정보 수정 처리*/

function userdel(){
	if(confirm("※회원 탈퇴를 하시겠습니까?")==true){
		$.ajax({
			type : 'DELETE',
			url : '/userinfo/' + '<%=loginid%>',
			success : function(response) {
				/* response 1 or -1
				 */
				if (response >0) {
					alert('회원  탈퇴가 완료 되었습니다. 감사합니다.');
					window.location.href='/';
				} else {
					alert('Server or Client ERROR, 회원 탈퇴에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}else{
		return;
	}
}
function cancel() {
	location.href = '/project/main';
}

function gomymethodlist(){
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight;
	var popW = 600; 
	var popH = 250; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2;  
	window.open("/user/methodlist","",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}
</script>
</html>