<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>

<style>
.progress {
	position: relative;
	width: 400px;
	border: 1px solid #ddd;
	padding: 1px;
	border-radius: 3px;
}

.bar {
	background-color: #B4F5B4;
	width: 0%;
	height: 20px;
	border-radius: 3px;
}

.percent {
	position: absolute;
	display: inline-block;
	top: 3px;
	left: 48%;
}
</style>

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/project/jsgantt.js"></script>
<script src="http://malsup.github.com/jquery.form.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/project/jsgantt.css">
<script src="http://www.google-analytics.com/urchin.js"
	type="text/javascript"></script>
</head>


<body>
	<!-- dmtitle, crcode, uid, [tcode]  -->
	<!-- <div style="position:relative" class="gantt" id="GanttChartDIV"></div> -->

	<form action="/document/upload" enctype="multipart/form-data"
		method="POST">
		<input name="dmtitle" value="테스트1" /> <input name="dmcontents"
			value="테스트 자료입니다." /> <input name="crcode" value="1" /> <input
			name="tcode" value="33" /> <input name="uid" value="a" /> <input
			type="file" name="file" /> <input type="submit" value="upload">
	</form>

	<div class="progress">
		<div class="bar"></div>
		<div class="percent">0%</div>
	</div>
	<div id="status"></div>


	<div
		style="background-color: yellow; width: 1000px; height: 100px; border-radius: 20px;">
		<div style="background-color: red; width: 500px;">
			<div>
				<span>아이디(이름,팀장) : (상태메시지)</span>
			</div>

			<div>
				<span>내용</span>
			</div>
			<div>
				<span>날짜</span>
			</div>
		</div>
	</div>
	<input id="test" type="text" onkeyup="enterkey()">
	
</body>

<script type="text/javascript">
$(function(){
	
	var peram={
			'uid' : 'b',
			'tcode' : 127
		 };
	$.ajax({
		type : 'POST',
		url : '/privatetask/user/ptlist',
		contentType : 'application/json',
		data : JSON.stringify(peram),
		success : function(response) {
			if (response.length > 0) {
				alert(response);
			} else  {
				alert('Server or Client ERROR, 공용업무 생성이 실패 했습니다.');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
});
function enterkey(){
	if(window.event.keyCode==13){
		if($("#test").val()=="")
			alert('채팅 내용을 입력해주세요.');
		else
			alert($("#test").val());
	}
}

var b=new Array();
var a=new Array();
$(function() {
    $.ajax({
		type : 'GET',
		url : '/publictask/'+1,
		success : function(response) {
			if (response.length > 0) {
			   for(var i=0;i<response.length;i++){
				   if(response[i].tcode == response[i].trefference) {
					   response[i].trefference = 0;
				   }
			 		a.push(response[i]);	
			   } 
			console.log(a);
			
			b = treeModel(a, 0);
			
			console.log(b);
		   }
			else  {
				alert('Server or Client ERROR, method item list 조회 실패');
			}
		},
		error : function(e) {
			alert("ERROR : " + e.statusText);
		}
	});
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

function test(a,b){
	 /* 	tcode, trefference				response는 tcode순서로, sequence순으로 정렬
	1	80, 80							if tcode=trefference array에담음
		1-1	84, 80							위의 tcode를 저장해서 == trefference인것을 array에담음
		1-1 86, 80 							위의 tcode를 저장해서 == trefference인것을 array에담음
											반복 	
	2	81, 81										
		2-1 89, 81

	3	82, 82
	
	4	83, 83

	1-1-1  85, 84
	2-1-1  90, 89	 */	
	
	
	
	
	/* a.forEach(function(item, index, array){
		if(a[index].tcode == a[index].trefference) {
			var parrent = a[index].tcode;
			b.push(a[index]);
			a.splice(index, 1);
			console.log(a);
			
			findchild(parrent);
		}
	}); */
	
	 
	//console.log(b);
	
}


/* 
function findchild(prt) {
	
	a.forEach(function(item, index, array){
		if(prt == a[index].trefference) {
			var parrent = a[index].tcode;
			b.push(a[index]);
			a.splice(index, 1);
			console.log(a);
			
			findchild(parrent);
		}
	}); */
	


</script>

<form action="/file/download/1" method="POST">
	<input type="submit" />
</form>

</html>