<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String mbcode = request.getParameter("mbcode");
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
				<div class="container"
					style="display: table; vertical-align: middle; margin-top: 70px;">
					<div class="main"
						style="border: 1px solid rgba(0, 0, 0, 0.2); box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5); background-color: white; display: table-cell;">
						<div id="1"
							style="width: 100%; border-bottom: 1px solid rgba(0, 0, 0, 0.2);">
							<span id="u" style="margin-left: 20px; font-size: 20px;">게시판
								상세보기</span>
						</div>
						<div id="3" class="bts" style="width: 100%; margin-top: 10px;">
							<label>게시 코드 : </label> <label id="mbcode"> </label>
						</div>
						<div id="4" class="bts" style="width: 100%; margin-top: -10px;">
							<label>프로젝트코코드 : </label> <label id="pcode"> </label>
						</div>
						<div id="5" class="bts" style="width: 100%; margin-top: -10px;">
							<label>게시 시간 : </label> <label id="mbdate"> </label>
						</div>
						<div id="6" class="bts" style="width: 100%; margin-top: -10px;">
							<label>작성자 : </label> <label id="uid"></label>
						</div>
						<div id="7" class="bts"
							style="width: 100%; margin-left: 20px; margin-top: -10px;">
							<label>제목</label> <input id="mbtitle"
								style="width: 80%; margin-top: 5px; background-color: white;"
								type="text" maxlength="20" class="form-control"
								readonly="readonly">
						</div>
						<div id="9" class="bts"
							style="width: 100%; margin-left: 20px; margin-top: 10px;">
							<label>내용</label>
							<textarea id="mbcontents"
								style="width: 80%; height: 85%; background-color: white;"
								class="form-control" readonly="readonly"></textarea>

						</div>

						<div id="viewmethod" class="bts" style="width: 100%;" class="bts">
							<button type="button" class="btn btn-success"
								onclick="promethodInfo()"
								style="margin-left: 6px; float: left; margin-right: 7px; background-color: #ed8151; border: 0; outline: none; margin-top: 5px;">방법론
								상세보기</button>
							<button type="button" class="btn btn-success"
								onclick="getmethod(<%=mbcode %>)"
								style="margin-left: 6px; float: left; margin-right: 7px; background-color: #ed8151; border: 0; outline: none; margin-top: 5px;">방법론 저장하기</button>

						</div>

						<div id="14" class="bts"
							style="width: 100%; border-top: 1px solid rgba(0, 0, 0, 0.2); margin-top: 10px;">
							<button type="button" class="btn btn-success"
								onclick="boardViewCancel()"
								style="margin-left: 6px; float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;">Back</button>
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
var pcode;
	$(document).ready(function() {
		var contentwWidth = $("#contentwrap").width();
		var contentHeight = $("#contentwrap").height();

		var mainwidth = parseFloat(contentwWidth / 2);
		$(".main").css('width', mainwidth);

		var mainheight = parseFloat(contentHeight / 1.3);

		$(".main").css('height', mainheight);

		for (var i = 3; i < 7; i++) {
			$("#" + i).css('height', mainheight / 14 + "px");
			$("#" + i).css('margin-left', "20px");
		}
		$("#viewmethod").css('height', mainheight / 14 + "px");
		$("#viewmethod").css('margin-left', "20px");
		$("#1").css('height', $("#3").height() * 1.5 + "px");
		$("#7").css('height', $("#3").height() * 1.7 + "px");
		$("#9").css('height', $("#3").height() * 5.5 + "px");
		$("#14").css('height', $("#3").height() * 1.3 + "px").css('padding',$("#14").height() / 3);
		$("#u").css('line-height',$("#1").height() + "px");
		//게시판 글 상세보기
		$.ajax({
			type : 'GET',
			url : '/methodboard/'+'<%=mbcode%>',
					success : function(response) {
						if (Object.keys(response).length > 0) {
							pcode = response.pcode;
							$("#mbcode").text(response.mbcode);
							$("#mbcontents").val(response.mbcontents);
							$("#mbdate").text(response.mbdate);
							$("#mbtitle").val(response.mbtitle);
							$("#pcode").text(response.pcode);
							$("#uid").text(response.uid);
						} else {
							alert('Server or Client ERROR, 게시판 상세보기에 실패 했습니다.');
						}
					},
					error : function(e) {
						alert("ERROR : " + e.statusText);
					}
				});
				//게시판 글 상세보기
			});

	//돌아가기
	function boardViewCancel() {
		history.back();
	}

	//프로젝트의 방법론보기
	function promethodInfo() {
		var screenW = screen.availWidth;  // 스크린 가로사이즈
		var screenH = screen.availHeight; // 스크린 세로사이즈
		var popW = 500; // 띄울창의 가로사이즈
		var popH = 500; // 띄울창의 세로사이즈
		var posL=( screenW-popW ) / 2;   
		var posT=( screenH-popH ) / 2;   
		window.open("/methodboard/method/view?pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	}
	
	//중복 오류 잡기..
	function getmethod(mbcode){
		var mltitle=prompt('등록할 방법론리스트의 제목을 입력해주세요','')
		var param={
			'uid' : '<%=loginid%>',
			'mbcode' : mbcode,
			'mltitle' : 'mltitle'
		};
		
		$.ajax({
			type : 'POST',
			url : '/methodlist',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response > 0) {
					alert('방법론 등록하기 성공에 성공 했습니다.');
					window.close();
				} else  {
					alert('Server or Client ERROR, 방법론 등록하기에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}
</script>
</html>