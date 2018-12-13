//채팅방에 들어갔는지안들어갔는지 체크
pageopen=false;

$(function(){
	var socket = new SockJS('/goStomp'); 
	stompClient = Stomp.over(socket);
	//채팅방추가하기 이미지에 툴팁씌우기
	$('[data-toggle="tootlip"]').tooltip();
	
	//pro_header.jsp의 프로젝트 대화 div(position=absolute)의 left값에  proheadername + proheaderli + prochatbtn1 값을 넣어준다.
	//채팅 , 공용업무, 간트차트, 파일모아보기에 페이지별로 전부 넣어줘야한다.
	var pronamewidth = $("#proheadername").css('width');
	var proliwidth = $("#proheaderli").css('width');
	var prochatbtn1 = $("#prochatbtn1").css('width');
	$("#chathwamun").css('left',parseInt(pronamewidth) + parseInt(proliwidth) + parseInt(prochatbtn1));
	
	
	//leftchatlist -> 프로젝트 채팅, 개인 채팅 리스트 append
	var param = {
			'uid' : id,
			'pcode' : pcode
		};
		$.ajax({
			type : 'POST',
			url : '/chatroomjoin/room',
			contentType : 'application/json',
			data : JSON.stringify(param),
			success : function(response) {
				var cObject=new Object();
				if (response.length != -1) {
					var cArray=new Array();
					//프로젝트 채팅방과, 개인채팅방을 구분하여 append한다.
					for(var i=0;i<response.chatRoomList.length;i++){
						//프로젝트 채팅방 append, 맨밑의 span에는 사용자가 입력한 채팅의 시간을적어줌, 지금은 test용으로 채팅방만든시간을적엇음.
						if(response.chatRoomList[i].crmode==1){
							cObject.crcode=response.chatRoomList[i].crcode;
							cObject.crmode=response.chatRoomList[i].crmode;
							cObject.crdate=response.chatRoomList[i].crdate;
							cObject.crclose=response.chatRoomList[i].crclose;
							cObject.crcoderef=response.chatRoomList[i].crcoderef;
							cArray.push(cObject);
							$cdiv='<div id="croom'+cArray[i].crcode+'" style="width:100%;height:83px; border: 1px solid #ed8151;" onclick="gochatCon('+cArray[i].crcode+',' + cArray[i].crmode +','+cArray[i].crclose+','+cArray[i].crcoderef+')">'
							+'<div style="width:100%;height:25%"><span>'+cArray[i].crcode+':'+'프로젝트 채팅방'+'</span></div>' 
							+'<div style="width:100%;height:50%;overflow:auto;"><img src="/resources/img/img_prochat.png"alt="" style="width: 30px; height:30px;">'
							+'<span id="croomSpan'+cArray[i].crcode+'"></span></div>'
							+'<div style="width:100%;height:25%"><span>'+cArray[i].crdate+'</span></div>';
							$("#chatlistTOP").append($cdiv);
						}
						
						//개인 채팅방 append
						else if(response.chatRoomList[i].crmode==2){
							//ajax 데이터 받은거 멤버리스트 뽑아서 string으로만들자
							var memberArray=new Array();
							
							//프로젝트 이름
							var memname=[];
							memberArray=response.userInfoList[i];
							
							for(var a=0;a<memberArray.length;a++){
								memname.push(memberArray[a].uname+"님 ");
							}
							
							cObject.crcode=response.chatRoomList[i].crcode;
							cObject.crmode=response.chatRoomList[i].crmode;
							cObject.crdate=response.chatRoomList[i].crdate;
							cObject.crclose=response.chatRoomList[i].crclose;
							cObject.crcoderef=response.chatRoomList[i].crcoderef;
							
							cArray.push(cObject);
							$cdiv='<div id="croom'+cArray[i].crcode+'" style="width:100%;height:30%; border-left:1px solid #ed8151; border-bottom:1px solid #ed8151;display:inline-block;" onclick="gochatCon('+cArray[i].crcode+',' + cArray[i].crmode +','+cArray[i].crclose+','+cArray[i].crcoderef+')">'
							+'<div style="width:100%;height:25%"><span>'+cArray[i].crcode+':'+ memname +'의채팅방'+'</span></div>'
							+'<div style="width:100%;height:50%; overflow : auto;"><img src="/resources/img/img_individualchat.png"alt="" style="width: 30px; height:30px;">'
							+'<span id="croomSpan'+cArray[i].crcode+'"></span></div>'
							+'<div><button type="button" class="btn" style="float:right; background-color:#ed8151; color:white;font-size:12px;" onclick="chatinvite('+cArray[i].crcode+')">초대</button></div>';
							$("#chatlistBOTTOM").append($cdiv);

						}
					}
				} else if (response.length == 0) {
					alert('Server or Client ERROR, 채팅방이 존재하지 않습니다.');
				}
			},
			error : function(e) {
				alert("ERROR : " + e.statusText);
			}
		});
});

