<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<%@include file="/WEB-INF/views/fix/header.jsp"%>

<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode=request.getParameter("pcode");
%>
<style>
*{font-family:Title_Light;}
</style>
<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
//pro_header.jsp , pro_header.js 에서 <script>태그 안에서 변수 사용가능하다.	
var pcode=<%=pcode%>;
$(function(){
	$(".files_hover").css('color','#ed8151').css('border-bottom','1px solid #ed8151');
	$(".chat_hover").css('color','#6d6d6d').css('border-bottom','none');
	$(".ptask_hover").css('color','#6d6d6d').css('border-bottom','none');
	$(".gantt_hover").css('color','#6d6d6d').css('border-bottom','none');
	});
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
				<div class="container" style="background-color: white; overflow: auto;">
					<%@include file="/WEB-INF/views/active/project/fix/pro_header.jsp"%>
					
					<button id="rootcreate"type="button" onclick="createfolder()" class="btn" style="outline:none; border:0px;background-color:#ed8151;color:white;">폴더 생성하기</button>
					
					<div style="width: 100%;display:grid;">
						
						<div id="rootbtn" class="bts">
						</div>
						
						<span id="ptask" style="margin-top:10px; font-weight: bold; font-size:20px;">공용 업무</span>	
						<div id="publictaskList">
						</div>
						
						<span id="filek" style="margin-top:10px; font-weight: bold; font-size:20px;">폴더</span>
						<div id="fileList">
						</div>
						
					</div>
				</div>
		</div>

	</div>
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
	</div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	//특정 프로젝트의 모든 공용업무를 보여준다.
	$.ajax({
		type : 'GET',
		url : '/publictask/root/' + pcode,
		success : function(response) {
			if (response.length != 0) {
				for(var i=0;i<response.length;i++){
					if(response[i].tsdate==null && response[i].tedate==null){
						var folder="folder";
						var $plist='<div id="plist'+response[i].tcode+'" style="width:10%;height:160px;  margin-right:20px; margin-top:20px; float:left;">'
						+'<div style="width:100%;height:60%; cursor:pointer;"data-toggle="tootlip" data-placement="bottom" title="하위 업무 파일 보기" onclick="downtaskView(\''+folder+'\','+response[i].tcode+')">'
						+'<img src="${pageContext.request.contextPath }/resources/img/img_filetask.png"style="width:100%;height:100%;"></div>'
						+'<div style="width:100%;height:20%; text-align:center;cursor:pointer; border :1px solid #ed8151;" data-toggle="tootlip" data-placement="bottom" title="파일 다운로드 하기" onclick="gofileView('+response[i].tcode+')">'+response[i].ttitle+'</div>'
						+'<div class="bts"><button id="forderDels"onclick="folderDel('+response[i].tcode+')" class="btn" style="border:0px;outline:none;background-color:#ed8151;color:white;" type="button">삭제</button></div></div>';
						$("#fileList").append($plist);
					}
					else{
						var task="task"
						var $plist='<div id="plist'+response[i].tcode+'" style="width:10%;height:120px; margin-right:20px; margin-top:20px; float:left;">'
						+'<div style="width:100%;height:80%; cursor:pointer;" data-toggle="tootlip" data-placement="bottom" title="하위 폴더 파일 보기" onclick="downtaskView(\''+task+'\','+response[i].tcode+')">'
						+'<img src="${pageContext.request.contextPath }/resources/img/img_filetask.png"style="width:100%;height:100%;"></div>'
						+'<div style="width:100%;height:20%; border :1px solid #ed8151; text-align:center;cursor:pointer;" data-toggle="tootlip" data-placement="bottom" title="파일 다운로드 하기" onclick="gofileView('+response[i].tcode+')">'+response[i].ttitle+'</div></div>';
						$("#publictaskList").append($plist);
					}
				}
			} else if (response.length == 0) {
				alert('Server or Client ERROR, 공용업무 리스트 불러오기에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
	var socket = new SockJS('/goStomp'); 
	stompClient = Stomp.over(socket);
	
	 stompClient.connect({}, function() { //접속
         stompClient.subscribe('/project/'+pcode, function(msg) {
        	 var test=msg.body;
        	 var concat=JSON.parse(test);
        	 alert(concat);
        	 if(concat.message=="insert"){
	        	 if(concat.type=="publictaskvo"){
        			 alert("insert"+concat.object.tcode);
	        		 var $plist='<div id="plist'+concat.object.tcode+'" style="width:10%;height:120px; border: 1px solid #ed8151; margin-right:20px; margin-top:20px; float:left;">'
					 +'<div style="width:100%;height:60%; cursor:pointer;" onclick="downtaskView('+concat.object.tcode+')">'
					 +'<img src="${pageContext.request.contextPath }/resources/img/img_filetask.png"style="width:100%;height:100%;"></div>'
					 +'<div style="width:100%;height:20%; text-align:center;cursor:pointer; " onclick="gofileView('+concat.object.tcode+')">'+concat.object.ttitle+'</div>'
					 +'<div class="bts"><button onclick="folderDel('+concat.object.tcode+')" class="btn" style="border:0px;outline:none;background-color:#ed8151;color:white;" type="button">삭제</button></div></div>';
					 $("#fileList").append($plist);
        	 	}
        	 }
        	 
        	 //삭제
        	 if(concat.message=="delete"){
        		 if(concat.type=="publictaskvo"){
        			 alert("delete"+concat.object.tcode);
        			 $("#plist"+concat.object.tcode).remove();
        		 }
        	 }
         });
      });
	 $('[data-toggle="tootlip"]').tooltip();
});

function createfolder(){
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight;
	var popW = 600; 
	var popH = 250; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2;  
	window.open("/project/folder/create?pcode="+pcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}

//해당 업무에 대한 다운받을 수 있는 자료를 띄우는 페이지 window.open
function gofileView(tcode){
	event.stopPropagation();
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight;
	var popW = 600; 
	var popH = 350; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2;  
	window.open("/project/file/downloadForm?tcode="+tcode+"&pcode="+pcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}

//하위 업무 띄우려고 page load
function downtaskView(string,tcode){
	if(string=="folder" && confirm('하위 폴더의 파일을 보시겠습니까?')==true){
		 $("#publictaskList").load("/project/file/downview?tcode="+tcode+"&pcode="+pcode);
		 $btntag=' <button class="btn" type="button" onclick="goroot('+pcode+')" style="outline:none;border:0px; background-color:#ed8151;color:white;">최상위 업무로 이동</button>';
		 $("#rootcreate").remove();
		 $("#fileList").remove();
		 $("#ptask").remove();
		 $("#filek").remove();
		 $("#rootbtn").append($btntag);
	 }
	else if(string=="task" && confirm('하위 업무의 파일을 보시겠습니까?')==true){
		 $("#publictaskList").load("/project/file/downview?tcode="+tcode+"&pcode="+pcode);
		 $btntag=' <button class="btn" type="button" onclick="goroot('+pcode+')" style="outline:none;border:0px; background-color:#ed8151;color:white;">최상위 업무로 이동</button>';
		 $("#rootcreate").remove();
		 $("#fileList").remove();
		 $("#ptask").remove();
		 $("#filek").remove();
		 $("#rootbtn").append($btntag);
	}
}

//폴더 삭제
function folderDel(tcode){
	 event.stopPropagation();
	 if(confirm('폴더를 삭제하시겠습니까?')==true){
		$.ajax({
			type : 'DELETE',
			url : '/publictask/' + tcode,
			success : function(response) {
				if (response>0) {
					alert('공용업무 삭제에 성공 했습니다.');
					var peram={
							 'message' : 'delete',
							 'type' : 'publictaskvo',
							 'object' :{
									 'tcode' : tcode
								}
						 };
					stompClient.send('/app/project/'+pcode, {},JSON.stringify(peram));
				} else{
					alert('Server or Client ERROR, 폴더 삭제에 실패 했습니다.');
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