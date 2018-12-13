package com.taskdoc.www.service.project;

import com.taskdoc.www.database.dto.ProjectVO;
import com.taskdoc.www.database.dto.UserInfoVO;

public interface ProjectService {
	public int projectInsert(ProjectVO projectVo, UserInfoVO userInfoVo) throws Exception;
	public int projectUpdate(ProjectVO projectVo);
	public int projectDelete(int pcode);
}
