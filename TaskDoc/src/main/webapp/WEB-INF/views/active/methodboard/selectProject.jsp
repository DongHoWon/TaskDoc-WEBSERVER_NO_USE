<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String uid = request.getParameter("uid");
%>

</head>
<body>
<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">프로젝트를 선택해주세요</h4>
				</div>
				<div class="modal-body">
					<div class="form-group">
						<div>
							<div id="tableDiv">
								<table class="table">
									<!--Table head-->
								<thead id="thead">
									<tr>
										<th style="width:200px;">제목</th>
										<th>부제목</th>
										<th style="width:103px;">시작날짜</th>
										<th style="width:103px;">종료날짜</th>
										<th style="width:88px;">나의 권한</th>
									</tr>
								</thead>
								<!--Table head-->

								<!--Table body-->
								<tbody id="projectList">

								</tbody>
								<!--Table body-->
									<!--Table body-->

								</table>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer" style="margin-top:-30px;">
					<!-- <input type="hidden" name="isEmpty" value=""> -->
					<button type="button" class="btn btn-default btn-icon"
						onclick="selectproCancel()">
						<i class="fa fa-times-circle"></i> Cancel
					</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$.ajax({
		type : 'GET',
		url : '/projectjoin/' + '<%=uid%>',
			success : function(response) {
				for (var i = 0; i < response.projectJoinList.length; i++) {
					if (response.projectJoinList[i].pinvite>0) {
						console.log(response.projectJoinList[i].ppermission);
						console.log(response.projectList[i].psubtitle);
						console.log(response.projectList[i].psdate);
						console.log(response.projectList[i].pedate);
						
						var trtag = document.createElement("tr");
						
						var td_title=document.createElement("td");
						var titleele=document.createTextNode(response.projectList[i].ptitle);
						trtag.appendChild(td_title);
						td_title.appendChild(titleele);
						
						var td_subtitle=document.createElement("td");
						var subtitleele=document.createTextNode(response.projectList[i].psubtitle);
						trtag.appendChild(td_subtitle);
						td_subtitle.appendChild(subtitleele);
						
						var td_sdate=document.createElement("td");
						var sdateele=document.createTextNode(response.projectList[i].psdate);
						trtag.appendChild(td_sdate);
						td_sdate.appendChild(sdateele);  
						
						var td_edate=document.createElement("td");
						var edateele=document.createTextNode(response.projectList[i].pedate);
						trtag.appendChild(td_edate);
						td_edate.appendChild(edateele);  
						
						var td_permission=document.createElement("td");
						var permissionele=document.createTextNode(response.projectJoinList[i].ppermission);
						trtag.appendChild(td_permission);
						td_permission.appendChild(permissionele);  
						
						var td_button=document.createElement("td");
						var btag=document.createElement("button");
						var bnametag=document.createTextNode("선택");
						btag.setAttribute("class","btn btn-default btn-icon");
						//for문으로 버튼생성후 버튼 onclick시 해당 버튼마다 pcode를 넣어줌
						btag.setAttribute("onclick","proselection("+response.projectJoinList[i].pcode+")");
						trtag.appendChild(td_button);
						btag.appendChild(bnametag);
						td_button.appendChild(btag);
						
						$("#projectList").append(trtag);
					}
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/* /내가 참가하는 모든 프로젝트를 검색*/
	});

//부모창인 projectCreate.jsp로 값을 넘겨준다.
function proselection(pcode){
	if(confirm("※프로젝트를 선택 하시겠습니까?")==true){
		opener.completeProject(pcode);
		window.close();
	}
	else{
		return;
	}
}

function selectproCancel(){
	window.close();
}
</script>
</html>