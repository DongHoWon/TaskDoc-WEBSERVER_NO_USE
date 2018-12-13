package com.taskdoc.www.controller.http;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
@RequestMapping("/chat")
public class Chat {
	
	//채팅메인
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "/active/chat/main";
	}
	
	//채팅내용 and button들 불러오기
	@RequestMapping(value = "/content", method = RequestMethod.GET)
	public String content() {
		return "/active/chat/window/content";
	}

	//채팅생성
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
		return "/active/chat/window/create";
	}
	
	//채팅에 유저초대
	@RequestMapping(value = "/userInvite", method = RequestMethod.GET)
	public String userinvite() {
		return "/active/chat/window/userInvite";
	}
	
	//채팅에서 파일 업로드
	@RequestMapping(value = "/fileUpload", method = RequestMethod.GET)
	public String fileUpload() {
		return "/active/chat/window/fileUpload";
	}
	
	//채팅에서 파일 다운로드
	@RequestMapping(value = "/fileDownload", method = RequestMethod.GET)
	public String fileDownload() {
		return "/active/chat/window/fileDownload";
	}

	//채팅에서 의사 결정 생성
	@RequestMapping(value = "/decisionCreate", method = RequestMethod.GET)
	public String decisionCreate() {
		return "/active/chat/window/decisionCreate";
	}
	
	//채팅에서 의사 결정 생성 선택
	@RequestMapping(value = "/decisionSelect", method = RequestMethod.GET)
	public String decisionSelect() {
		return "/active/chat/window/decisionSelect";
	}
	
	//채팅에서 의사 결정 보기
	@RequestMapping(value = "/decisionView", method = RequestMethod.GET)
	public String decisionView() {
		return "/active/chat/window/decisionView";
	}

	//session
	@RequestMapping(value = "/focusCreate", method = RequestMethod.GET)
	public String focus() {
		return "/active/chat/window/focusCreate";
	}
}