//채팅방생성
$("#chatadd").on("click",function(){
	
	if(pageopen==true)
		alert('채팅방을 나간 후 생성해 주세요');
	
	else{
		if(confirm('채팅방을 만드시겠습니까?')==true){
			var param = {
					'chatRoom' : {
						//개인톡 형식이므로 crmode 2번
						'crmode' : '2',
					},
					'userInfo' : {
						'uid' : id,
					},
					'project' : {
						'pcode' : pcode,
					}
			};
			$.ajax({
				type : 'POST',
				url : '/chatroom',
				contentType : 'application/json',
				data : JSON.stringify(param),
				success : function(response) {
					if (response>0) {
						alert('채팅방 생성이 완료되었습니다.');
						location.reload();
					}
					else if(response<0){
						alert('Server or Client ERROR, 채팅방 생성에 실패 했습니다.');
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		}else
			return;
	}
});

//chat list append시 crcode와 cmode필요
function gochatCon(crcode,crmode,crclose,crcoderef){
	/*프로젝트 채팅방이고 ,cmode==1 // OWNER : 파일업로드, 회의록 생성, 의사결정 생성
	*		        cmode==1 //MEMBER : 파일업로드
	*개인 채팅방이면 		cmode==2 //OWNER , MEMBER관계없음. 파일업로드
	*/
	stompClient.disconnect();
	if(crmode==1){
		if(confirm('프로젝트 채팅에 입장하시겠습니까?')==true){
			if(chatpermission=="OWNER" &&crmode==1){
/*				alert(crcode+","+crmode+", owner다");
*/			 	$("#rightchatlist").load("/chat/content?crcode="+crcode+"&crmode="+crmode+"&crclose="+crclose+"&crcoderef="+crcoderef+"&pcode="+pcode);  
			}
			else if(chatpermission=="MEMBER" && crmode==1){
/*				alert(crcode+","+crmode+", member다");
*/				$("#rightchatlist").load("/chat/content?crcode="+crcode+"&crmode="+crmode+"&crclose="+crclose+"&crcoderef="+crcoderef+"&pcode="+pcode);  
			}
		}
		else return;
	}
	
	else if(crmode==2){
		if(confirm('개인 채팅에 입장하시겠습니까?')==true){
			alert(crcode+","+crmode+", owner다");
			$("#rightchatlist").load("/chat/content?crmode="+crmode+"&crcode="+crcode+"&pcode="+pcode+"&crclose="+crclose+"&crcoderef="+crcoderef);  
		}
	}
}

function chatinvite(crcode){
	event.stopPropagation();
	if(pageopen==true){
		alert('채팅방을 나간 후 회원을 초대해주세요.');
	}
	else{
	var screenW = screen.availWidth;  // 스크린 가로사이즈
	var screenH = screen.availHeight; // 스크린 세로사이즈
	var popW = 600; // 띄울창의 가로사이즈
	var popH = 350; // 띄울창의 세로사이즈
	var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
	var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션 
	window.open("/chat/userInvite?crcode="+crcode+"&pcode="+pcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	}
}

