<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<!-- 전체적인 Bootstrap resource -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Perspective Page View Navigation: wefwefwe" />
<meta name="keywords"
	content="3d page, menu, navigation, mobile, perspective, css transform, web development, web design" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico">


<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/taskdocMain/normalize.css?ver=4262" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/taskdocMain/demo.css?ver=4262" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/taskdocMain/component.css?ver=22263" />
<script
	src="${pageContext.request.contextPath }/resources/js/taskdocMain/modernizr.custom.25376.js"></script>

<!-- /전체적인 Bootstrap resource -->
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>


</head>
<body>
	<div id="perspective" class="perspective effect-airbnb">
		<div class="container">
			<div class="wrapper">
				<div class="codrops-top clearfix">
					<a><span style="font-size:14px;font-family:Title_Light;">TaskDoc</span></a>

					<!-- LOGIN BUTTON -->
					<span class="right">
						<button id="LoginButton">
							<span style="font-size: 14px;font-family:Title_Light;">LOGIN</span>
						</button> <!-- /LOGIN BUTTON --> <!-- JOIN BUTTON -->
					</span>
					 <span class="right">
						<button id="JoinButton">
							<span style="font-size: 14px;font-family:Title_Light;">JOIN</span>
						</button> <!-- /JOIN BUTTON -->
					</span>
				</div>
				
				<header class="codrops-header" style="margin-bottom:-48px;">
					<span style="font-family: Title_Medium;font-size:90px;color:#ed8151;">
						TaskDoc <span style="font-size:30px;">Task(작업) + Document(기록)를 이용한 프로젝트 관리 서비스</span>
					</span>
				</header>


				<div class="main clearfix" style="margin-top:50px;">
					<div style="display:grid;text-align:center;">
						<p style="font-family:Title_Light; font-size:20px;color:#aca89a;margin-top:-1px;"><span style="color:#ed8151; font-size:30px; font-family: Title_Bold">Project</span> 창의적인 아이디어를 결정하여 프로젝트로 선정 합니다.</p>
						<p style="font-family:Title_Light; font-size:20px;color:#aca89a;margin-top:-1px;"><span style="color: rgb(99, 164, 137); font-size:30px; font-family: Title_Bold">Methodology</span> 프로젝트를 진행하는데 도움을 줄 방법론을 선정하여 기본적인 틀을 잡아 줄 수 있습니다.</p>
						<p style="font-family:Title_Light; font-size:20px;color:#aca89a;margin-top:-1px;"><span style="color: rgba(111, 88, 100, 1);font-size:30px; font-family: Title_Bold">Authority</span> 팀장과 팀원의 권한을 구분하여 프로젝트를 효율적으로 관리할 수 있습니다.</p>
						<p style="font-family:Title_Light; font-size:20px;color:#aca89a;margin-top:-1px;"><span style="color: rgba(224, 170, 50, 1);font-size:30px; font-family: Title_Bold">Chatting</span> 일반 채팅 기능과 회의모드, 파일 업로드, 투표 등의 기능을 통해 의사소통 활성화에 도움을 줄 수 있습니다.</p>
						<p style="font-family:Title_Light; font-size:20px;color:#aca89a;margin-top:-1px;"><span style="color: rgba(11, 117, 116, 1);font-size:30px; font-family: Title_Bold">Gantt Chart</span> 프로젝트 전체 진행도를 한눈에 볼 수 있도록 도와주고 자신의 개인 업무 체크 또한 가능하게 도와줄 수 있습니다.</p>
						<p style="font-family:Title_Light; font-size:20px;color:#aca89a;margin-top:-1px;"><span style="color: rgba(217, 133, 101, 1);font-size:30px; font-family: Title_Bold">Output</span> 프로젝트 진행중, 업무에 대한 산출물을 팀장이 관리하고 승인 할 수 있습니다.</p>
					</div>
					<div class="related">
						<p style="font-family:Title_Light;">Copyright 2018. TaskDoc all rights reserved.</p>
						<p>
							<a href="" style="font-family:Title_Light;">WELCOME TO</a>
						</p>
						<p>
							<a href=""style="font-family:Title_Light;">TaskDoc</a>
						</p>
					</div>
				</div>
				<!-- /main -->
			</div>
			<!-- wrapper -->
		</div>
	</div>

<script type="text/javascript">

	$(function() {
		$("#JoinButton").click(function() {
			location.href = '/user/join';
		});
		$("#LoginButton").click(function() {
			location.href = '/user/login';
		});
	});
	
	</script>
</html>