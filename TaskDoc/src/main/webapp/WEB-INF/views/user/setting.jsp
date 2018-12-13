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
					style="display: table; vertical-align: middle; height: 100%;">
					<div class="main"
						style="border: 1px solid rgba(0, 0, 0, 0.2); box-shadow: 0 3px 9px rgba(0, 0, 0, 0.5); background-color: white; display: table-cell;">

						<div class="container">
							<h2>관 리</h2>
							<p>자신이 업로드한 게시글과 자료를 관리할 수 있습니다.</p>

							<ul class="nav nav-tabs">
								<li class="active"><a data-toggle="tab" href="#myboard">내가 올린 게시물</a></li>
								<li><a data-toggle="tab" href="#mydocument">내가 올린 자료</a></li>
							</ul>

							<div class="tab-content">
								<div id="myboard" class="tab-pane fade in active">
									<div class="containers">
										<table class="table table-striped table-hover">
											<thead>
												<tr>
													<th style="width: 50px;">번호</th>
													<th style="width: 400px;">제목</th>
													<th style="width: 150px;">작성자</th>
													<th style="width: 200px;">날짜</th>
													<th style="width: 100px;">관리</th>
												</tr>
											</thead>
											<tbody id="tbodys">

											</tbody>
										</table>
									</div>

								</div>
								<div id="mydocument" class="tab-pane fade">
									<div class="containers">
										<table class="table table-striped table-hover">
											<thead>
												<tr>
													<th style="width: 50px;">번호</th>
													<th style="width: 150px;">자료제목</th>
													<th style="width: 300px;">자료내용</th>
													<th style="width: 150px;">작성자</th>
													<th style="width: 150px;">날짜</th>
													<th style="width: 100px;">관리</th>
												</tr>
											</thead>
											<tbody id="tbodyss">

											</tbody>
										</table>
									</div>
								</div>
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
if (location.hash) {
	$("a[href='" + location.hash + "']").tab("show");
}
$(document.body).on("click", "a[data-toggle]", function(event) {
	location.hash = this.getAttribute("href");
});
$(window).on(
		"popstate",
		function() {
			var anchor = location.hash
					|| $("a[data-toggle='tab']").first().attr("href");
			$("a[href='" + anchor + "']").tab("show");
		});


	$(document).ready(function() {
		//게시판 목록 전체 받아오기 
			$.ajax({
				type : 'GET',
				url : '/methodboard/all',
				success : function(response) {
						if (response.length > 0) {
							for(var i=0;i<response.length;i++){
							if(response[i].uid=='<%=loginid%>'){
								var trtag = document.createElement("tr");
								var td_idx=document.createElement("td");
								var idxele=document.createTextNode(i+1);
								trtag.appendChild(td_idx);
								td_idx.appendChild(idxele);
						
								var td_title=document.createElement("td");
								
								//a tag의 onclick 이기때문에 손모양 css적용해주었음
								td_title.setAttribute('style','cursor:pointer')
								var a_title=document.createElement("a");
								
								//onclick 이벤트 적용해줌
								a_title.setAttribute('onclick','boardcon('+response[i].mbcode+')');
								var titleele=document.createTextNode(response[i].mbtitle);
								trtag.appendChild(td_title);
								a_title.appendChild(titleele);
								td_title.appendChild(a_title);
						
								var td_uid=document.createElement("td");
								var uidele=document.createTextNode(response[i].uid);
								trtag.appendChild(td_uid);
								td_uid.appendChild(uidele);
						
								var td_date=document.createElement("td");
								var dateele=document.createTextNode(response[i].mbdate);
								trtag.appendChild(td_date);
								td_date.appendChild(dateele);
						
								var td_setting=document.createElement("td");
								var editiconele=document.createElement("img");
								editiconele.setAttribute('src','${pageContext.request.contextPath }/resources/img/img_boardsetting.png');
								editiconele.setAttribute('style','width:20px;height:20px; cursor:pointer');
								editiconele.setAttribute('onclick','boardEdit('+response[i].mbcode+')');
										
								var deliconele=document.createElement("img");
								deliconele.setAttribute('src','${pageContext.request.contextPath }/resources/img/img_boarddelete.png');
								deliconele.setAttribute('style','margin-left:20px;width:20px;height:20px;cursor:pointer');
								deliconele.setAttribute('onclick','boardDelete('+response[i].mbcode+')');
										
								td_setting.appendChild(editiconele);
								td_setting.appendChild(deliconele);
								trtag.appendChild(td_setting);
							}
						
							$("#tbodys").append(trtag);
							}
					} else {
						alert('Server or Client ERROR, 게시글이 존재하지 않습니다.');
					}
					},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
			
			//파일 받아오기
			$.ajax({
				type : 'GET',
				url : '/document/user/'+id,
				success : function(response) {
						if (response.length > 0) {
							alert('파일 목록을 조회 합니다.');
							for(var i=0;i<response.length;i++){
								var $div='<tr><td>'+ (i+1) +'</td><td><a style="cursor:pointer;" onclick="documentView('+response[i].dmcode+')">'+response[i].dmtitle+'</a></td><td>'
								+response[i].dmcontents+'</td><td>'+response[i].uid+'</td><td>'+response[i].dmdate+'</td>'
								+'<td><img src="${pageContext.request.contextPath }/resources/img/img_boarddelete.png" style="margin-left:20px;width:20px;height:20px;cursor:pointer"'
								+'onclick="documentDelete('+response[i].dmcode+')"></td></tr>';
								$("#tbodyss").append($div);
							}
					} else {
						alert('Server or Client ERROR, 파일 목록이 존재하지 않습니다.');
					}
					},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		});
	
	
		
		// 게시판 목록 전체 받아오기
		function boardcon(code){
			location.href='/methodboard/view?mbcode='+code;
		}
		
		//게시판 삭제
		function boardDelete(code){
			if(confirm('게시글을 삭제 하시겠습니까?')==true){
			$.ajax({
				type : 'DELETE',
				url : '/methodboard/'+code,
			success : function(response) {
				if (response > 0) {
					alert('게시글 삭제가 완료 되었습니다.');
					location.reload();
				} else {
					alert('Server or Client ERROR, 게시글 삭제에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
			}
			else return;
		}
		
		//게시판 수정
		function boardEdit(code){
			if(confirm('게시글을 수정 하시겠습니까?')==true){
				location.href='/methodboard/edit?mbcode='+code;
			}
			else return;
		}
		
		//자료 확인
		function documentView(dmcode){
			var screenW = screen.availWidth;  // 스크린 가로사이즈
			var screenH = screen.availHeight; // 스크린 세로사이즈
			var popW = 600; // 띄울창의 가로사이즈
			var popH = 350; // 띄울창의 세로사이즈
			var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
			var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션 
			window.open("/user/downloadForm?dmcode="+dmcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
		}
		
		//자료수정
		function documentEdit(dmcode){
			if(confirm('자료를 수정 하시겠습니까?')==true){
				}
				else return;
		}
		
		//자료 삭제
		function documentDelete(dmcode){
			if(confirm('자료를 삭제 하시겠습니까?')==true){
				$.ajax({
					type : 'DELETE',
					url : '/document/'+dmcode,
				success : function(response) {
					if (response > 0) {
						alert('자료 삭제가 완료 되었습니다. ' + response);
						location.reload();
					} else {
						alert('Server or Client ERROR, 자료 삭제가 실패 되었습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
				}
				else return;
		}
</script>
</html>