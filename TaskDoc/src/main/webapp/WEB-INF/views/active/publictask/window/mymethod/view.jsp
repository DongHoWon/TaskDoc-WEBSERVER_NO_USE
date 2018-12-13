<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/task/jscolor.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode=request.getParameter("pcode");
	String tsdate=request.getParameter("tsdate");
	String tedate=request.getParameter("tedate");
	String mbcode=request.getParameter("tedate");
	String realpcode=request.getParameter("realpcode");
%>

<script type="text/javascript">
var realpcode=parseInt(<%=realpcode%>);
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
	
var pcode=<%=pcode%>;
var mbcode=<%=pcode%>;
</script>
</head>

<body>
<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">나의 방법론을 이용한 공용 업무 생성을 환영합니다.</h4>
					<button onclick="gomymethodlist()" type="button" class="btn" style="outline:none;color:white;background-color:#ed8151;border:0px;">내 방법론 리스트로 이동하기</button>
				</div>
				<div class="modal-body">
				 	<div class="form-group">
						<label>방법론 리스트</label> 
					</div>
					
					<div id="methodlistss">
					</div>  
					
					<div class="modal-footer">
						
						<button type="button" class="btn btn-success btn-icon" style="outline: none;border:0px;background-color:#ed8151;color:white;"
							onclick="ptCreate()">
							<i class="fa fa-check"></i> Create PublicTask
						</button>
						
						<button type="button" class="btn btn-default btn-icon" style="outline: none;border:0px;background-color:#ed8151;color:white;"
							onclick="Cancel()">
							<i class="fa fa-times-circle"></i> Cancel
						</button>
						
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
var socket = new SockJS('/goStomp'); 
stompClient = Stomp.over(socket);
var mycolor="";
var fixpsdate='<%=tsdate%>';
var fixpedate='<%=tedate%>';

//tsdate!=null tedate!=null인 array 담기
var parrays=new Array();

//정렬된 array
var realplist=new Array();

