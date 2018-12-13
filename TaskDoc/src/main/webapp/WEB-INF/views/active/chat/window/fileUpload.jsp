<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<style>
	.progress { position:relative; width:400px; border: 1px solid #ddd; padding: 1px; border-radius: 3px; }
	.bar { background-color: #B4F5B4; width:0%; height:20px; border-radius: 3px; }
	.percent { position:absolute; display:inline-block; top:3px; left:48%; }
</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="http://malsup.github.com/jquery.form.js"></script>
	
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode=request.getParameter("pcode");
	String crcode=request.getParameter("crcode");
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
	<form method="POST" enctype="multipart/form-data" id="fileUploadForm" action="/document/upload/doc">
		<div class="container">
			<div class="row">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">자료를 업로드 해주세요!</h4>
					</div>
						<div class="modal-body">
							<div class="form-group">
								<label>자료 제목</label> <input name="dmtitle" type="text" class="form-control" maxlength="20">
								<label style="margin-top:10px;">자료 설명</label> <textarea name="dmcontents" class="form-control"></textarea>
							</div>
		
							<div class="btn-group">
								<div>
									<label>자료를 업로드  할 공용업무를 선택해주세요</label>
									<select class="form-control" id="whattask">
									</select>
								</div>
								
								<div class="bts">
									<label style="margin-top :10px;">파일을 업로드 해주세요</label>
									<button onclick="addfile()" type="button" class="btn" style="background-color:#ed8151;color:white;border:0px;outline:none;">파일추가하기</button>
								
									<div id="filelist">
									</div>
								</div>
								
								<div class="progress" style="margin-top:10px;">
									<div class="bar"></div>
								    <div class="percent">0%</div>
								</div>
								
							</div>
							<div class="modal-footer">
								<input id="btnSubmit" type="submit" class="btn" style="background-color:#ed8151;color:white;" value="생성">
								<button type="button" class="btn"
									onclick="fileCancel()" style="background-color:#ed8151;color:white;">
									 Cancel
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<!--hidden값   -->
			<div style="display:none;">
				<input type="text" name="crcode" id="crcode">
				<input type="text" name="tcode" id="tcode">
				<input type="text" name="uid" id="uid">
			</div>
	</form>
</body>

<script type="text/javascript">
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
				alert('공용업무 리스트를 불러 옵니다.');
			} else if (response.length == 0) {
				alert('Server or Client ERROR, 공용업무 리스트 불러오기에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	}); 
});

	$("#btnSubmit").on("click",function(){
			$("#crcode").val(<%=crcode%>);
			$("#tcode").val($("#whattask option:selected").val());
			$("#uid").val('<%=loginid%>');
			var bar = $('.bar');
		    var percent = $('.percent');
		    var status = $('#status');
			
			$('form').ajaxForm({
		        beforeSend: function() {
		            status.empty();
		            var percentVal = '0%';
		            bar.width(percentVal);
		            percent.html(percentVal);
		        },
		        uploadProgress: function(event, position, total, percentComplete) {
		            var percentVal = percentComplete + '%';
		            bar.width(percentVal);
		            percent.html(percentVal);
		        },
		        complete: function(success) {
		        	alert('파일 업로드가 완료 되었습니다.');
		        	var json=success.responseJSON;
		        	var obj=new Object();
					obj.dmcode=json.dmcode;
					obj.dmtitle=json.dmtitle;
					obj.dmcontents=json.dmcontents;
					obj.dmdate=json.dmdate;
					obj.crcode=json.crcode;
					obj.tcode=json.tcode;
					obj.uid=json.uid;
					
		        	opener.parent.docutest(obj.dmcode,obj.dmtitle,obj.dmcontents,obj.dmdate,obj.crcode,obj.tcode,obj.uid);
					opener.parent.chattest(obj.dmcode,0,0,obj.crcode,obj.dmtitle);
					window.close();
					
		        },
		        error : function(e) {
					alert("파일 업로드 ERROR : " + e.statusText);
			}
	    });
	});
function fileCancel(){
	window.close();
}

var count=0;

function addfile(){
	count++;
	if(count<=4){
		var $div='<input id="f'+count+'"type="file" name="file"><button id="b'+count+'"onclick="fileDel('+count+')"type="button" class="btn"'
		+'style="color:white;background-color:#ed8151;outline:none;border:0px;">삭제</button>';
		$("#filelist").append($div);
	}else alert('파일은 4개까지 추가가 가능합니다.');
}

function fileDel(code){
	$("#f"+code).remove();
	$("#b"+code).remove();
	count--;
}
</script>

</html>