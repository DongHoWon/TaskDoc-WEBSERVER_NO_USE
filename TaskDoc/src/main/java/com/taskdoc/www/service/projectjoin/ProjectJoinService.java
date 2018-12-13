package com.taskdoc.www.service.projectjoin;

import java.util.List;
import java.util.Map;

import com.taskdoc.www.database.dto.ProjectJoinVO;

public interface ProjectJoinService {
	public Map<String, Object> projectJoinList(String uid);
	public Map<String, Object> projectJoinListUser(int pcode);
	public int projectJoinInsert(ProjectJoinVO projectJoinVo);
	public int projectJoinUpdate(ProjectJoinVO projectJoinVo);
	public int projectJoinDelete(ProjectJoinVO projectJoinVo);
	
	//프로젝트에 회원초대시 회원이 프로젝트에 초대된지 안된지 체크하려고만듬
	public List<ProjectJoinVO> projectSelectid(ProjectJoinVO projectJoinVo);
}
