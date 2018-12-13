package com.taskdoc.www.database.dao.projectjoin;

import java.util.List;

import com.taskdoc.www.database.dto.ProjectJoinVO;

public interface ProjectJoinDAO {
	public List<ProjectJoinVO> projectJoinList(String uid);
	public List<ProjectJoinVO> projectJoinListUser(int pcode);
	public int projectJoinInsert(ProjectJoinVO projectJoinVo);
	public int projectJoinUpdate(ProjectJoinVO projectJoinVo);
	public int projectJoinDelete(ProjectJoinVO projectJoinVo);
	
	//프로젝트에 회원초대시 회원이 프로젝트에 초대된지 안된지 체크하려고만듬
	public List<ProjectJoinVO> projectSelectid(ProjectJoinVO projectJoinVo);
}
