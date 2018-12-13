<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode=request.getParameter("pcode");
%>
<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
//pro_header.jsp , pro_header.js 에서 <script>태그 안에서 변수 사용가능하다.	
var pcode=<%=pcode%>;
$(function(){
$(".chat_hover").css('color','#ed8151').css('border-bottom','1px solid #ed8151');
$(".ptask_hover").css('color','#6d6d6d').css('border-bottom','none');
$(".gantt_hover").css('color','#6d6d6d').css('border-bottom','none');
$(".files_hover").css('color','#6d6d6d').css('border-bottom','none');
});
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
				<div class="container"
					style="background-color: white; overflow: auto;">

					<!-- PROJECT_FIX_HEADER  -->
					<%@include file="/WEB-INF/views/active/project/fix/pro_header.jsp"%>

					<!-- CHAT CONTENTS  -->
					<div  id="chatcontainer" style="width: 100%; height: 87%; display:-webkit-box; ">
						
						<div id="leftchatlist" style="width:15%; height:100%;" >
							<div id="chatADD" style="width:100%;height:5%;" class="">
								<img data-toggle="tootlip" data-placement="right" title="채팅방 만들기" id="chatadd" src="${pageContext.request.contextPath }/resources/img/img_chatadd.png" style="height:100%;cursor: pointer;">
							</div>
							<div id="chatlistTOP" style="width:100%;height:15%;"></div>
							<div id="chatlistBOTTOM" style="width:100%;height:80%;overflow:auto;"></div>
						</div>
						
						<div id="rightchatlist" style="width: 85%; height: 100%;">
						</div>
						
					</div>
				</div>
			</div>
		</div>
		<!-- FOOTER -->
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
		<!-- FOOTER -->

	</div>
	<!--FRAME  -->
</body>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/chat/main.js"></script>
</html>

