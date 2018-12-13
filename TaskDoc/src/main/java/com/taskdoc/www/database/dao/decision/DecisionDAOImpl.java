package com.taskdoc.www.database.dao.decision;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.DecisionVO;

@Repository
public class DecisionDAOImpl implements DecisionDAO {
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "decision_SQL.";
	private final String TASKLIST = "tasklist";
	private final String ROOMLIST = "roomlist";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";

	@Override
	public List<DecisionVO> taskList(int tcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + TASKLIST, tcode);
	}

	@Override
	public List<DecisionVO> roomList(int crcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + ROOMLIST, crcode);
	}
	
	@Override
	public DecisionVO view(int dscode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, dscode);
	}
	
	@Override
	public int decisionInsert(DecisionVO decisionVo) {
		// TODO Auto-generated method stub
		sql.insert(NAMESPACE + INSERT, decisionVo);
		return decisionVo.getDscode();
	}

	@Override
	public int decisionUpdate(DecisionVO decisionVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, decisionVo);
	}

	@Override
	public int decisionDelete(int dscode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, dscode);
	}



}
