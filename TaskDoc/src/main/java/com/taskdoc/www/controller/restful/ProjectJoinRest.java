package com.taskdoc.www.controller.restful;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.taskdoc.www.database.dto.ProjectJoinVO;
import com.taskdoc.www.service.projectjoin.ProjectJoinService;

@RestController
@RequestMapping("/projectjoin")
public class ProjectJoinRest {

	@Autowired
	ProjectJoinService service;
	
	// 내가 참가하는 모든 프로젝트를 검색
	// 프로젝트 결과 값 = map ( KEY = "projectList", "projectJoinList" )
	@RequestMapping(value = "/{uid}", method = RequestMethod.GET)
	public Map<String, Object> listProject(@PathVariable String uid) {
		return service.projectJoinList(uid);
	}

	// 프로젝트에 참가하는 모든 회원을 검색
	// 프로젝트 결과 값 = map ( KEY = "userList", "joinList" )
	@RequestMapping(value = "/collaboration/{pcode}", method = RequestMethod.GET)
	public Map<String, Object> listUser(@PathVariable int pcode) {
		return service.projectJoinListUser(pcode);
	}
	
	//회원 초대시 회원이 프로젝트에 존재하는지 pcode와 uid를 이용해서 검색.
	@RequestMapping(value = "/projectSelectid", method = RequestMethod.POST)
	public List<ProjectJoinVO> listUser(@RequestBody ProjectJoinVO projectJoinVo) {
		return service.projectSelectid(projectJoinVo);
	}
	
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody ProjectJoinVO projectJoinVo) {
		return service.projectJoinInsert(projectJoinVo);
	}

	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody ProjectJoinVO projectJoinVo) {
		return service.projectJoinUpdate(projectJoinVo);
	}
	
	@RequestMapping(value = "", method = RequestMethod.DELETE)
	public int delete(@RequestBody ProjectJoinVO projectJoinVo) {
		return service.projectJoinDelete(projectJoinVo);
	}
}
