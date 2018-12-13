<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>

<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/project/main.js?ver=3925"></script>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String paramId = request.getParameter("id");
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
				<!--PROJECT 가입 O  -->
				<div id="containersTOP" style="margin-top: 20px;"></div>

				<!--position MEMBER  -->
				<div id="containersMIDDLE" style="margin-top: 50px;"></div>


				<!--PROJECT 초대 X  -->
				<div id="containersBOTTOM" style="margin-top: 50px;"></div>
			</div>
		</div>
		
		<!-- FOOTER -->
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
		<!-- FOOTER -->
	</div>
	<!--FRAME  -->
</body>

</html>