package com.taskdoc.www.database.dao.projectjoin;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.ProjectJoinVO;

@Repository
public class ProjectJoinDAOImpl implements ProjectJoinDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "projectjoin_SQL.";
	private final String LISTPROJECT = "listProject";
	private final String LISTUSER = "listUser";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	
	
	// uid > Project list
	@Override
	public List<ProjectJoinVO> projectJoinList(String uid) {
		return sql.selectList(NAMESPACE + LISTPROJECT, uid);
	}
	
	// pcode > users list
	@Override 
	public List<ProjectJoinVO> projectJoinListUser(int pcode) {
		return sql.selectList(NAMESPACE + LISTUSER, pcode);
	}

	@Override
	public int projectJoinInsert(ProjectJoinVO projectJoinVo) {
		try {
			return sql.insert(NAMESPACE + INSERT, projectJoinVo);
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int projectJoinUpdate(ProjectJoinVO projectJoinVo) {
		return sql.update(NAMESPACE + UPDATE, projectJoinVo);
	}

	@Override
	public int projectJoinDelete(ProjectJoinVO projectJoinVo) {
		return sql.delete(NAMESPACE + DELETE, projectJoinVo);
	}

	@Override
	public List<ProjectJoinVO> projectSelectid(ProjectJoinVO projectJoinVo) {
		return sql.selectList(NAMESPACE+"projectSelectid", projectJoinVo);
	}

}
