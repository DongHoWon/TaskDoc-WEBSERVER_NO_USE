package com.taskdoc.www.controller.restful;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.UserInfoVO;
import com.taskdoc.www.service.project.ProjectService;
import com.taskdoc.www.system.JsonMapper;

@RestController
@RequestMapping("/project")
public class ProjectRest {

	@Autowired
	ProjectService service;
	
	// 프로젝트 생성시 생성자는 'OWNER' 로써 프로젝트에 참가 ( Service Transaction 처리 ) > 성공 pid값, 실패 -1
	@RequestMapping(value = "", method = RequestMethod.POST)
	public int insert(@RequestBody Map<String, Object> data) {
		
		ProjectVO projectVo = JsonMapper.mapToJson(data.get("project"), ProjectVO.class);
		UserInfoVO userinfoVo = JsonMapper.mapToJson(data.get("userInfo"), UserInfoVO.class);
		
		try {
			return service.projectInsert(projectVo, userinfoVo);
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@RequestMapping(value = "", method = RequestMethod.PUT)
	public int update(@RequestBody ProjectVO projectVo) {
		return service.projectUpdate(projectVo);
	}
	
	@RequestMapping(value = "/{pcode}", method = RequestMethod.DELETE)
	public int delete(@PathVariable int pcode) {
		return service.projectDelete(pcode);
	}
}
