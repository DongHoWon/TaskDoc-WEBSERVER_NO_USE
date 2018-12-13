<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
			<nav class="header_nav">
				<div id="mainlogowrap">
				<!--PROJECT CREATE, TASK CREATE TOGGLE  -->
				<div class="dropdown" style="height:50px;">
					<button type="button" data-toggle="dropdown"
					 style="width: 100%;height: 100%; background:white; border: 0;outline: none;">
						<img id="projectadd" src="${pageContext.request.contextPath }/resources/img/img_projectadd.png" style="width:35px;height:35px;">
					</button>
					<ul class="dropdown-menu">
						<li>
							<a id="newproject" style="cursor: pointer;">
							<img src="${pageContext.request.contextPath }/resources/img/img_newproject.png" style="width:15px;height:15px;">
							<span>새 프로젝트</span>
							</a>
						</li>
					</ul>
				</div> 
				
				</div>
				<div id="projectnamewrap">
					<a id="projectname" href="/project/main">TaskDoc</a>
				</div>
				
				<!--EDGE RIGHT MY ID SEE  -->
				<div class="dropdown" style="/* right:0px; position:absolute; */ height:50px;">
					<button id="buttonloginid" type="button"
						data-toggle="dropdown"
						style="color: white; background-color: #333; border-color: #333; width: 100%; height: 100%; font-size:17px; outline: none; border: 0px;">
						 <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li><a href="#">나의 정보</a></li>
						<li><a href="/user/logout">로그아웃</a></li>
					</ul>
				</div> 
				
				<!--EDGE RIGHT MY ID SEE  -->

			</nav>
		</header>