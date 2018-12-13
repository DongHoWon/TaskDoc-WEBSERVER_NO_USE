package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.NoticeVO;
import com.taskdoc.www.service.notice.NoticeService;

@RestController
@RequestMapping("/notice")
public class NoticeRest {
	
	@Autowired
	NoticeService service;
	
	// 프로젝트별 공지사항 리스트 ( ncode, ntitle, ndate )
	@RequestMapping(value = "/project/{pcode}", method = RequestMethod.GET)
	public List<NoticeVO> list(@PathVariable int pcode) {
		return service.noticeList(pcode);
	}

	
	@RequestMapping(value = "/{ncode}", method = RequestMethod.GET)
	public NoticeVO view(@PathVariable int ncode) {
		return service.noticeView(ncode);
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public NoticeVO insert(@RequestBody NoticeVO noticeVo) {
		return service.noticeInsert(noticeVo);
	}

	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody NoticeVO noticeVo) {
		return service.noticeUpdate(noticeVo);
	}
	
	@RequestMapping(value = "/{ncode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int ncode) {
		return service.noticeDelete(ncode);
	}
}
