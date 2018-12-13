<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@include file="/WEB-INF/views/fix/header.jsp"%>
<script
	src="${pageContext.request.contextPath }/resources/js/project/jsgantt.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/project/jsgantt.css">
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
//pro_header.jsp , pro_header.js 에서 <script>태그 안에서 변수 사용가능하다.	
var pcode= <%=pcode%> ;
	$(function() {
		$(".gantt_hover").css('color', '#ed8151').css('border-bottom',
				'1px solid #ed8151');
		$(".chat_hover").css('color', '#6d6d6d').css('border-bottom', 'none');
		$(".ptask_hover").css('color', '#6d6d6d').css('border-bottom', 'none');
		$(".files_hover").css('color', '#6d6d6d').css('border-bottom', 'none');
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
				<div class="container"
					style="background-color: white; overflow: auto;">

					<!-- PROJECT_FIX_HEADER  -->
					<%@include file="/WEB-INF/views/active/project/fix/pro_header.jsp"%>

					<!-- CHAT CONTENTS  -->
					<div style="width: 100%; height: 93%;">
						<div style="position:relative" class="gantt" id="GanttChartDIV"></div>
					</div>
				</div>

			</div>
		</div>
		<!-- FOOTER -->
		<%@include file="/WEB-INF/views/fix/footer.jsp"%>
		<!-- FOOTER -->

	</div>
	<!--FRAME  -->
</body>
</html>

<script type="text/javascript">

//tsdate!=null tedate!=null인 array 담기
var parrays=new Array();
//정렬된 array
var realplist=new Array();
var sendArray=new Array();
var step=new Array();

$(function(){
	//method item list 불러오기
	$.ajax({
		type : 'GET',
		url : '/publictask/'+ <%=pcode%> ,
		success : function(response) {
			if (response.length > 0) {
				alert('public list 조회 완료');
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
				drawg();
			}
			else  {
				alert('Server or Client ERROR, method item list 조회 실패');
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
					step.push(i+1);
					createListDiv(realplist[i].children, i+1);
			 	} 
				
				else {	
					sendArray.push(realplist[i]);
					step.push(i+1);
			}
		}
	}
	
	 
	 function createListDiv(list, parrenti) {
			for(var i= 0; i<list.length; i++) {
				var str = parrenti +''+ (i+1);
				if(list[i].children != null) {
					sendArray.push(list[i]);
					step.push(str);
					createListDiv(list[i].children, str);
				} else {
					sendArray.push(list[i]);
					step.push(str);
				}
			}
		}
	 function drawg(){
		 var popW = 500; // 띄울창의 가로사이즈
		 var popH = 400; // 띄울창의 세로사이즈 
		 var g = new JSGantt.GanttChart(document.getElementById('GanttChartDIV'), 'day');
			
			if( g.getDivId() != null ) {
				//설정
				g.setDayColWidth(30);
				g.setRowHeight(15);
				g.setCaptionType('Complete');
				g.setDateTaskTableDisplayFormat('yyyy-mm-dd');
				g.setDateTaskDisplayFormat('day dd month yyyy');
				g.setDayMajorDateDisplayFormat('yyyy/mm - ww 주차');
				g.setWeekMinorDateDisplayFormat('dd mon');
				//g.setShowTaskInfoLink(1);
				g.setUseToolTip(1); //툴팁 잠시안보이게
				g.setShowEndWeekDate(0);
				g.setUseSingleCell(10000);
				g.setFormatArr('Day');
				g.setShowTaskInfoLink(1);
				g.setUseSort(0);
				
				/* g.setCaptionType('Duration'); */
				
				
				for(var j=0;j<sendArray.length;j++){
					if(sendArray[j].trefference == 0) {
						if(sendArray[j].children != null)
							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].ttitle, sendArray[j].tsdate, sendArray[j].tedate,'gtaskgreen', 'alldocument?tcode='+sendArray[j].tcode+'&pcode='+<%=pcode%> +'&permission='+chatpermission , 0, 'TaskDoc', parseInt(sendArray[j].tpercent), 1, 0, 1,'','','Some Notes text', g ));
						else
							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].ttitle, sendArray[j].tsdate, sendArray[j].tedate,'gtaskgreen','alldocument?tcode='+sendArray[j].tcode+'&pcode='+<%=pcode%> +'&permission='+chatpermission, 0, 'TaskDoc', parseInt(sendArray[j].tpercent), 0, 0, 1,'','','Some Notes text', g ));
							
					} else {
						if(sendArray[j].children != null) {
							var prtstep = 0;
							for(var k=0; k<sendArray.length; k++) {
								if(sendArray[j].trefference == sendArray[k].tcode) {
									prtstep = k;
								}
							}
							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].ttitle, sendArray[j].tsdate, sendArray[j].tedate,'gtaskgreen','alldocument?tcode='+sendArray[j].tcode+'&pcode='+<%=pcode%> +'&permission='+chatpermission, 0, 'TaskDoc', parseInt(sendArray[j].tpercent), 1, parseInt(step[prtstep]), 1,'','','Some Notes text', g ));
						} else {
							var prtstep = 0;
							for(var k=0; k<sendArray.length; k++) {
								if(sendArray[j].trefference == sendArray[k].tcode) {
									prtstep = k;
								}
							}

							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].ttitle, sendArray[j].tsdate, sendArray[j].tedate,'gtaskgreen','alldocument?tcode='+sendArray[j].tcode+'&pcode='+<%=pcode%> +'&permission='+chatpermission, 0, 'TaskDoc', parseInt(sendArray[j].tpercent), 0, parseInt(step[prtstep]), 1,'','','Some Notes text', g ));
						}
					}
					g.Draw();
				}
			}
			$(".gselector").hide();
			$(".gtaskname").css('height','42px');
			$(".gmajorheading").css('height','42px').css('font-size','13px');
			$(".gminorheading").css('height','42px').css('font-size','13px');
			$(".gminorheadingwkend").css('font-size','13px');
			$(".gtaskcellwkend").css('height','42px');
			$(".gresource").css('font-size','13px');
			$(".genddate").css('font-size','12.5px');
			$(".gtaskname div").css('font-size','13px');
			$(".gduration").css('font-size','13px');
			$(".gpccomplete").css('font-size','13px');
			$(".gstartdate").css('font-size','12.5px');
			$(".genddate div").css('font-size','12.5px');
			$(".gstartdate div").css('font-size','12.5px');
			$(".ggroupcaption").css('font-size','13px');
			$(".gcaption").css('font-size','13px');
			$(".gtaskgreen").css('height','18px');
			$(".gtaskgreencomplete").css('height','9px');

	 }
});
</script>