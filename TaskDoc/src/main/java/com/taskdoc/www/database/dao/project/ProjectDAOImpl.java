package com.taskdoc.www.database.dao.project;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.ProjectVO;

@Repository
public class ProjectDAOImpl implements ProjectDAO {
	
	private final String NAMESPACE = "project_SQL.";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	
	@Autowired
	SqlSession sql;

	@Override
	public ProjectVO projectView(int pcode) {
		return sql.selectOne(NAMESPACE + VIEW, pcode);
	}

	@Override
	public int projectInsert(ProjectVO projectVo) {
		sql.insert(NAMESPACE + INSERT, projectVo);
		return projectVo.getPcode();
	}

	@Override
	public int projectUpdate(ProjectVO projectVo) {
		return sql.update(NAMESPACE + UPDATE, projectVo);
	}

	@Override
	public int projectDelete(int pcode) {
		return sql.delete(NAMESPACE + DELETE, pcode);
	}
}
