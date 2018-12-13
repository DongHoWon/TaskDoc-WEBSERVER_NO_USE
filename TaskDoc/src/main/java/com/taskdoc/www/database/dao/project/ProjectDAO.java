package com.taskdoc.www.database.dao.project;

import com.taskdoc.www.database.dto.ProjectVO;

public interface ProjectDAO {
	public ProjectVO projectView(int pcode);
	public int projectInsert(ProjectVO projectVo);
	public int projectUpdate(ProjectVO projectVo);
	public int projectDelete(int pcode);
}
