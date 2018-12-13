package com.taskdoc.www.controller.http;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/project")
public class Project {
	private static final Logger logger = LoggerFactory.getLogger(Project.class);

	/*
	 * 2.프로젝트 메인 , 생성 , 프로젝트 멤버 초대, 프로젝트(이름, 멤버 삭제 등등,,) 수정 , 프로젝트 공지사항,
	 * 
	 */
	
	//프로젝트 리스트들.
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		return "/active/project/main";
	}

	//프로젝트 생성하기
	@RequestMapping(value = "/create")
	public String create() {
		return "/active/project/window/create";
	}

	//프로젝트에 회원초대하기
	@RequestMapping(value = "/userInvite", method = RequestMethod.GET)
	public String userInvite() {
		return "/active/project/window/userInvite";
	}

	//프로젝트 정보수정
	@RequestMapping(value = "/infoEdit", method = RequestMethod.GET)
	public String infoEdit() {
		return "/active/project/window/infoEdit";
	}

	//공지사항메인
	@RequestMapping(value = "/noticeMain", method = RequestMethod.GET)
	public String noticeMain() {
		return "/active/project/notice/main";
	}
	//공지사항생성
	@RequestMapping(value = "/noticeCreate", method = RequestMethod.GET)
	public String noticecreate() {
		return "/active/project/notice/create";
	}
	//공지사항상세보기
	@RequestMapping(value = "/noticeView", method = RequestMethod.GET)
	public String noticeview() {
		return "/active/project/notice/view";
	}
	//공지사항수정
	@RequestMapping(value = "/noticeEdit", method = RequestMethod.GET)
	public String noticemodify() {
		return "/active/project/notice/edit";
	}
	
	//프로젝트  -->채팅으로
	@RequestMapping(value = "/chat/main", method = RequestMethod.GET)
	public String info() {
		return "/active/chat/main";
	}
	
	//프로젝트 -->공용업무
	//프로젝트 -->간트차트
	//프로젝트 -->파일모아보기
	
	
	/*
	 * 4.공용 업무 메인, 공용 업무 생성 ,공용 업무 수정 ,개인 업무 메인  , 개인 업무 생성, 개인 업무 수정  
	 * 
	 */
	
	//공용업무 메인
	@RequestMapping(value = "/publicTask/main", method = RequestMethod.GET)
	public String publicTaskMain() {
		return "/active/publictask/main";
	}
	
	//공용업무 의 하위 업무
	@RequestMapping(value = "/publicTask/downTask", method = RequestMethod.GET)
	public String downTask() {
		return "/active/publictask/window/downtask";
	}
	
	//공용업무의 하위 업무 생성
	@RequestMapping(value = "/publicTask/downTaskCreate", method = RequestMethod.GET)
	public String downTaskCreate() {
		return "/active/publictask/window/downtaskcreate";
	}
	
	//공용업무 생성
	@RequestMapping(value = "/publicTask/create", method = RequestMethod.GET)
	public String publicTaskCreate() {
		return "/active/publictask/window/create";
	}
	
	//폴더생성
	@RequestMapping(value = "/folder/create", method = RequestMethod.GET)
	public String filecreate() {
		return "/active/file/create";
	}
	//하위 폴더 생성
	@RequestMapping(value = "/folder/downcreate", method = RequestMethod.GET)
	public String downfoldercreate() {
		return "/active/file/downfoldercreate";
	}
	
	//공용업무 수정
	@RequestMapping(value = "/publicTask/edit", method = RequestMethod.GET)
	public String publicTaskEdit() {
		return "/active/publictask/window/edit";
	}
	
	//METHOD로 공용 업무 생성하기
	@RequestMapping(value = "/method/publicTask/create", method = RequestMethod.GET)
	public String methodtaskcreate() {
		return "/active/publictask/window/method/create";
	}

	//METHOD의 공용 업무 보기
	@RequestMapping(value = "/method/publicTask/view", method = RequestMethod.GET)
	public String methodtaskview() {
		return "/active/publictask/window/method/view";
	}

	//나의 METHOD로 공용 업무 생성하기
	@RequestMapping(value = "/mymethod/publicTask/create", method = RequestMethod.GET)
	public String mymethodtaskcreate() {
		return "/active/publictask/window/mymethod/create";
	}
	
	//나의 METHOD의 공용 업무 보기
	@RequestMapping(value = "/mymethod/publicTask/view", method = RequestMethod.GET)
	public String mymethodtaskview() {
		return "/active/publictask/window/mymethod/view";
	}
	
	//개인업무 메인
	@RequestMapping(value = "/privateTask/main", method = RequestMethod.GET)
	public String privateTaskMain() {
		return "/active/privatetask/main";
	}
	
	//개인 업무 생성
	@RequestMapping(value = "/privateTask/create", method = RequestMethod.GET)
	public String privateTaskCreate() {
		return "/active/privatetask/window/create";
	}
	
	//개인업무 의 하위 업무
	@RequestMapping(value = "/privateTask/downTask", method = RequestMethod.GET)
	public String privatedownTask() {
		return "/active/privatetask/window/downtask";
	}
		
	//개인업무의 하위 업무 생성
	@RequestMapping(value = "/privateTask/downTaskCreate", method = RequestMethod.GET)
	public String privatedownTaskCreate() {
		return "/active/privatetask/window/downtaskcreate";
	}
		
	//개인 업무 수정
	@RequestMapping(value = "/privateTask/edit", method = RequestMethod.GET)
	public String privateTaskEdit() {
		return "/active/privatetask/window/edit";
	}
	
	//메모 메인
	@RequestMapping(value = "/memo/main", method = RequestMethod.GET)
	public String memoMain() {
		return "/active/privatetask/memo/main";
	}
	
	//메모 생성
	@RequestMapping(value = "/memo/create", method = RequestMethod.GET)
	public String memoCreate() {
		return "/active/privatetask/memo/create";
	}
	
	//메모 수정
	@RequestMapping(value = "/memo/edit", method = RequestMethod.GET)
	public String memoEdit() {
		return "/active/privatetask/memo/edit";
	}
	
	//메모 보기
	@RequestMapping(value = "/memo/view", method = RequestMethod.GET)
	public String memoView() {
		return "/active/privatetask/memo/view";
	}
	
	//공용업무의 파일
	@RequestMapping(value = "/file/main", method = RequestMethod.GET)
	public String fileMain() {
		return "/active/file/main";
	}

	//공용업무의 파일
	@RequestMapping(value = "/file/downloadForm", method = RequestMethod.GET)
	public String downloadForm() {
		return "/active/file/downloadForm";
	}
	
	//공용업무의 하위업무 파일
	@RequestMapping(value = "/file/downview", method = RequestMethod.GET)
	public String fileView() {
		return "/active/file/downview";
	}
	
	//간트
	@RequestMapping(value = "/gantt/main", method = RequestMethod.GET)
	public String gantView() {
		return "/active/gantt/view";
	}
	//간트
	@RequestMapping(value = "/gantt/main/alldocument", method = RequestMethod.GET)
	public String alldocument() {
		return "/active/gantt/alldocument";
	}
	
	
}