var sendArray=new Array();
$(function() {
	$.datepicker.regional['ko'] = {
			closeText : '닫기',
			prevText : '이전달',
			nextText : '다음달',
			currentText : '오늘',
			monthNames : [ '1월(JAN)', '2월(FEB)', '3월(MAR)', '4월(APR)',
					'5월(MAY)', '6월(JUN)', '7월(JUL)', '8월(AUG)', '9월(SEP)',
					'10월(OCT)', '11월(NOV)', '12월(DEC)' ],
			monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월',
					'9월', '10월', '11월', '12월' ],
			dayNames : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesShort : [ '일', '월', '화', '수', '목', '금', '토' ],
			dayNamesMin : [ '일', '월', '화', '수', '목', '금', '토' ],
			weekHeader : 'Wk',
			dateFormat : 'yy-mm-dd',
			firstDay : 0,
			isRTL : false,
			showMonthAfterYear : true,
			yearSuffix : '',
			changeMonth : true,
			changeYear : true,
			showButtonPanel : false,
			yearRange : 'c-99:c+99',
			minDate : fixpsdate,
			maxDate : fixpedate 
			};
	$.datepicker.setDefaults($.datepicker.regional['ko']);
	
	// method item list 불러오기
	$.ajax({
		type : 'GET',
		url : '/publictask/'+pcode,
		success : function(response) {
			if (response.length > 0) {
				for(var i=0;i<response.length;i++){
					if(response[i].tsdate!=null && response[i].tedate!=null){
						  if(response[i].tcode == response[i].trefference) {
							   response[i].trefference = 0;
						   }
						  parrays.push(response[i]);	
					}
				}
				realplist = treeModel(parrays, 0);
				listmake();
			}
			else  {
				alert('Server or Client ERROR, method item list 조회에 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
	
	var treeModel = function (arrayList, rootId) {
		var rootNodes = [];
		var traverse = function (nodes, item, index) {
			if (nodes instanceof Array) {
				return nodes.some(function (node) {
					if (node.tcode === item.trefference) {
						node.children = node.children || [];
						return node.children.push(arrayList.splice(index, 1)[0]);
					}

					return traverse(node.children, item, index);
				});
			}
		};

		while (arrayList.length > 0) {
			arrayList.some(function (item, index) {
				if (item.trefference === rootId) {
					return rootNodes.push(arrayList.splice(index, 1)[0]);
				}

				return traverse(rootNodes, item, index);
			});
		}

		return rootNodes;
	};
	 
	 
	function listmake(){
		//for문으로 업무생성
		 for(var i=0;i<realplist.length;i++){
				if(realplist[i].children != null){
					sendArray.push(realplist[i]);
					$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+ (i+1) +'. '+realplist[i].ttitle+'</button>'
					+'<input placeholder="공용 업무 제목을 입력해주세요." id="pttitle'+realplist[i].tcode+'" type="text"	class="form-control" maxlength="20">'
					+'<p style="margin-top:20px;"> 공용업무 색상: <input id="color'+realplist[i].tcode+'"class="jscolor" onchange="update(this.jscolor,'+realplist[i].tcode+')" value="'+realplist[i].tcolor+'" style="width:60px;"> </p>'
					+'<div>시작날짜: <input class="hasDatepicker" type="text" name="cAcqDate" id="psdate'+realplist[i].tcode+'"><div>'
					+'<div>종료날짜: <input class="hasDatepicker" type="text" name="cAceDate" id="pedate'+realplist[i].tcode+'"></div>';
					$("#methodlistss").append($div);
					
					$("#psdate"+realplist[i].tcode).removeClass('hasDatepicker').datepicker();
					$("#pedate"+realplist[i].tcode).removeClass('hasDatepicker').datepicker();
					
					
					$("#psdate"+realplist[i].tcode).datepicker();
					
					$("#psdate"+realplist[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#pedate"+this.id.substr(6)).datepicker("option", "minDate", selectDate);
						}
					}); 
				
					$("#pedate"+realplist[i].tcode).datepicker();
					
					$("#pedate"+realplist[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#psdate"+this.id.substr(6)).datepicker("option", "maxDate", selectDate);
						}
					}); 
					createListDiv(realplist[i].children, i+1);
			 	} 
				
				else {
					sendArray.push(realplist[i]);
			 		$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+(i+1)+'. '+realplist[i].ttitle+'</button>'
					+'<input placeholder="공용 업무 제목을 입력해주세요." id="pttitle'+realplist[i].tcode+'" type="text"	class="form-control" maxlength="20">'
					+'<p style="margin-top:20px;"> 공용업무 색상: <input id="color'+realplist[i].tcode+'"class="jscolor" onchange="update(this.jscolor,'+realplist[i].tcode+')" value="'+realplist[i].tcolor+'" style="width:60px;"> </p>'
					+'<div>시작날짜: <input class="hasDatepicker" type="text" name="cAcqDate" id="psdate'+realplist[i].tcode+'"><div>'
					+'<div>종료날짜: <input class="hasDatepicker" type="text" name="cAceDate" id="pedate'+realplist[i].tcode+'"></div>';
					$("#methodlistss").append($div);
					
					$("#psdate"+realplist[i].tcode).removeClass('hasDatepicker').datepicker();
					$("#pedate"+realplist[i].tcode).removeClass('hasDatepicker').datepicker();
					
					
					$("#psdate"+realplist[i].tcode).datepicker();
					
					$("#psdate"+realplist[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#pedate"+this.id.substr(6)).datepicker("option", "minDate", selectDate);
						}
					}); 
				
					$("#pedate"+realplist[i].tcode).datepicker();
					
					$("#pedate"+realplist[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#psdate"+this.id.substr(6)).datepicker("option", "maxDate", selectDate);
						}
					}); 
			 	}
		}
		 jscolor.installByClassName("jscolor"); 
	}
	
	 
	 function createListDiv(list, parrenti) {
			for(var i= 0; i<list.length; i++) {
				var str = parrenti +'-'+ (i+1);
				if(list[i].children != null) {
					sendArray.push(list[i]);
					$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+/* (i+1) */str+'. '+list[i].ttitle+'</button>'
					+'<input placeholder="공용 업무 제목을 입력해주세요." id="pttitle'+list[i].tcode+'" type="text"	class="form-control" maxlength="20">'
					+'<p style="margin-top:20px;"> 공용업무 색상: <input id="color'+list[i].tcode+'"class="jscolor" onchange="update(this.jscolor,'+list[i].tcode+')" value="'+list[i].tcolor+'" style="width:60px;"> </p>'
					+'<div>시작날짜: <input class="hasDatepicker" type="text" name="cAcqDate" id="psdate'+list[i].tcode+'"><div>'
					+'<div>종료날짜: <input class="hasDatepicker" type="text" name="cAceDate" id="pedate'+list[i].tcode+'"></div>';
					$("#methodlistss").append($div);
					
					$("#psdate"+list[i].tcode).removeClass('hasDatepicker').datepicker();
					$("#pedate"+list[i].tcode).removeClass('hasDatepicker').datepicker();
					
					
					$("#psdate"+list[i].tcode).datepicker();
					
					$("#psdate"+list[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#pedate"+this.id.substr(6)).datepicker("option", "minDate", selectDate);
						}
					}); 
				
					$("#pedate"+list[i].tcode).datepicker();
					
					$("#pedate"+list[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#psdate"+this.id.substr(6)).datepicker("option", "maxDate", selectDate);
						}
					}); 
					createListDiv(list[i].children, str);
				} else {
					sendArray.push(list[i]);
					$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+str+'. '+list[i].ttitle+'</button>'
					+'<input placeholder="공용 업무 제목을 입력해주세요." id="pttitle'+list[i].tcode+'" type="text"	class="form-control" maxlength="20">'
					+'<p style="margin-top:20px;"> 공용업무 색상: <input id="color'+list[i].tcode+'"class="jscolor" onchange="update(this.jscolor,'+list[i].tcode+')" value="'+list[i].tcolor+'" style="width:60px;"> </p>'
					+'<div>시작날짜: <input class="hasDatepicker" type="text" name="cAcqDate" id="psdate'+list[i].tcode+'"><div>'
					+'<div>종료날짜: <input class="hasDatepicker" type="text" name="cAceDate" id="pedate'+list[i].tcode+'"></div>';
					$("#methodlistss").append($div);
					
					$("#psdate"+list[i].tcode).removeClass('hasDatepicker').datepicker();
					$("#pedate"+list[i].tcode).removeClass('hasDatepicker').datepicker();
					
					
					$("#psdate"+list[i].tcode).datepicker();
					
					$("#psdate"+list[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#pedate"+this.id.substr(6)).datepicker("option", "minDate", selectDate);
						}
					}); 
				
					$("#pedate"+list[i].tcode).datepicker();
					
					$("#pedate"+list[i].tcode).datepicker("option", "onClose", function(selectDate) {
						if(selectDate != "") {
							$("#psdate"+this.id.substr(6)).datepicker("option", "maxDate", selectDate);
						}
					}); 
				}
			}
			 jscolor.installByClassName("jscolor"); 
		}
});



