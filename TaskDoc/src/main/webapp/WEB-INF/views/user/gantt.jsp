<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div style="position:relative" class="gantt" id="GanttChartDIV"></div>

<script type="text/javascript">
var parrays=new Array();
var realplist=new Array();
var sendArray=new Array();
var step=new Array();

	$.ajax({
		type : 'GET',
		url : '/privatetask/user/' + id,
		success : function(response) {
			if (response.length > 0 ) {
				for(var i=0;i<response.length;i++){
					if(response[i].ptsdate!=null && response[i].ptedate!=null){
						  if(response[i].ptcode == response[i].ptrefference) {
							   response[i].ptrefference = 0;
						   }
						  parrays.push(response[i]);	
					}
				}
				realplist = treeModel(parrays, 0);
				console.log(realplist);
				listmake();
				drawg(); 
			}else{
				alert('Server or Client ERROR, 개인 업무 조회에 실패 했습니다.');
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
					if (node.ptcode === item.ptrefference) {
						node.children = node.children || [];
						return node.children.push(arrayList.splice(index, 1)[0]);
					}
	
					return traverse(node.children, item, index);
				});
			}
		};
	
		while (arrayList.length > 0) {
			arrayList.some(function (item, index) {
				if (item.ptrefference === rootId) {
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
				g.setUseToolTip(0); //툴팁 잠시안보이게
				g.setShowEndWeekDate(0);
				g.setUseSingleCell(10000);
				g.setFormatArr('Day');
				g.setShowTaskInfoLink(1);
				g.setUseSort(0);
				
				
				
				for(var j=0;j<sendArray.length;j++){
					if(sendArray[j].ptrefference == 0) {
						if(sendArray[j].children != null)
							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].pttitle, sendArray[j].ptsdate, sendArray[j].ptedate,'gtaskblue', '' , 0, 'TaskDoc', parseInt(sendArray[j].ptpercent), 1, 0, 1,'','','Some Notes text', g ));
						else
							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].pttitle, sendArray[j].ptsdate, sendArray[j].ptedate,'gtaskblue','', 0, 'TaskDoc', parseInt(sendArray[j].ptpercent), 0, 0, 1,'','','Some Notes text', g ));
							
					} else {
						if(sendArray[j].children != null) {
							var prtstep = 0;
							for(var k=0; k<sendArray.length; k++) {
								if(sendArray[j].ptrefference == sendArray[k].ptcode) {
									prtstep = k;
								}
							}
							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].pttitle, sendArray[j].ptsdate, sendArray[j].ptedate,'gtaskblue','', 0, 'TaskDoc', parseInt(sendArray[j].ptpercent), 1, parseInt(step[prtstep]), 1,'','','Some Notes text', g ));
						} else {
							var prtstep = 0;
							for(var k=0; k<sendArray.length; k++) {
								if(sendArray[j].ptrefference == sendArray[k].ptcode) {
									prtstep = k;
								}
							}

							g.AddTaskItem(new JSGantt.TaskItem(parseInt(step[j]), sendArray[j].pttitle, sendArray[j].ptsdate, sendArray[j].ptedate,'gtaskblue','', 0, 'TaskDoc', parseInt(sendArray[j].ptpercent), 0, parseInt(step[prtstep]), 1,'','','Some Notes text', g ));
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
			$(".gtaskblue").css('height','18px');
			$(".gtaskbluecomplete").css('height','9px');
	 } 
</script>
</html>