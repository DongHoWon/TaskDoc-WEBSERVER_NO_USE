<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String ptcode = request.getParameter("ptcode");
%>	

</head>
<body id="loadtest">
	<div class="bts">
		<button class="btn" type="button" onclick="memocreate()"style="outline:none;color:white;border:0px;background-color:#ed8151;">생성</button>
	</div>
	
	<table class="table table-striped table-hover">
		<thead>
			<tr>
				<th style="width: 50px;">번호</th>
				<th style="width: 250px;">내용</th>
				<th style="width: 100px;">날짜</th>
				<th style="width: 100px;">관리</th>
			</tr>
		</thead>
		<tbody id="tbodys">
		
		</tbody>
	</table>
</body>

<script type="text/javascript">
ptcode=parseInt(<%=ptcode%>);
	$(function(){
		//메모 조회
		$.ajax({
			type : 'GET',
			url : '/memo/' + <%=ptcode%>,
			success : function(response) {
				if (response.length>0) {
					for(var i=0;i<response.length;i++){
						$div='<tr calss="bts"><td>'+ (i+1) +'</td> <td>'+response[i].mcontents+'</td><td>'+response[i].mdate+'</td>'
						+'<td><img onclick="memoEdit(\''+response[i].mcontents+'\','+response[i].mcode+')" src="${pageContext.request.contextPath }/resources/img/img_boardsetting.png" style="width:20px;height:20px;margin-right:20px;cursor:pointer;">'
						+'<img onclick="memoDel('+response[i].mcode+')" src="${pageContext.request.contextPath }/resources/img/img_boarddelete.png" style="width:20px;height:20px;cursor:pointer;"></td></tr>';
						$("#tbodys").append($div);
					}
					
				} else{
					alert('Server or Client ERROR, 메모 조회에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
	})
	
	//생성
	function memocreate(){
		if(confirm('새 메모를 작성하시겠습니까?')==true){
		$("#loadtest").load('/project/memo/create?ptcode=' + ptcode);
		}
		else return;
	}
	
	//삭제
	function memoDel(mcode){
	 $.ajax({
		type : 'DELETE',
		url : '/memo/'+mcode,
		success : function(response) {
			if (response>0) {
				alert('메모가 삭제 되었습니다.');
				location.reload();
			} else{
				alert('Server or Client ERROR, 메모 삭제가 실패 되었습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
}
	
	//수정
	function memoEdit(mcontents,mcode){
		if(confirm('메모를 수정하시겠습니까?')==true){
		$("#loadtest").load('/project/memo/edit?'+'&mcontents='+mcontents+'&mcode='+mcode);
			}
		else return;
	}
	
</script>
</html>