<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String tcode=request.getParameter("tcode");
%>
<style>
*{font-family:Title_Light;}
</style>
<div id="LV1" style="width:200px;">
LV1
</div>
<script type="text/javascript">
$(document).ready(function(){
	$("#publictaskList").css('display','-webkit-box');
	$.ajax({
		type : 'GET',
		url : '/publictask/publicTaskView/' + <%=tcode%>,
		success : function(response) {
			if (Object.keys(response).length > 0) {
				var $plist='<div data-toggle="tootlip" data-placement="bottom" title="하위 업무 파일 보기" onclick="downtasklist('+response.tcode+', $(this).parent()[0].id)" id="ptask'+response.tcode+'"'
				+'style="width:140px;height:170px;   margin-right:20px; margin-top:20px; float:left;">'
				+'<div style="width:100%;height:60%; cursor:pointer;"><img src="${pageContext.request.contextPath }/resources/img/img_filetask.png"style="width:100%;height:100%;"></div>'
				+'<div style="border :1px solid #ed8151;width:100%;height:20%; text-align:center;cursor:pointer; "data-toggle="tootlip" data-placement="bottom" title="파일 다운로드 하기" onclick="gofileView('+response.tcode+')">'+response.ttitle+'</div>'
				+'<div class="bts"><button onclick="downfoldercreate('+response.tcode+')" class="btn" style="background-color:#ed8151;color:white;outline:none;border:0px;" type="button">하위 폴더 생성</button></div></div>';
				$("#LV1").append($plist);
			} else {
				alert('Server or Client ERROR, 공용업무 리스트 불러오기에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	 $('[data-toggle="tootlip"]').tooltip();
});

//파일 모아보기 탭 메뉴로이동 root 
function goroot(pcode){
	location.href='/project/file/main/?pcode='+pcode;
}

//업무 클릭시 div를 인식해서 유동적으로 조회 해야하는데...
function downtasklist(tcode, curLv){
	 var downLv = parseInt(curLv.substr(2)) + 1;
	 $("#"+curLv).nextAll().remove();
	 $.ajax({
			type : 'GET',
			url : '/publictask/down/'+ tcode,
			success : function(response) {
				if (response.length > 0) {
					$cppend='<div style="width:200px;" id="LV'+downLv+'">LV'+downLv+'</div>';
					$("#publictaskList").append($cppend);
					
					for(var i=0;i<response.length;i++){
						var $bppend = '<div data-toggle="tootlip" data-placement="bottom" title="하위 업무 파일 보기" onclick="downtasklist('+response[i].tcode+', $(this).parent()[0].id)" id="ptask'+response.tcode+'" style="width:156px; height:172px;   margin-right:20px; margin-top:20px; float:left;">'
						+'<div style="width:100%;height:60%; cursor:pointer;"><img src="${pageContext.request.contextPath }/resources/img/img_filetask.png"style="width:100%;height:100%;"></div>'
						+'<div style="border :1px solid #ed8151;width:100%;height:20%; text-align:center;cursor:pointer; "data-toggle="tootlip" data-placement="bottom" title="파일 다운로드 하기" onclick="gofileView('+response[i].tcode+')">'+response[i].ttitle+'</div>'
						+'<div class="bts"><button onclick="downfoldercreate('+response[i].tcode+')" class="btn" style="margin-right:3px;background-color:#ed8151;color:white;outline:none;border:0px;" type="button">하위 폴더 생성</button>'
						+'<button onclick="folderDel('+response[i].tcode+')" class="btn" style="border:0px;outline:none;background-color:#ed8151;color:white;" type="button">삭제</button></div></div>';
						$("#LV"+downLv).append($bppend);
						}
				}else{
					alert('Server or Client ERROR, 공용업무 리스트 불러오기에 실패 했습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
			
		});
}

function downfoldercreate(tcode){
	event.stopPropagation();
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight;
	var popW = 600; 
	var popH = 350; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2; 
	window.open("/project/folder/downcreate?tcode="+tcode+"&pcode="+pcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
}
</script>