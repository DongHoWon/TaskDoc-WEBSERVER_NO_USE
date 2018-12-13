package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.MethodBoardVO;
import com.taskdoc.www.service.methodboard.MethodBoardService;

@RestController
@RequestMapping("/methodboard")
public class MethodBoardRest {
	
	@Autowired
	MethodBoardService service;
	
	// 게시판 목록 전체를 받아온다. ( mbcode, mbtitle, mbdate )
	@RequestMapping(value="/all", method=RequestMethod.GET)
	public List<MethodBoardVO> list() {
		return service.methodBoardList();
	}

	@RequestMapping(value="/mylist/{uid}", method=RequestMethod.GET)
	public List<MethodBoardVO> myList(@PathVariable String uid) {
		return service.methodBoardMyList(uid);
	}

	// 게시판의 글 상세보기
	@RequestMapping(value="/{mbcode}", method=RequestMethod.GET)
	public MethodBoardVO view(@PathVariable int mbcode) {
		return service.methodBoardView(mbcode);
	}
	
	//게시글 작성하기
	@RequestMapping(value="", method=RequestMethod.POST)
	public int insert(@RequestBody MethodBoardVO methodBoard) {
		return service.methodBoardInsert(methodBoard);
	}

	@RequestMapping(value="", method=RequestMethod.PUT)
	public int update(@RequestBody MethodBoardVO methodBoard) {
		int i = service.methodBoardUpdate(methodBoard);
		return i;
	}

	@RequestMapping(value="/{mbcode}", method=RequestMethod.DELETE)
	public int delete(@PathVariable int mbcode) {
		return service.methodBoardDelete(mbcode);
	}
}
