<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String dscode=request.getParameter("dscode");
	String dstitle=request.getParameter("dstitle");
	String dsdate=request.getParameter("dsdate");
	String permission=request.getParameter("permission");
%>

<script type="text/javascript">

var a='<%=permission%>';
$(document).ready(function(){
	if(a=='OWNER'){
		$("#decisiondel").show();
	
	}
	else if(a=='MEMBER'){
		$("#decisiondel").hide();
	}
});
</script>


</head>
<body>
	<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">종료된 투표 입니다.</h4>
				</div>
					<div class="modal-body">
						<div class="form-group">
							<div>
								<label style="padding-top: 6px">제목 : <%=dstitle %></label>
							</div>
							
							<div>
								<label style="padding-top: 6px">날짜 : <%=dsdate %></label>
							</div>
							
							<div>
								<div id="tableDiv">
									<table class="table">
									
										<thead id="thead">
											<tr>
												<th>번호</th>
												<th>문항</th>
												<th>체크</th>
												<th>COUNT</th>
											</tr>
										</thead>
										
										<tbody id="tbody">
																
										</tbody>
									</table>
								</div>

							</div>
							<h4 class="endhaha" style="color: red"></h4>
							<div></div>

						</div>
					</div>
					<div class="modal-footer">
					
						<button id="decisiondel" type="button" class="btn" style="display:none;outline:none;border:0px;background-color:#ed8151;color:white;"
							onclick="decisionDel()">
							삭제
						</button>
						
						<button type="button" class="btn" style="outline:none;border:0px;background-color:#ed8151;color:white;"
							onclick="proCancel()">
							Cancel
						</button>
					</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
$(function(){
	$.ajax({
		type : 'GET',
		url : '/decisionitem/count/'+<%=dscode%>,
		success : function(response) {
			if (response.list.length > 0){
				for(var i=0;i<response.list.length;i++) {
					$tdiv='<tr><td>'+ (i+1) + '</td><td>' + response.list[i].dsilist + '</td>'
					+'<td><input class="group" type="radio" name="radioTxt" value="' + response.list[i].dsicode + ',' + response.list[i].dsilist + '"></td><td>' + response.count[i] + '</td></tr>';
					$("#tbody").append($tdiv);
				}
				$("input[type=radio]").attr('disabled', true);
			}
			else{
				alert('Server or Client ERROR, 의사결정 정보 조회에  실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
});
function decisionDel(){
	$.ajax({
		type : 'DELETE',
		url : '/decision/'+<%=dscode%>,
		success : function(response) {
			if(response>0){
				alert('의사결정 삭제에 성공 했습니다.');
				window.close();
				opener.parent.menubtn();
			}
			else{
				alert('Server or Client ERROR, 의사결정 삭제에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}

function proCancel(){
	window.close();
}
</script>
</html>