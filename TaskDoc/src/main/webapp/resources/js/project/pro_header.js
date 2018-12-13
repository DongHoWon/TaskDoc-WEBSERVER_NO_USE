//========전역변수로 사용할거==========

//프로젝트명

var proname="";
//채팅방권한
var chatpermission="";

//시작날짜, 끝날짜도
var fixpsdate="";
var fixpedate="";

var screenW = screen.availWidth;  // 스크린 가로사이즈
var screenH = screen.availHeight; // 스크린 세로사이즈
var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션
var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션

	
	//채팅방리스트 리스트에담아라
	var cArray=new Array();
	
	// prouser Object list에 담을라고만듦(pinvite==1인경우)
	var prouserlist=new Array();
	
	// prouser Object list에 담을라고만듦(pinvite==0인경우)
	var pronouserlist=new Array();
	
	// display 화면 비율 조정
		var contentheight = $("#contentwrap").height();
		var contentwidth = $("#contentwrap").width();
		$(".container").css('height', contentheight);
		$(".container").css('width', contentwidth / 1.1);
		
		var line_height = $("#proheader").height();
		// TOP MENU, TITLE, LOGO들 LINE-HEIGHT 설정
		$("#prochatbtn1").css('line-height',line_height+"px");
		$("#prochatbtn2").css('line-height',line_height+"px");
		$(".chat_hover").css('line-height',line_height+"px");
		$(".gantt_hover").css('line-height',line_height+"px");
		$(".ptask_hover").css('line-height',line_height+"px");
		$(".files_hover").css('line-height',line_height+"px");
		$("#pro_title").css('line-height',line_height+"px");
		
		// 프로젝트에 포함된 유저 리스트불러와라
		 $.ajax({
				type : 'GET',
				url : '/projectjoin/collaboration/'+pcode,
				success : function(response) {
					if(response.projectJoinList.length>0){
						for(var i=0;i<response.projectJoinList.length;i++){
							
							//pinvite==1
							if(response.projectJoinList[i].pinvite>0){
								// 0 : {'id' ='d' , .... } , Object 생성
								var prouserObj=new Object();
								prouserObj.uid=response.projectJoinList[i].uid;
								prouserObj.pinvite=response.projectJoinList[i].pinvite;
								prouserObj.ppermission=response.projectJoinList[i].ppermission;
								prouserlist.push(prouserObj);
							}
							
							//pinvite==0
							else{
								var pronouserObj=new Object();
								pronouserObj.uid=response.projectJoinList[i].uid;
								pronouserObj.ppermission=response.projectJoinList[i].ppermission;
								pronouserlist.push(pronouserObj);
							}
						}
						//프로젝트에 몇명초대되어있는지 숫자체크
						$("#propeople").text(prouserlist.length);
					}
					
					for(var j=0;j<prouserlist.length;j++){
						var $atag='<li><a href="#">'+prouserlist[j].ppermission+' : '+prouserlist[j].uid+'</a></li>';
						$("#propeoplelist").append($atag);
					}
					
					for(var k=0;k<pronouserlist.length;k++){
						var $atag='<li><a href="#">'+pronouserlist[k].ppermission+' : '+pronouserlist[k].uid+'(초대대기중) '+'</a></li>';
						$("#propeoplelist").append($atag);
					}
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		 
		 // psdate와 pedate저장해서 . 업무 생성시 mindate와 maxdate설정할것
		 $.ajax({
				type : 'GET',
				url : '/projectjoin/'+ id,
				success : function(response) {
					for(var j=0; j<response.projectJoinList.length;j++){
						if(response.projectJoinList[j].pcode==pcode &&response.projectJoinList[j].pinvite==1){
							fixpsdate=response.projectList[j].psdate;
							fixpedate=response.projectList[j].pedate;
							if(response.projectJoinList[j].ppermission=="OWNER"){
								var $stag='<button id="prochatbtn3" onclick="goproset('+pcode+')" type="button"style="height: 42px; float: right; outline: none; border: 0; background-color: white; width: 100%;">'
											+'<img src="/resources/img/img_boardsetting.png"alt="" style="width: 15px; height: 15px;"> <span>설정</span></button>';
								$("#setornotice").append($stag);
								$("#prochatbtn3").css('line-height',line_height+"px");
								$("#pro_title").html("프로젝트 명 : "+response.projectList[j].ptitle);
								proname=response.projectList[j].ptitle;
								chatpermission=response.projectJoinList[j].ppermission;
								
							}else if(response.projectJoinList[j].ppermission=="MEMBER"){
								var $ntag='<button id="prochatbtn3" onclick="gonotice('+pcode+')" type="button"style="height: 42px; float: right; outline: none; border: 0; background-color: white; width: 100%;">'
								+'<img src="/resources/img/img_notice.png"alt="" style="width: 15px; height: 15px;"> <span>공지</span></button>';
								$("#setornotice").append($ntag);
								$("#prochatbtn3").css('line-height',line_height+"px");
								$("#pro_title").html("프로젝트 명 : "+response.projectList[j].ptitle);
								proname=response.projectList[j].ptitle;
								chatpermission=response.projectJoinList[j].ppermission;

							}
						}
					}
					
				},
				error : function(e) {
					alert("ERROR : " + e.statusText);
				}
			});
		 
		 //내가 초대되어있는 채팅방리스트와, 그 채팅방리스트에 포함된 모든 인원들을 불러온다 Map형식임
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
							//프로젝트 채팅방과, 개인채팅방을 구분하여 append한다. , 추후에 날짜랑, db 연동해서 제일 최근의 채팅방 내용을 불러오고, 날짜도 같이불러와보자.
							for(var i=0;i<response.chatRoomList.length;i++){
								
								//프로젝트 채팅방 append, 맨밑의 span에는 사용자가 입력한 채팅의 시간을적어줌, 지금은 test용으로 채팅방만든시간을적엇음.
								if(response.chatRoomList[i].crmode==1){
									cObject.crcode=response.chatRoomList[i].crcode;
									cObject.crdate=response.chatRoomList[i].crdate;
									cArray.push(cObject);
									$cdiv='<div id="croom'+cArray[i].crcode+'" style="width:300px;height:80px; border:3px solid #ed8151;">'
									+'<div style="width:100%;height:25%"><span>'+cArray[i].crcode+':'+'프로젝트 채팅방'+'</span></div>' 
									+'<div style="width:100%;height:50%; overflow:auto;"><img src="/resources/img/img_prochat.png"alt="" style="width: 30px; height:30px;">'
									+'<span id="croomsSpan'+cArray[i].crcode+'"></span></div>'
									+'<div style="width:100%;height:25%"><span>'+cArray[i].crdate+'</span></div>';
									$("#chathwamun").append($cdiv);
								}
								
								//개인 채팅방 append
								else if(response.chatRoomList[i].crmode==2){
									//ajax 데이터 받은거 멤버리스트 뽑아서 string으로만들자
									var memberArray=new Array();
									
									//개인채팅방 이름
									var memname=[];
									memberArray=response.userInfoList[i];
									
									for(var a=0;a<memberArray.length;a++){
										memname.push(memberArray[a].uname+"님 ");
									}
									cObject.crcode=response.chatRoomList[i].crcode;
									cArray.push(cObject);
									$cdiv='<div id="croom'+cArray[i].crcode+'" style="width:300px;height:80px; border:3px solid #ed8151; border-top:none;">'
									+'<div style="width:100%;height:28%;overflow:auto;"><span>'+cArray[i].crcode+':'+ memname +'의채팅방'+'</span></div>'
									+'<div style="width:100%;height:72%; overflow:auto;"><img src="/resources/img/img_individualchat.png"alt="" style="width: 30px; height:30px;">'
									+'<span id="croomsSpan'+cArray[i].crcode+'"></span></div>'
									$("#chathwamun").append($cdiv);
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


	// view page에서 설정 버튼 누를때 나오는 페이지(OWNER)
	function goproset(pcode){
			 if(window.confirm('프로젝트 정보 수정  페이지를 띄우시겠습니까?')==true){
		    	 var popW = 1000; // 띄울창의 가로사이즈
		    	 var popH = 800 // 띄울창의 세로사이즈
		    	 window.open("/project/infoEdit?pcode="+pcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
			}
			else
				return;
		}
	// view page에서 공지사항누를때 나오는 페이지(MEMBER)
	function gonotice(pcode){
		if(window.confirm('공지사항  페이지를 띄우시겠습니까?')==true){
			var popW = 500; // 띄울창의 가로사이즈
			var popH = 500 // 띄울창의 세로사이즈
			window.open("/project/noticeMain?pcode="+pcode,"",'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no');
		}
		else
			return;
	}
	
	// 채팅으로
	function gogoChat(){
		 location.href='/project/chat/main/?pcode='+pcode;
	}
	
	// 공용업무로
	function gogoPt(){
		location.href='/project/publicTask/main/?pcode='+pcode;
	}
	
	// 간트차트로
	function gogoGt(){
		location.href='/project/gantt/main/?pcode='+pcode;
	}
	
	// 파일모아보기로
	function gogofile(){
		location.href='/project/file/main/?pcode='+pcode;
	}
	
	// 프로젝트 대화 누르면 absolute div 한개나옴
	function prochatbtn(){
		if($("#chathwamun").css("display") == "none"){
			$("#chathwamun").show(1000);
		}else{
			$("#chathwamun").hide(1000);
		}
	}
	
	var chatObj=new Object();
	var deciObj=new Object();
	var docuObj=new Object();
	$(function(){
		var sockets = new SockJS('/goStomp'); 
		stompClients = Stomp.over(sockets);
		
		stompClients.connect({}, function() { //접속
         stompClients.subscribe('/project/'+pcode, function(msg) {
        	 var test=msg.body;
        	 var concat=JSON.parse(test);
        	 $("#chats"+concat.object.crcode).remove(); 
        	 if(concat.message=="insert"){
        		 if(concat.type == "chatroomvo"){
		        	 /*alert(concat.type);
		        	 alert(concat.object);*/
		        	 chatObj.crcode= concat.object.crcode;
		        	 chatObj.crmode= concat.object.crmode;
		        	 chatObj.crclose= concat.object.crclose;
		        	 chatObj.crcoderef= concat.object.crcoderef;
	    		 }
	        	 if(concat.type == "decisionvo"){
	        		 deciObj.dscode= concat.object.dscode;
	        		 deciObj.dsdate=concat.object.dsdate;
	        		 deciObj.dstitle=concat.object.dstitle;
	        		 deciObj.dsclose=concat.object.dsclose;
	        		 deciObj.crcode=concat.object.crcode;
	        		 deciObj.tcode=concat.object.tcode;
	        	 }
	        	 if(concat.type=="documentvo"){
	        		 docuObj.dmcode=concat.object.dmcode;
	        		 docuObj.dmtitle=concat.object.dmtitle;
	        		 docuObj.dmcontents=concat.object.dmcontents;
	        		 docuObj.dmdate=concat.object.dmdate;
	        		 docuObj.crcode=concat.object.crcode;
	        		 docuObj.tcode=concat.object.tcode;
	        		 docuObj.uid=concat.object.uid;
	        	 }
	        	 
	        	 if(concat.type == "chatcontentsvo"){
	        			 if(Object.keys(chatObj).length<=0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length<=0){
			        		 $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" : "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
	        		 	}
	        			 //의사결정 링크
	        			 if(Object.keys(deciObj).length>0 && Object.keys(chatObj).length<=0 && Object.keys(docuObj).length<=0){
				        	 $("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝트 or 개인 투표> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
				        	 deciObj=new Object();
	        		 	}
	        			 //회의록 링크
	        			 if(Object.keys(chatObj).length>0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length<=0){
	 		        		$("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝트 회의록> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
	 		        		chatObj=new Object();
	        			 }
	        			 
	        			 //자료 링크
	        			 if(Object.keys(chatObj).length<=0 && Object.keys(deciObj).length<=0 && Object.keys(docuObj).length>0){
	 		        		$("#croomsSpan"+concat.object.crcode).append('<span id="chats'+concat.object.crcode+'">'+concat.object.uid+" :<프로젝태 or 개인 자료> "+concat.object.ccontents+'('+concat.object.cdate+')'+'</span>');
	 		        		docuObj=new Object();
	        			 }
	    		 }
        	 }

         });
	});
});
