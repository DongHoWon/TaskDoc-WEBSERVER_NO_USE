<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link
	href="${pageContext.request.contextPath }/resources/css/user/login.css?ver=4552"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script
	src="${pageContext.request.contextPath }/resources/css/bootstrap/js/ie-emulation-modes-warning.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/taskdocMain/normalize.css?ver=42" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/taskdocMain/demo.css?ver=42" />
</head>


<body>
	<div class="container">
		<form class="form-signin">
			<h2 class="form-signin-heading" style="font-family: Title_Light">Please sign in</h2>
			<input type="text" id=uid class="form-control" placeholder="ID"
				required autofocus> <input type="password" id="upasswd"
				class="form-control" placeholder="PASSWD">
			<div class="checkbox">
				<label> <input type="checkbox" value="remember-me">
					Remember me
				</label>
			</div>
			<div style="display: grid">
				<button type="button" class="sign" style="font-size: 13px;font-family:Title_Light;">Sign
					in</button>
				<button type="button" class="goMain" style="font-size: 13px;font-family:Title_Light;">Cancel</button>
			</div>
		</form>

		<!-- progressbar div -->
		<div id="myProgress">
			<div id="myBar">10%</div>
		</div>
		<!-- /progressbar div -->

	</div>
</body>
<script type="text/javascript">
var goserveruid="";
	//login창 load시 progress bar 숨기자.
	$(document).ready(function() {
		$("#myBar").hide();
	});
	//login창 load시 progress bar 숨기자.

	//progress bar function
	function move() {
		var elem = document.getElementById("myBar");
		var width = 10;
		var id = setInterval(frame, 10);
		function frame() {
			if (width >= 100) {
				clearInterval(id);
			} else {
				width++;
				elem.style.width = width + '%';
				elem.innerHTML = width * 1 + '%';
				if (width == 100)
					location.href = '/user/loginComplete?uid='+goserveruid;
			}
		}
	}
	//progress bar function

	$(function() {

		/*Cancel시 Main으로*/
		$(".goMain").click(function() {
			location.href = '/';
		});
		/*/Cancel시 Main으로*/

		/*Login 처리*/
		$(".sign").click(function() {
			var param = {
				'uid' : $("#uid").val(),
				'upasswd' : $("#upasswd").val()
			};
			$.ajax({
				type : 'POST',
				url : '/userinfo/login',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					/* ID NULL =>-1
					   PW 틀리면  =>-2
					       성공 => 1
					 */
					if (response == -1) {
						alert('해당되는 ID가 없습니다.');
					} else if (response == -2) {
						alert('비밀번호가 틀렸습니다.');
					} else if (response == 1) {
						alert('로그인 완료');
						goserveruid=$("#uid").val();
						$('.form-signin').css('opacity', 0.3);
						$("#myBar").show();
						move();
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});

		});
		/* /Login 처리*/
	});
</script>
</html>
