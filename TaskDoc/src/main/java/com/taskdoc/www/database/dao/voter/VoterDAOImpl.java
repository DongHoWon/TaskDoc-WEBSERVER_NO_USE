package com.taskdoc.www.database.dao.voter;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.VoterVO;

@Repository
public class VoterDAOImpl implements VoterDAO {
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "voter_SQL.";
	private final String LIST = "list";
	private final String INSERT = "insert";
	private final String DELETE = "delete";
	private final String CHECK = "check";

	@Override
	public List<VoterVO> voterList(int dsicode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST, dsicode);
	}

	@Override
	public int voterInsert(VoterVO voterVo) {
		// TODO Auto-generated method stub
		return sql.insert(NAMESPACE + INSERT, voterVo);
	}

	@Override
	public int voterDelete(VoterVO voterVo) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, voterVo);
	}

	@Override
	public List<String> voterCheck(int dscode) {
		return sql.selectList(NAMESPACE+CHECK,dscode);
	}




}
