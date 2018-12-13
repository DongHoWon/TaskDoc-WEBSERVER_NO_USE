package com.taskdoc.www.controller.restful;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.PrivateTaskVO;
import com.taskdoc.www.service.privatetask.PrivateTaskService;

@RestController
@RequestMapping("/privatetask")
public class PrivateTaskRest {

	@Autowired
	PrivateTaskService service;
	
	//해당 ID에대한 모든 개인업무 받아옴
	@RequestMapping(value = "/user/{uid}", method = RequestMethod.GET)
	public List<PrivateTaskVO> list(@PathVariable String uid) {
		return service.privateTaskList(uid);
	}
	
	//UID와 개인업무PTCODE를 이용해 공용업무를 미리 조회
	@RequestMapping(value = "/user/plist/{uid}", method = RequestMethod.GET)
	public List<PrivateTaskVO> plist(@PathVariable String uid) {
		return service.publicTaskList(uid);
	}

	//UID와 개인업무PTCODE를 이용해 공용업무를 미리 조회
	@RequestMapping(value = "/user/ptlist", method = RequestMethod.POST)
	public List<PrivateTaskVO> ptlist(@RequestBody PrivateTaskVO privateTaskVO) {
		return service.multiPrivateTaskList(privateTaskVO);
	}

	@RequestMapping(value = "/{ptcode}", method = RequestMethod.GET)
	public PrivateTaskVO view(@PathVariable int ptcode) {
		return service.privateTaskView(ptcode);
	}
	
	//하위 개인업무 조회
	@RequestMapping(value = "/down/{ptrefference}", method = RequestMethod.GET)
	public List<PrivateTaskVO> downTask(@PathVariable int ptrefference) {
		return service.privateDownTask(ptrefference);
	}

	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody PrivateTaskVO privateTaskVo) {
		return service.privateTaskInsert(privateTaskVo);
	}
	
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody PrivateTaskVO privateTaskVo) {
		return service.privateTaskupdate(privateTaskVo);
	}
	
	@RequestMapping(value = "/{ptcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int ptcode) {
		return service.privateTaskDelete(ptcode);
	}
}
