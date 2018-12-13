package com.taskdoc.www.controller.http;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/methodboard")
@Controller
public class Board {
	//게시판메인
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "/active/methodboard/main";
	}
	
	//게시판 생성
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
		return "/active/methodboard/create";
	}
	//게시판 상세보기
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public String view() {
		return "/active/methodboard/view";
	}
	//게시판 상세보기
	@RequestMapping(value = "/method/view", method = RequestMethod.GET)
	public String method() {
		return "/active/methodboard/methoddetail";
	}
	//게시판 수정
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit() {
		return "/active/methodboard/edit";
	}
	//게시판 생성, 수정시 프로젝트 선택하는 window창
	@RequestMapping(value = "/selectProject", method = RequestMethod.GET)
	public String selectProject() {
		return "/active/methodboard/selectProject";
	}
}
