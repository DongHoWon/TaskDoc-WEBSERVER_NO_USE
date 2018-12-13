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
	String pcode=request.getParameter("pcode");
	String tsdate=request.getParameter("tsdate");
	String tedate=request.getParameter("tedate");
%>

<script type="text/javascript">
var id='<%=loginid%>';
var tsdate='<%=tsdate%>';
var tedate='<%=tedate%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
	
var pcode=<%=pcode%>;
</script>
<body>
		<table class="table table-striped table-hover" style="width:100%;">
			<thead>
				<tr style="width:100%;">
					<th style="width: 20%;">방법론코드</th>
					<th style="width: 60%;">방법론</th>
					<th style="width: 20%;">ㅡ</th>
				</tr>
			</thead>
			<tbody id="tbodys">
			
			</tbody>
		</table>
</body>

<script type="text/javascript">
$.ajax({
	type : 'GET',
	url : '/method/all',
	success : function(response) {
		if (response.length > 0) {
			for(var i=0;i<response.length;i++){
				$div='<tr><td>'+response[i].mcode+'</td><td>'+response[i].method+'</td>'
				+'<td class="bts"><button class="btn" type="button" onclick="methodview('+response[i].mcode+')" style="background-color:#ed8151;color:white;outline:none;border:0px;">방법론확인</button></td></tr>';
				$("#tbodys").append($div);
			}
			
		} else  {
			alert('Server or Client ERROR, 방법론 조회에 실패 했습니다.');
		}
	},
	error : function(e) {
		alert("ERROR : " + e.statusText);
	}
});
	
function methodview(mcode){
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2; 
	var popW = 500; 
	var popH = 400; 
	window.open("/project/method/publicTask/view?tsdate="+tsdate+"&tedate="+tedate+"&pcode="+pcode+"&mcode="+mcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	window.close();
}	
</script>
</html>