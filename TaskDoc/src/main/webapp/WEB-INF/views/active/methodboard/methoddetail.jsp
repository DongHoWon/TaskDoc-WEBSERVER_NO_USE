<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	
	
<%
	String loginid = "";
	loginid = (String) session.getAttribute("loginid");
	String pcode=request.getParameter("pcode");
%>

<script type="text/javascript">
var id='<%=loginid%>';
	if (id == "null") {
		alert('로그인이 필요한 페이지입니다.');
		window.location.href = '/';
	}
	
var pcode=<%=pcode%>;
</script>
</head>

<body>
<div class="container">
		<div class="row">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title">방법론 확인하기</h4>
				</div>
				<div class="modal-body">
				 	<div class="form-group">
						<label>방법론 리스트</label> 
					</div>
					
					<div id="methodlistss">
					</div>  
					
					<div class="modal-footer">
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

//tsdate!=null tedate!=null인 array 담기
var parrays=new Array();

//정렬된 array
var realplist=new Array();

var sendArray=new Array();
$(function() {
	
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
					$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+ (i+1) +'</button>'
					+'<input  readonly="readonly" id="pttitle'+realplist[i].tcode+'" type="text"	class="form-control" maxlength="20" value="'+realplist[i].ttitle+'">';
					$("#methodlistss").append($div);
					createListDiv(realplist[i].children, i+1);
			 	} 
				
				else {
			 		$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+(i+1)+'</button>'
					+'<input  readonly="readonly" id="pttitle'+realplist[i].tcode+'" type="text"	class="form-control" maxlength="20" value="'+realplist[i].ttitle+'">';
					$("#methodlistss").append($div);
			 	}
		}
	}
	
	 
	 function createListDiv(list, parrenti) {
			for(var i= 0; i<list.length; i++) {
				var str = parrenti +'-'+ (i+1);
				if(list[i].children != null) {
					$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+str+'</button>'
					+'<input  readonly="readonly" id="pttitle'+list[i].tcode+'" type="text"	class="form-control" maxlength="20" value="'+list[i].ttitle+'">';
					$("#methodlistss").append($div);
					createListDiv(list[i].children, str);
				} else {
					$div='<button type="button" class="btn" style="margin-top:20px; outline:none;color:white;background-color:#ed8151;border:0px;margin-right: 10px; ">'+str+'</button>'
					+'<input  readonly="readonly" id="pttitle'+list[i].tcode+'" type="text" class="form-control" maxlength="20" value="'+list[i].ttitle+'">';
					$("#methodlistss").append($div);
					
				}
			}
		}
});



 
function Cancel(){
	window.close();
} 
	
</script>
</html>