function update(jscolor,code) {
    // 'jscolor' instance can be used as a string
    $("#rect").css('background-color','#'+jscolor);
    var removeData='#'+jscolor;
    //#제거
    mycolor=removeData.replace("#","");
}
 
function Cancel(){
	window.close();
} 
function ptCreate(){
	var list=new Array();
	var obj=new Object();
	for(var i=0; i<sendArray.length; i++){
		
		obj.tcode=sendArray[i].tcode;
		if(sendArray[i].trefference==0){
			obj.trefference = sendArray[i].tcode;
		}else{
			obj.trefference = sendArray[i].trefference;
		}
		obj.ttitle = $("#pttitle"+sendArray[i].tcode).val();
		obj.tcolor = $("#color"+sendArray[i].tcode).val();
		obj.tsdate = $("#psdate"+sendArray[i].tcode).val();
		obj.tedate = $("#pedate"+sendArray[i].tcode).val();
		obj.tpercent=0;
		obj.pcode=realpcode;;
		list.push(obj);
		obj=new Object();
	}
	
	//전송
	$.ajax({
		type : 'POST',
		url : '/publictask/multiple',
		contentType : 'application/json',
		data : JSON.stringify(list),
		success : function(response) {
			if (response.length > 0) {
				for(var i=0;i<response.length;i++){
					var stompsend={
						'message' : 'insert',
						'type' : 'publictasks',
						'object': {
							response
						}
					};
				}
				stompClient.send('/app/project/'+realpcode, {},JSON.stringify(stompsend));
				alert('공용 업무 생성  완료!');
				window.close();
					
			} else  {
				alert('Server or Client ERROR, 공용업무 생성이 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	})
}

function gomymethodlist(){
	var screenW = screen.availWidth;  
	var screenH = screen.availHeight; 
	var posL=( screenW-popW ) / 2;   
	var posT=( screenH-popH ) / 2; 
	var popW = 500; 
	var popH = 400; 
	window.open("/project/mymethod/publicTask/create?tsdate="+fixpsdate+"&tedate="+fixpedate+"&mbcode="+mbcode,"", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	window.close();
}
	
</script>
</html>