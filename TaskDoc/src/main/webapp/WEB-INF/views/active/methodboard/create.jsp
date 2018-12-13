<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
%>

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
					style="display: table; vertical-align: middle;">
					<div class="main"
						style="border: 1px solid rgba(0, 0, 0, 0.2); box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5); background-color: white; display: table-cell;">
						<div id="1"
							style="width: 100%; border-bottom: 1px solid rgba(0, 0, 0, 0.2);">
							<span id="u" style="margin-left: 20px; font-size: 20px;">글
								작성하기</span>
						</div>

						<div id="2" class="bts" style="width: 100%; margin-top: 10px;">
							<span>제목</span> <input id="mtitle"
								style="width: 80%; margin-top: 5px;" type="text"
								class="form-control" maxlength="20">
						</div>

						<div id="3" class="bts" style="width: 100%;">
							<span>내용</span>
							<textarea id="mcontent"
								style="width: 80%; margin-top: 5px; height: 85%;"
								class="form-control"></textarea>
						</div>

						<div id="6" class="bts" style="width: 100%;">
							<button type="button"
								style="margin-left: 7px; float: left; background-color: #ed8151; border: 0; outline: none; margin-top: 20px;"
								class="btn btn-success" onclick="selectProject()"
								id="selectProject">프로젝트 선택하기</button>
						</div>
						<div id="7"
							style="width: 100%; border-top: 1px solid rgba(0, 0, 0, 0.2);">
							<div class="bts" style="height: 70%; margin-top: 23px;">
								<button type="button" class="btn btn-success"
									onclick="boardCancel()"
									style="margin: auto 0; margin-left: 6px; float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;">CANCEL</button>
								<button type="button"
									style="float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;"
									class="btn btn-success" onclick="boardCreate()">CREATE</button>
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
	$(document).ready(function() {
		var contentwWidth = $("#contentwrap").width();
		var contentHeight = $("#contentwrap").height();

		var mainwidth = parseFloat(contentwWidth / 2);
		$(".main").css('width', mainwidth);

		var mainheight = parseFloat(contentHeight / 1.3);
		$(".main").css('height', mainheight);

		$("#1").css('height', mainheight / 7 + "px");
		$("#1").css('line-height', mainheight / 7 + "px");

		$("#2").css('height', mainheight / 7 + "px");
		$("#2").css('margin-left', "20px");

		$("#3").css('height', $("#2").height() * 3 + "px");
		$("#3").css('margin-left', "20px");

		$("#6").css('height', mainheight / 7 + "px");
		$("#6").css('margin-left', "20px");

		$("#7").css('height', mainheight / 7 + "px");

		var buttonwidth = parseFloat(mainheight / 3 + "px");
		$("#a").css('width', buttonwidth + "px");
		$("#b").css('width', buttonwidth + "px");
		$("#c").css('width', buttonwidth + "px");

		var margintop = parseFloat(contentHeight / 10);
		$(".container").css('margin-top', margintop + "px");
	});
	
	var pcode=0;

	var popupX = (window.screen.width / 2) - (500 / 2);
	var popupY= (window.screen.height /2) - (400 / 2);

	function boardCreate(){
		
	if(pcode!=0){
	//게시글 작성하기
	var param = {
				'mbtitle' : $("#mtitle").val(),
				'mbcontents' : $("#mcontent").val(),
				'pcode' : pcode,
				'uid' : '<%=loginid%>'
			};
			$.ajax({
				type : 'POST',
				url : '/methodboard',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response > 0) {
						alert('게시판 생성이 완료 되었습니다.');
						location.href='/methodboard/main';
					} else {
						alert('Server or Client ERROR, 게시판 생성에 실패 했습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
			//게시판 생성시 프로젝트 리스트 받아와서 프로젝트를 추가후 게시판 등록해야함
			//게시글 작성하기
		}
		else{
			alert('프로젝트를 선택해 주세요');
		}
	}
		
		function boardCancel(){
			location.href='/methodboard/main';
		}
		
		//프로젝트 선택할 window창 생성
		function selectProject(){
			window.open("/methodboard/selectProject?uid="+"<%=loginid%>","", "height=400, width=1000, left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY); 
		}
		
		function completeProject(child_pcode){
			pcode=child_pcode;
			$("#selectProject").remove();
			var h3tag=document.createElement("h3");
			var h3ele=document.createTextNode("프로젝트 선택 완료!");
			h3tag.appendChild(h3ele);
			$("#6").append(h3tag);
		}
</script>
</html>