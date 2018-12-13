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
					style="display: table; vertical-align: middle; margin-top:70px;">
					<div class="main"
						style="border: 1px solid rgba(0, 0, 0, 0.2); box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5); background-color: white; display: table-cell;">
						<div id="1"
							style="width: 100%; border-bottom: 1px solid rgba(0, 0, 0, 0.2);">
							<span id="u" style="margin-left: 20px; font-size: 20px;">게시판
								수정하기</span>
						</div>
						<div id="3" class="bts" style="width: 100%; margin-top: 10px;">
							<label >게시 코드 : </label>
							<label id="mbcode"> </label>
						</div>
						<div id="4" class="bts" style="width: 100%;margin-top: -10px;">
							<label >프로젝트코코드 : </label>
							<label id="pcode"> </label>
						</div>
						<div id="5" class="bts" style="width: 100%;margin-top: -10px;">
							<label>게시 시간 : </label>
							<label id="mbdate"> </label>
						</div>
						<div id="6" class="bts" style="width: 100%;margin-top: -10px;">
							<label>작성자 : </label>
							<label id="uid"></label>
						</div>
						<div id="7" class="bts" style="width: 100%; margin-left: 20px;margin-top: -10px;">
							<label>제목</label> <input id="mbtitle"
								style="width: 80%; margin-top: 5px;" type="text" maxlength="20"
								class="form-control">
						</div>
						<div id="9" class="bts" style="width: 100%; margin-left: 20px;margin-top:10px;">
							<label>내용</label>
							<textarea id="mbcontents" style="width: 80%; height: 85%;" class="form-control"></textarea>

						</div>
						
						<div id="editproject" class="bts" style="width: 100%;">
							<button type="button"
								style="margin-left: 7px; float: left; background-color: #ed8151; border: 0; outline: none; margin-top: 20px;"
								class="btn btn-success" onclick="selectProject()"
								id="selectProject">프로젝트 수정하기</button>
						</div>
						
						
						<div id="14" class="bts"
							style="width: 100%; border-top: 1px solid rgba(0, 0, 0, 0.2); margin-top: 10px;">
							<button type="button" class="btn btn-success"
								onclick="boardEditCancel()"
								style="margin-left: 6px; float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;">Back</button>
							<button type="button"
								style="float: right; margin-right: 7px; background-color: #ed8151; border: 0; outline: none;"
								class="btn btn-success" onclick="boardEdit()">Edit</button>
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
var popupX = (window.screen.width / 2) - (500 / 2);
var popupY= (window.screen.height /2) - (400 / 2);
	var pcode=0;
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
					pcode=response.pcode;
					$("#mbcode").text(response.mbcode);
					$("#mbcontents").val(response.mbcontents);
					$("#mbdate").text(response.mbdate);
					$("#mbtitle").val(response.mbtitle);
					$("#pcode").text(response.pcode);
					$("#uid").text(response.uid);
				} else{
					alert('Server or Client ERROR, 게시판 글 확인이 실패 되었습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		//게시판 글 상세보기
	});
	
	//프로젝트 선택할 window창 생성
	function selectProject(){
		window.open("/methodboard/selectProject?uid="+"<%=loginid%>","", "height=400, width=1000, left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY); 
	}
	
	function completeProject(child_pcode){
		pcode=child_pcode;
		$("#selectProject").remove();
		var h4tag=document.createElement("h4");
		var h4ele=document.createTextNode("프로젝트 수정이 완료 되었습니다.");
		h4tag.appendChild(h4ele);
		$("#editproject").append(h4tag);
	}
	
	
	
	
	function boardEdit(){
		//게시글 수정하기
		var param = {
					'mbtitle' : $('#mbtitle').val(),
					'mbcontents' : $('#mbcontents').val(),
					'mbcode' : '<%=mbcode%>',
					'pcode' : pcode
			};
			$.ajax({
				type : 'PUT',
				url : '/methodboard',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response > 0) {
						alert('게시판 수정이 완료 되었습니다.');
						history.back();
					} else {
						alert('Server or Client ERROR, 게시판 수정이 실패 했습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
			// 게시글 수정하기
		}
		
		//돌아가기
		function boardEditCancel() {
			location.href = '/methodboard/main';
		}
</script>
</html>