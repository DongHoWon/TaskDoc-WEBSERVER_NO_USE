var screenW = screen.availWidth;  // 스크린 가로사이즈
var screenH = screen.availHeight; // 스크린 세로사이즈
var popW = 600; // 띄울창의 가로사이즈
var popH = 350; // 띄울창의 세로사이즈
var posL=( screenW-popW ) / 2;   // 띄울창의 가로 포지션 
var posT=( screenH-popH ) / 2;   // 띄울창의 세로 포지션 
//로그인 아이디 앞에 'ID' 를 붙임
$(document).ready(function() {
	$("#buttonloginid").html('ID : '+id);
});

//새 프로젝트 클릭, 새 업무 클릭시  WINDOW 창 생성
$(function() {
	$("#newproject").click(function() {
		window.open("/project/create","", 'width='+ popW +',height='+ popH +',top='+ posT +',left='+ posL +',resizable=no,scrollbars=no'); 
	});
	
	$("#newtask").click(function() {
		location.href = '/privatetask/create';
	});
});