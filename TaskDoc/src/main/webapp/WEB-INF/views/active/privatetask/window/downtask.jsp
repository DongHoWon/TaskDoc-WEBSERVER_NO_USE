<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String tcode=request.getParameter("tcode");
String loginid = "";
loginid = (String) session.getAttribute("loginid");
%>
<div id="LV1" style="width:24%; margin-right:1%;">
LV1
</div>
<script type="text/javascript">

$(document).ready(function(){
	$("#gochart").hide();
	//root 업무 한개 append
	$("#publictaskBOTTOM").css('display','-webkit-box');
	var peram={
			'uid' : '<%=loginid%>',
			'tcode' : <%=tcode%>
		 };
	$.ajax({
		type : 'POST',
		url : '/privatetask/user/ptlist',
		contentType : 'application/json',
		data : JSON.stringify(peram),
		success : function(response) {
			if (response.length > 0) {
				for(var i=0;i<response.length;i++){	
					if(response[i].ptcode==response[i].ptrefference){
						var $append = '<div onclick="downtasklist('+response[i].ptrefference+', $(this).parent()[0].id)" id="publictask'+response[i].ptcode+'" style="margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;">'
						+'<div  style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+response[i].ptcolor+';"><span>'+ (i+1) +'. : '+response[i].pttitle+'</span></div>'
						+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
						+'<div style="margin-left:20px;" id="chart'+response[i].ptcode+'" class="progress-pie-chart" data-percent="'+response[i].ptpercent+'">'
						+'<div class="ppc-progress">'
						+'<div class="ppc-progress-fill" id="fill'+response[i].ptcode+'"></div></div>'
						+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ response[i].ptcode +'">%</span></div></div></div>'
						+'<div><div><span>시작 날짜 : '+response[i].ptsdate+'</span></div><div><span>종료 날짜 : '+response[i].ptedate+'</span></div><div class="bts">'                                  
						+'<button class="btn" style="font-size:12px;outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;" type="button" onclick="downtaskcreate(\''+response[i].ptsdate+','+response[i].ptedate+'\','+response[i].ptcode+','+response[i].tcode+')">하위업무생성</button>'
						+'<button class="btn" style="font-size:12px; outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;"type="button" onclick="goMemo('+response[i].ptcode+')">메모</button>'
						+'<button onclick= "ptedit('+response[i].ptcode+')" type="button" class="btn" style="font-size:12px; outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;margin-top:5px;">수정</button>'
						+'<button class="btn" style="font-size:12px; outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;margin-top:5px;"type="button" onclick="ptdel('+response[i].ptcode+')">삭제</button></div></div></div></div>';
						$("#LV1").append($append);
						
						var a = $("#chart"+response[i].ptcode.toString());
						var percent = parseInt(a.data('percent'));
						var deg = 360 * percent / 100;
							if (percent > 50) {
								a.addClass("gt-50");
							}
						var b=$("#fill"+response[i].ptcode.toString());
						b.css('transform', 'rotate(' + deg + 'deg)');
						$('#num'+response[i].ptcode.toString()).html(percent + '%');
					}
				}
			} else {
				alert('Server or Client ERROR, 개인업무가 존재하지 않습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
});
 
 //업무 클릭시 div를 인식해서 유동적으로 조회 해야하는데...
 function downtasklist(ptrefference, curLv){
	 event.stopPropagation();
	 var downLv = parseInt(curLv.substr(2)) + 1;
	 $("#"+curLv).nextAll().remove();
	 $.ajax({
			type : 'GET',
			url : '/privatetask/down/'+ ptrefference,
			success : function(response) {
				if (response.length > 0) {
					$cppend='<div style="width:24%; margin-right:1%;" id="LV'+downLv+'">LV'+downLv+'</div>';
					$("#publictaskBOTTOM").append($cppend);
					
					for(var i=0;i<response.length;i++){
							var $bppend = '<div id="publictask'+response[i].ptcode+'" style="margin-right:1%; margin-bottom:10px; height: 200px; background-color: white;" onclick="downtasklist('+response[i].ptcode+', $(this).parent()[0].id)">'
							+'<div onclick="" style="cursor:pointer; width: 100%; height: 20%; border:3px solid #'+response[i].ptcolor+';"><span>'+ (i+1) +'. : '+response[i].pttitle+','+response[i].ptcode+'</span></div>'
							+'<div style="width: 100%; height: 80%; border:1px solid #ed8151; border-top:none;">'
							+'<div style="margin-left:20px;" id="chart'+response[i].ptcode+'" class="progress-pie-chart" data-percent="'+response[i].ptpercent+'">'
							+'<div class="ppc-progress">'
							+'<div class="ppc-progress-fill" id="fill'+response[i].ptcode+'"></div></div>'
							+'<div class="ppc-percents"><div class="pcc-percents-wrapper"> <span id="num'+ response[i].ptcode +'">%</span></div></div></div>'
							+'<div><div><span>시작 날짜 : '+response[i].ptsdate+'</span></div><div><span>종료 날짜 : '+response[i].ptedate+'</span></div><div>'
							+'<button class="btn" style="font-size:12px;outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;" type="button" onclick="downtaskcreate(\''+response[i].ptsdate+','+response[i].ptedate+'\','+response[i].ptcode+','+response[i].tcode+')">하위업무생성</button>'
							+'<button class="btn" style="font-size:12px; outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;"type="button" onclick="goMemo('+response[i].ptcode+')">메모</button>'
							+'<button onclick= "ptedit('+response[i].ptcode+')" type="button" class="btn" style="font-size:12px; outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;margin-top:5px;">수정</button>'
							+'<button class="btn" style="font-size:12px; outline:none;border:0px;color:white;background-color:#ed8151;margin-right:5px;margin-top:5px;"type="button" onclick="ptdel('+response[i].ptcode+')">삭제</button></div></div></div></div>';
						
						$("#LV"+downLv).append($bppend);
						var c = $("#chart"+response[i].ptcode.toString());
						var percent = parseInt(c.data('percent'));
						var deg = 360 * percent / 100;
						if (percent > 50) {
							c.addClass("gt-50");
							}
						var d=$("#fill"+response[i].ptcode.toString());
						d.css('transform', 'rotate(' + deg + 'deg)');
						$('#num'+response[i].ptcode.toString()).html(percent + '%'); 
							
						}
				}else{
					alert('Server or Client ERROR, 하위 개인업무가 존재하지 않습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
			
		});
 }
 
 //하위 업무 생성
 function downtaskcreate(date,ptcode,tcode){
	 event.stopPropagation();
	 var screenW = screen.availWidth;  // 스크린 가로사이즈
	 var screenH = screen.availHeight; // 스크린 세로사이즈
	 var popW = 500; // 띄울창의 가로사이즈
	 var popH = 400; // 띄울창의 세로사이즈
	 var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
	 var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션
	 var list=[];
	list=date.split(",");
	 
	window.open("/project/privateTask/downTaskCreate?&ptsdate="+list[0]+"&ptedate="+list[1]+"&ptcode="+ptcode+"&tcode="+tcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
 	}
 
 
/* 
 function test(i) {
	var b = $("#chart"+i.toString());
	
	// 숫자만인지 체크하는 정규식
	var regNumber = /^[0-9]*$/;
	
	var test = prompt("퍼센트를 입력해주세요", "숫자만 입력해주세요");
	if (test > 100 || !regNumber.test(test)) {
		alert('100을넘거나 숫자 이외의 문자는 사용할 수 없습니다.');
	} else if(test<=100){
		percent = parseInt(test);
		deg = 360 * percent / 100;
		if (percent > 50) {
			b.addClass("gt-50");
			$("#chart"+i.toString()).css("background-color","#ed8151");
			$("#fill"+i.toString()).css('background','#e5e5e5');
		}
		else{
			b.removeClass("gt-50");
			$("#chart"+i.toString()).css("background-color",'#e5e5e5');
			$("#fill"+i.toString()).css('background','#ed8151');
		}
		$('#fill'+i.toString()).css('transform', 'rotate(' + deg + 'deg)');
		$('#num'+i.toString()).html(percent + '%');
	} 
}
  */
</script>

</html>