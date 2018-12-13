<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String crcode=request.getParameter("crcode");
	String pcode=request.getParameter("pcode");
%>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">투표를 진행해주세요!</h4>
				</div>

				<div class="modal-body">
					<div class="form-group">
						<label>의사결정 제목</label> <input id="decisionName" type="text" class="form-control">
					</div>

					<div class="btn-group">
						<div>
							<label>투표를 할 공용업무를 선택해주세요</label>
							<select class="form-control" id="whattask">
							</select>
						</div>
					</div>

					<div class="form-group">
						<br></br> <label>투표 항목</label>
						<button type="button" class="btn" style="background-color:#ed8151;color:white;" onclick="addIndex()">
							항목 추가하기
						</button>
						<div style="display: block" id="indexes"></div>
					</div>

					<div class="modal-footer">
						<button type="button" class="btn" onclick="decisionOK()" style="background-color:#ed8151;color:white;">
							생성하기
						</button>
						<button type="button" class="btn"
							onclick="decisionCancel()" style="background-color:#ed8151;color:white;">
							 Cancel
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	var count = 0;
	
	//의사결정 항목을 담은 리스트들.
	var tlist = [];
	
	//의사결정 아이템 생성용 param
	var paramitem = [];
	
	//프로젝트의 모든 공용업무 리스트 불러오기
	 $(function(){
		$.ajax({
			type : 'GET',
			url : '/publictask/' + <%=pcode%>,
			success : function(response) {
				if (response.length != 0) {
					for(var i=0;i<response.length;i++){
						$whattask='<option value="'+response[i].tcode+'">'+ (i+1 )+'.' +response[i].tcode+ response[i].ttitle + '</option>';
						$("#whattask").append($whattask);
					}
					/* alert('공용업무 리스트 불러오기 성공!'); */
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 공용업무 리스트 불러오기에  실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	}); 
	
	//항목 div 추가
	function addIndex() {
		count++;
		//div tag
		var dtag = document.createElement("div");
		dtag.setAttribute('id', 'content' + count);
		dtag.setAttribute('style', 'display:flex; margin-bottom:5px;');
	
		//input tag
		var itag = document.createElement("input");
		itag.setAttribute('type', 'text');
		itag.setAttribute('class', 'form-control');
		itag.setAttribute('id', 't' + count);

		//button tag
		var btag = document.createElement("button");
		btag.setAttribute('type', 'button');
		btag.setAttribute('id', 'b' + count);
		btag.setAttribute('class', 'btn');
		btag.setAttribute('style', 'background-color:#ed8151; color:white;');
		btag.setAttribute('onclick', 'objdelete(this)');

		var element = document.createTextNode("삭제");
		btag.appendChild(element);

		dtag.appendChild(itag);
		dtag.appendChild(btag);

		$("#indexes").append(dtag);
		tlist.push('t' + count);

	}
	
	//항목 div 삭제
	function objdelete(btn) {
		var divid = btn.id.substring(1, btn.id.length);
		document.getElementById("content" + divid).remove();
		tlist.splice(tlist.indexOf('t' + divid), 1);

	}

	//의사결정 생성
	function decisionOK(){
		//의사결정 생성후 return 값으로 의사결정 pk값이 날라온것 저장하는 변수
		var decisionCreatecode=null;
		/* 의사결정 생성*/
		//의사결정 생성용 param
		var param = {
			'dstitle' : $("#decisionName").val(),
			'crcode' : <%=crcode%>,
			'tcode' : $("#whattask option:selected").val()
		};
		if($("#decisionName").val()=="" || tlist.length<=0){
			alert('제목또는 항목을 하나 이상 입력해주세요.');
		}
		else{
		$.ajax({
			type : 'POST',
			url : '/decision/dec',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				if (Object.keys(response).length>0) {
					alert('의사결정 생성이 완료 되었습니다. ');
					for (var i = 0; i < tlist.length; i++) {
						paramitem.push({
								'dsilist' : document.getElementById(tlist[i]).value,
								'dsisequence' : i,
								'dscode' : response.dscode
						});
					}
					/* 의사결정 아이템 생성
					항목이 하나일수도, 여러개일수도있기때문에 [{}] 형식으로 list형식으로 서버에 보내야된다
					 */
					$.ajax({
						type : 'POST',
						url : '/decisionitem',
						contentType : 'application/json',
						data : JSON.stringify(paramitem),
						success : function(responseitem) {
							if (responseitem.length>0) {
								/* alert('의사결정 아이템 생성 완료! ' + responseitem); */
								/* alert(response.dscode);
								alert(response.dstitle); */
								opener.parent.decitest(response.dscode,response.dsdate,response.dstitle,response.dsclose,response.crcode,response.tcode);
								opener.parent.chattest(0,response.dscode,0,response.crcode,response.dstitle);
								window.close();
							} else {
								alert('Server or Client ERROR, 의사결정 아이템 생성 실패');
							}
						},
						error : function(e) {
							alert("ERROR : " + e.statusText);
						}
					});
				} else {
					alert('Server or Client ERROR, 의사결정 생성 실패');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
		/*/의사결정 생성 */
		}
	}
	
	function decisionCancel(){
		window.close();
	}
</script>

</html>