package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.MethodListVO;
import com.taskdoc.www.service.methodlist.MethodListService;

@RestController
@RequestMapping("/methodlist")
public class MethodListRest {
	
	@Autowired
	MethodListService service;
	
	// 내목록에 추가한 게시판을 보여준다.
	@RequestMapping(value = "/{uid}", method = RequestMethod.GET)
	public List<MethodListVO> list(@PathVariable String uid) {
		return service.methodListList(uid);
	}
	
	@RequestMapping(value="", method=RequestMethod.POST)
	public int insert(@RequestBody MethodListVO methodListVo) {
		return service.methodListInsert(methodListVo);
	}

	@RequestMapping(value="", method=RequestMethod.PUT)
	public int update(@RequestBody MethodListVO methodListVo) {
		return service.methodListUpdate(methodListVo);
	}

	@RequestMapping(value="", method=RequestMethod.DELETE)
	public int delete(@RequestBody MethodListVO methodListVo) {
		return service.methodListDelete(methodListVo);
	}
}
