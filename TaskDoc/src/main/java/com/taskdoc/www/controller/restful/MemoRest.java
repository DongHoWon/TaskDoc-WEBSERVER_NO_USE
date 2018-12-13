package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.MemoVO;
import com.taskdoc.www.service.memo.MemoService;

@RestController
@RequestMapping("/memo")
public class MemoRest {

	@Autowired
	MemoService service;
	
	@RequestMapping(value = "/{ptcode}", method = RequestMethod.GET)
	public List<MemoVO> list(@PathVariable int ptcode) {
		return service.memoList(ptcode);
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody MemoVO memoVo) {
		return service.memoInsert(memoVo);
	}

	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody MemoVO memoVo) {
		return service.memoUpdate(memoVo);
	}
	
	@RequestMapping(value = "/{mcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int mcode) {
		return service.memoDelete(mcode);
	}
}
