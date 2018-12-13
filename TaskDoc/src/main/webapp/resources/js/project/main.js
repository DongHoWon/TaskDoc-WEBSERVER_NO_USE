var contentWidth = $("#contentwrap").width();
var contentHeight = $("#contentwrap").height();

var screenW = screen.availWidth;  // 스크린 가로사이즈
var screenH = screen.availHeight; // 스크린 세로사이즈
var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션 


$(document).ready(function() {
	var socket = new SockJS('/goStomp'); 
	stompClient = Stomp.over(socket);
	
	/*DIV TOP , BOTTOM , MIDDLE 범위나누기  */
	var contentWidth = $("#contentwrap").width();
	var contentHeight = $("#contentwrap").height();
	//$(".container").css('width',contentWidth + "px")
	$("#containersTOP").css('width', $('#contentwrap').width() / 1.3).css('margin-left', $('#contentwrap').width() / 6 + "px").css('height',contentHeight / 3);
	$("#containersBOTTOM").css('width', $('#contentwrap').width() / 1.3).css('margin-left', $('#contentwrap').width() / 6 + "px").css('height',contentHeight / 3);
	$("#containersMIDDLE").css('width', $('#contentwrap').width() / 1.3).css('margin-left', $('#contentwrap').width() / 6 + "px").css('height',contentHeight / 3);
	$.ajax({
		type : 'GET',
		url : '/projectjoin/'+id,
		success : function(response) {
			if (response.projectJoinList.length>0) {
				alert('프로젝트 조회가 완료되었습니다.');
				
				for(var i=0;i<response.projectJoinList.length;i++){
					/*프로젝트에 가입된 현황 pinvite==1 , 권한 OWNER  */
					if(response.projectJoinList[i].pinvite==1 && response.projectJoinList[i].ppermission=='OWNER'){
						var $div = $('<div class="projectlists" id="'+response.projectJoinList[i].pcode+',1'+'"> <div class="projectheader" style="width: 100%;"><div class="headername"><span id="pro_titlename" style="color: black">'+response.projectList[i].ptitle+'</span>'
						+'</div><div class="headerimg"><button type="button" class="prosetsettingimg" id="'+response.projectJoinList[i].pcode+'"><img alt=""src=" /resources/img/img_boardsetting.png"style="width: 18px; height: 18px;">'
						+'</button><button type="button" class="prosetinviteimg"id="'+response.projectJoinList[i].pcode+'"><img alt=""src=" /resources/img/img_proinvite.png"style="width: 18px; height: 18px;">'
						+'</button></div></div><div class="projectbottom" style="width: 100%; height:; display: block;">'
						+'<div id="pro_subdiv" style="width: 100%; height: 60%; overflow: auto;"><span id="pro_subtitlename" style="color: black">'+response.projectList[i].psubtitle+'</span></div><div id="pro_sdatediv" style="width: 100%; height: calc(40%/ 3);">'
						+'<span id="pro_sdate" style="color: black;">'+response.projectList[i].psdate+'</span></div><div id="pro_edatediv" style="width: 100%; height: calc(40%/ 3);"><span id="pro_edate" style="color: black;">'+response.projectList[i].pedate+'</span>'
						+'</div><div id="pro_posidiv" style="width: 100%; height: calc(40%/ 3)"><span id="pro_position"style="color: black; margin-right: 3px; float: right;">'+response.projectJoinList[i].ppermission+'</span>'
						+'</div></div></div>');
						$("#containersTOP").append($div);
						
					}
					
					/*프로젝트에 가입된 현황 pinvite==1 , 권한 MEMBER , 공지사항 이미지 띄우기*/
					else if(response.projectJoinList[i].pinvite==1 && response.projectJoinList[i].ppermission=='MEMBER')
					{
						var $dsiv = $('<div class="projectlists" id="'+response.projectJoinList[i].pcode+',1,'+response.projectList[i].ptitle+'"> <div class="projectheader" style="width: 100%;"><div class="headername" style="background-color: #5b66e8"><span id="pro_titlename" style="color: black">'+response.projectList[i].ptitle+'</span>'
								+'</div><div class="headerimg"><button type="button" class="pronoticebtn" style="outline:none;border:0; background-color:white;" id="'+response.projectJoinList[i].pcode+'"><img alt=""src=" /resources/img/img_notice.png"style="width: 18px; height: 18px;"></button></div>'
								+'</div><div class="projectbottom" style="width: 100%; height:; display: block;">'
								+'<div id="pro_subdiv" style="width: 100%; height: 60%; overflow: auto;"><span id="pro_subtitlename" style="color: black">'+response.projectList[i].psubtitle+'</span></div><div id="pro_sdatediv" style="width: 100%; height: calc(40%/ 3);">'
								+'<span id="pro_sdate" style="color: black;">'+response.projectList[i].psdate+'</span></div><div id="pro_edatediv" style="width: 100%; height: calc(40%/ 3);"><span id="pro_edate" style="color: black;">'+response.projectList[i].pedate+'</span>'
								+'</div><div id="pro_posidiv" style="width: 100%; height: calc(40%/ 3)"><span id="pro_position"style="color: black; margin-right: 3px; float: right;">'+response.projectJoinList[i].ppermission+'</span>'
								+'</div></div></div>');
								$("#containersTOP").append($dsiv);
								
					}
						
					/*프로젝트에 초대된 현황  pinvite==0 */
					else if(response.projectJoinList[i].pinvite==0 && response.projectJoinList[i].ppermission=='MEMBER'){
						var $dseiv = $('<div class="projectlists" id="'+response.projectJoinList[i].pcode+',0"> <div class="projectheader" style="width: 100%;"><div class="headername" style="background-color:gray;"><span id="pro_titlename" style="color: black">'+response.projectList[i].ptitle+'</span>'
								+'</div>'
								+'</div><div class="projectbottom" style="width: 100%; height:; display: block;">'
								+'<div id="pro_subdiv" style="width: 100%; height: 60%; overflow: auto;"><span id="pro_subtitlename" style="color: black">'+response.projectList[i].psubtitle+'</span></div><div id="pro_sdatediv" style="width: 100%; height: calc(40%/ 3);">'
								+'<span id="pro_sdate" style="color: black;">'+response.projectList[i].psdate+'</span></div><div id="pro_edatediv" style="width: 100%; height: calc(40%/ 3);"><span id="pro_edate" style="color: black;">'+response.projectList[i].pedate+'</span>'
								+'</div><div id="pro_posidiv" style="width: 100%; height: calc(40%/ 3)"><span id="pro_position"style="color: black; margin-right: 3px; float: right;">'+response.projectJoinList[i].ppermission+'</span>'
								+'</div></div></div>');
								$("#containersTOP").append($dseiv);
					}
			}
			    $(".projectlists").css('width', $('#containersTOP').width() / 5 + "px").css('height', $('#contentwrap').height() / 4 + "px");
				$(".projectheader").css('height',$('.projectlists').height() * 0.25);
				$(".projectbottom").css('height',$('.projectlists').height() * 0.75); 
				
				$(".projectlists").hover(function() {
					$(this).css("box-shadow", "4px 8px 20px grey");
				}, function() {
					$(this).css("box-shadow", "4px 4px 7px grey");
				});
		
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
	

});

/*PROJECT 진입  */
$(document).on('click','.projectlists',function(){
	var pcode=$(this).attr('id');
	var list=pcode.split(',');

	if(list[1]==0){
		if(window.confirm('프로젝트 초대를 수락하시겠습니까? 취소 할 시 거절되고 초대 내역이사라집니다.')==true){
				var param={
						'uid' : id,
						'pcode' : list[0],
						'ppermission' : 'MEMBER',
						'pinvite' : 1
				}
				$.ajax({
					type : 'PUT',
					url : '/projectjoin',
					contentType : 'application/json',
					data : JSON.stringify(param),
					success : function(response) {
						if (response == 1) {
							alert('초대 수락이 완료 되었습니다.');
							var peram={
									 'message' : 'update',
									 'type' : 'projectjoinvo',
									 'object' :{
											 param
										}
								 };
							stompClient.send('/app/project/'+pcode, {},JSON.stringify(peram));
							
							location.reload();
						} else {
							alert('Server or Client ERROR, 초대 수락이 실패 하였습니다.');
						}
					},
					error : function(e) {
						alert("ERROR : " + e.statusText);
					}
			});
		}
		else{
			var param={
					'uid' : id,
					'pcode' : list[0],
			}
			$.ajax({
				type : 'DELETE',
				url : '/projectjoin',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response == 1) {
						alert('초대 거절이 완료 되었습니다.');
						location.reload();
					} else {
						alert('Server or Client ERROR, 초대 거절에 실패 했습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
		});
		}
	}
	else if(list[1]>0){
	if(window.confirm('프로젝트로 진입하시겠습니까?')==true){
		location.href='/project/chat/main?pcode='+list[0];
	}else
		return;
	}
});

/*초대 window.open */
$(document).on('click','.prosetinviteimg' ,function(e) {
    e.stopPropagation();
    var pcode=$(this).attr('id');
    if(window.confirm('프로젝트 유저 초대 페이지를 띄우시겠습니까?')==true){
    	  var popW = 600; // 띄울창의 가로사이즈
    	  var popH = 350; // 띄울창의 세로사이즈
    	 window.open("/project/userInvite?pcode="+pcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
	}
	else
		return;
});


$(document).on('click','.prosetsettingimg' ,function(e) {
    e.stopPropagation();
    var list=$(this).attr('id');
    if(window.confirm('프로젝트 정보 수정  페이지를 띄우시겠습니까?')==true){
    	var popW = 1000; // 띄울창의 가로사이즈
    	var popH = 800 // 띄울창의 세로사이즈
    	 window.open("/project/infoEdit?pcode="+list,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
	}
	else
		return;
});

//proinvite==1 , MEMBER 일경우 공지사항 진입
$(document).on('click','.pronoticebtn' ,function(e) {
	e.stopPropagation();
	var list=$(this).attr('id');
	if(window.confirm('공지사항  페이지를 띄우시겠습니까?')==true){
		var popW = 500; // 띄울창의 가로사이즈
		var popH = 500 // 띄울창의 세로사이즈
		window.open("/project/noticeMain?pcode="+list,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
	}
	else
		return;
});



