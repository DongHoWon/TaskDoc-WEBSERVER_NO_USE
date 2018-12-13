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
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String dscode=request.getParameter("dscode");
	String pcode=request.getParameter("pcode");
	String permission=request.getParameter("chatpermission");
%>
<script type="text/javascript">

var a='<%=permission%>';

$(document).ready(function(){
	if(a=='OWNER'){
		$("#decisionend").show();
		$("#decisiondel").show();
	
	}
	else if(a=='MEMBER'){
		$("#decisionend").hide();
		$("#decisiondel").hide();
	}
	
	var socket = new SockJS('/goStomp'); 
	
	stompClient = Stomp.over(socket);
	
	//채팅 append 여기서다함
    stompClient.connect({}, function() { //접속
         stompClient.subscribe('/project/'+pcode, function(msg) {
        	var test=msg.body;
        	var concat=JSON.parse(test);
        	if(concat.object.dscode==parseInt(<%=dscode%>)){
	        	$("#dstitle").text(concat.object.dstitle + "(종료된 투표 입니다.)");
				$("input[type=radio]").attr('disabled', true);
				$("#decisionend").attr('disabled', true);
				$("#choiceDecision").attr('disabled', true);
        	}
         });
    });
 });
</script>

</head>
<body id="endview">
	<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">의사결정 항목을 선택해주세요!</h4>
				</div>
					<div class="modal-body">
						<div class="form-group">
							<div>
								<label style="padding-top: 6px">제목 : <span id="dstitle"></span></label>
							</div>
							
							<div>
								<label style="padding-top: 6px">날짜 : <span id="dsdate"></span></label>
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
						<button id="decisionend" type="button" class="btn" style="display:none;outline:none;border:0px;background-color:#ed8151;color:white;"
							onclick="decisionEnd()">
							종료
						</button>
						<button type="button" class="btn" style="outline:none;border:0px;background-color:#ed8151;color:white;"
							id="choiceDecision">
							선택하기
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
	var pcode=parseInt(<%=pcode%>);
	var decisionitemlist = [];
	var tcode=0;
	var voterOk=false;
	$(document).ready(function() {
		$.ajax({
			type : 'GET',
			url : '/decision/'+<%=dscode%>,
			success : function(response) {
				if (Object.keys(response).length> 0){
						if(response.dsclose==0){
							$("#dstitle").text(response.dstitle);
							$("#dsdate").text(response.dsdate);
							tcode=response.tcode;
						}
						else{
							$("#dstitle").text(response.dstitle + "(종료된 투표 입니다.)");
							$("#dsdate").text(response.dsdate);
							$("input[type=radio]").attr('disabled', true);
							$("#decisionend").attr('disabled', true);
							$("#choiceDecision").attr('disabled', true);
						}
				}
				else{
					alert('Server or Client ERROR, 의사결정 정보 조회에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		
		
		/* 	종료는  type이 OWNER일 경우에만 가능
		 * 		if( 1-1 의사결정항목 조회)
		 *				if(1-3 본인이 투표를 했는지 안했는지 체크)
		 *						if(1-3-1 본인이 투표를했다면 -> 체크리스트, 투표하기버튼 잠금)
		 *						
		 *						else(1-3-2 본인이 투표를하지않았다면 -> 체크리스트, 투표하기버튼 활성화)
		 *    2.else(2-1 종료되었다면  종료버튼, 체크리스트 모두 잠금).
		 */
	$.ajax({
			type : 'GET',
			url : '/voter/check/'+<%=dscode%>,
			success : function(response) {
			
			//투표한 리스트
			var list={};
			list=response;	
			
			//리스트중 현재 아이디가 있으면 voterOk==true
			for(var i=0;i<list.length;i++){
				if(list[i]=='<%=loginid%>')
					voterOk=true;
			}
			
			if(voterOk==true){
				$("#choiceDecision").attr('disabled','true');
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
							alert('Server or Client ERROR, 의사결정 정보 조회에 실패 했습니다.');
						}
					},
					error : function(e) {
						alert("ERROR : " + e.statusText);
					}
				});
			}else{
				$.ajax({
					type : 'GET',
					url : '/decisionitem/count/'+<%=dscode%>,
					success : function(response) {
						if (response.list.length > 0){
							for(var i=0;i<response.list.length;i++) {
								$tdiv='<tr><td>'+ (i+1) + '</td><td>' + response.list[i].dsilist + '</td>'
								+'<td><input type="radio" name="radioTxt" value="' + response.list[i].dsicode + ',' + response.list[i].dsilist + '"></td><td>' + response.count[i] + '</td></tr>';
								$("#tbody").append($tdiv);
							}
						}
						else{
							alert('Server or Client ERROR, 의사결정 정보 조회에 실패 했습니다.');
						}
					},
					error : function(e) {
						alert("ERROR : " + e.statusText);
					}
				});
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
		
    	/* 의사결정 항목 선택하기*/
		 $('#choiceDecision').click(function () {
			//radioVal -> (dsicode, dsilist)
	        var radioVal = $('input[name="radioTxt"]:checked').val();
	        var dsicode={};
	        dsicode=radioVal.split(',');
	         
	     	var param = {
	     		'dsicode' : parseInt(dsicode[0]),
	     		'uid' : '<%=loginid%>'
	     	};
	     	$.ajax({
	     		type : 'POST',
	     		url : '/voter',
	     		contentType : 'application/json',
	     		data : JSON.stringify(param),
	     		success : function(response) {
	     			if (response > 0) {
	     				alert('항목 선택이 완료 되었습니다.');
	     			 	window.close();
	     			} else{
	     				alert('Server or Client ERROR, 항목 선택이 실패 되었습니다.');
	     			}
	     		},
	     		error : function(e) {
	     		}
	     	});
		});	
	});
	
	//window창 닫기
	function proCancel(){
		window.close();
	}	
	
	//의사 결정 종료
	function decisionEnd(){
		var param={
			'tcode' : tcode,
			'dstitle' : $("#dstitle").text(),
			'dsclose' : 1,
			'dscode' : parseInt(<%=dscode%>)
		};
		
		$.ajax({
			type : 'PUT',
			url : '/decision',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (response >0) {
					alert('의사결정이 종료 되었습니다.'); //stomp
					console.log(response);
					var stompmsg={
							 'message' : 'update',
							 'type' : 'decisionvo',
							 'object' :{
									 'tcode' : tcode,
								 	 'dstitle' : $("#dstitle").text(),
									 'dsclose' : 1,
									 'dscode' : parseInt(<%=dscode%>)
								 }
							 };
					stompClient.send('/app/project/'+pcode, {},JSON.stringify(stompmsg));
				} else {
					alert('Server or Client ERROR, 의사결정 종료가 실패 되었습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}
	
	//의사결정 삭제
	function decisionDel(){
		$.ajax({
			type : 'DELETE',
			url : '/decision/'+<%=dscode%>,
			success : function(response) {
				if(response>0){
					alert('의사결정 삭제에 성공 했습니다.');
					window.close();
				}
				else{
					alert('Server or Client ERROR, 의사결정 삭제 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}
	
</script>
</html>