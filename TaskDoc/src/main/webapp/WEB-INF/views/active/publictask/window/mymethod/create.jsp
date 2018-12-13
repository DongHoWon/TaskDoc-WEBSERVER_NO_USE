<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script  src="${pageContext.request.contextPath }/resources/js/task/jscolor.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
</head>
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String tsdate=request.getParameter("tsdate");
	String tedate=request.getParameter("tedate");
	String realpcode=request.getParameter("realpcode");
%>

<script type="text/javascript">
var id='<%=loginid%>';
var tsdate='<%=tsdate%>';
var tedate='<%=tedate%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
	
</script>
<body>
	<div id="mymethod">
		<button onclick="golist()"type="button" class="btn" style="outline:none;border:0px;color:white;background-color:#ed8151;color:white;">내 방법론 리스트로 돌아가기</button>
		<div id="tables">
			<table class="table table-striped table-hover" style="width:100%;">
				<thead>
					<tr style="width:100%;">
						<th style="width: 20%;">게시글코드</th>
						<th style="width: 60%;">제목</th>
						<th style="width: 20%;">ㅡ</th>
					</tr>
				</thead>
				<tbody id="tbodys">
				
				</tbody>
			</table>
		</div>
	</div>
</body>

<script type="text/javascript">
$.ajax({
	type : 'GET',
	url : '/methodlist/'+id,
	success : function(response) {
		if (response.length > 0) {
			for(var i=0;i<response.length;i++){
				$div='<tr><td>'+response[i].mbcode+'</td><td>'+response[i].mltitle+'</td>'
				+'<td class="bts"><button class="btn" type="button" onclick="mymethodview('+response[i].mbcode+')" style="background-color:#ed8151;color:white;outline:none;border:0px;">방법론확인</button></td></tr>';
				$("#tbodys").append($div);
			}
			
		} else  {
			alert('Server or Client ERROR, 방법론 조회에  실패 했습니다.');
		}
	},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
});
	
function mymethodview(mbcode){
	event.stopPropagation();
	$.ajax({
		type : 'GET',
		url : '/methodboard/' + mbcode,
		success : function(response) {
			if (Object.keys(response).length > 0) {
				alert('해당 게시글 조회가 완료 되었습니다. ');
				$("#tables").remove();
				var $div='<table class="table table-striped table-hover" style="width:100%;"><thead><tr style="width:100%;"><th style="width: 10%;">번호</th>'
				+'<th style="width: 30%;">제목</th><th style="width: 40%;">내용</th><th style="width: 20%;">ㅡ</th></tr></thead>'
				+'</thead><tbody id="tbodysss"><tr><td>'+response.mbcode+'</td><td>'+response.mbtitle+'</td><td>'+response.mbcontents+'</td>'
				+'<td class="bts"><button onclick="gopublictask('+response.pcode+','+response.mbcode+')"type="button" class="btn" style="outline:none;border:0px;color:white;background-color:#ed8151;">방법론 추가하기</button></td></tr></tbody></table>';
				$("#mymethod").append($div); 
			} else  {
				alert('Server or Client ERROR, 해당 게시글 조회에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}	

 function golist(){
	event.stopPropagation();
	location.href= '/project/mymethod/publicTask/create?tsdate='+tsdate+'&tedate='+tedate;
} 
 function gopublictask(pcode,mbcode){
	  var screenW = screen.availWidth;  
		var screenH = screen.availHeight; 
		var posL=( screenW-popW ) / 2;   
		var posT=( screenH-popH ) / 2; 
		var popW = 500; 
		var popH = 800; 
		window.open("/project/mymethod/publicTask/view?tsdate="+tsdate+"&tedate="+tedate+"&pcode="+pcode+"&mbcode="+mbcode+"&realpcode="+<%=realpcode%>,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
		window.close(); 
 }
</script>
</html>