package com.taskdoc.www.controller.restful;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.PublicTaskVO;
import com.taskdoc.www.service.publictask.PublicTaskService;

@RestController
@RequestMapping("/publictask")
public class PublicTaskRest {

	@Autowired
	PublicTaskService service;

	// 해당 프로젝트에대한 모든 공유업무만 받아옴
	@RequestMapping(value = "/{pcode}", method = RequestMethod.GET)
	public List<PublicTaskVO> list(@PathVariable int pcode) {
		return service.publicTaskList(pcode);
	}

	// 해당 아이디에 대한 모든 업무
	@RequestMapping(value = "/all/{pcode}/{uid}", method = RequestMethod.GET)
	public Map<String, Object> listAll(@PathVariable int pcode, @PathVariable String uid) {
		return service.publicTaskAllList(pcode, uid);
	}

	// 최상위 공용업무 조회, WEB
	@RequestMapping(value = "/root/{pcode}", method = RequestMethod.GET)
	public List<PublicTaskVO> rootTask(@PathVariable int pcode) {
		return service.publicRootTask(pcode);
	}

	// 하위 공용업무 조회 , WEB
	@RequestMapping(value = "/down/{trefference}", method = RequestMethod.GET)
	public List<PublicTaskVO> downTask(@PathVariable int trefference) {
		return service.publicDownTask(trefference);
	}

	// 업무 하나 조회 , WEB
	@RequestMapping(value = "/publicTaskView/{tcode}", method = RequestMethod.GET)
	public PublicTaskVO publicTaskView(@PathVariable int tcode) {
		return service.publicTaskView(tcode);
	}

	// 공용업무생성
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody PublicTaskVO publicTaskVo) {
		return service.publicTaskInsert(publicTaskVo);
	}

	// 공용업무생성
	@RequestMapping(value = "/multiple", method = RequestMethod.POST)
	public List<PublicTaskVO> insertList(@RequestBody List<PublicTaskVO> vos) {
		return service.publicTaskInsertMulti(vos);
	}

	// 공용업무 수정
	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody PublicTaskVO publicTaskVo) {
		return service.publicTaskUpdate(publicTaskVo);
	}

	// 공용업무 삭제
	@RequestMapping(value = "/{tcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int tcode) {
		return service.publicTaskDelete(tcode);
	}
}
