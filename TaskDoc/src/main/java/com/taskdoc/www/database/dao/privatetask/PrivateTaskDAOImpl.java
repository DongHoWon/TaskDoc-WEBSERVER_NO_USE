package com.taskdoc.www.database.dao.privatetask;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.PrivateTaskVO;

@Repository
public class PrivateTaskDAOImpl implements PrivateTaskDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "privatetask_SQL.";
	private final String UIDLIST = "idlist";
	private final String VIEW="view";
	private final String TCODELIST = "codelist";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	private final String SELFREFMAX = "selfRefMax";
	private final String SAMEREFMAX = "sameRefMax";
	private final String DOWNTASK="downtask";
	private final String PLIST="plist";
	private final String PTLIST="ptlist";

	@Override
	public List<PrivateTaskVO> privateTaskList(int tcode, String uid) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tcode", tcode);
		map.put("uid", uid);
		return sql.selectList(NAMESPACE + TCODELIST, map);
	}

	@Override
	public List<PrivateTaskVO> privateTaskList(String uid) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + UIDLIST, uid);
	}

	@Override
	public int privateTaskInsert(PrivateTaskVO privateTaskVo) {
		// TODO Auto-generated method stub
		try {
			sql.insert(NAMESPACE + INSERT, privateTaskVo);
			return privateTaskVo.getPtcode();
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int privateTaskUpdate(PrivateTaskVO privateTaskVo) {
		// TODO Auto-generated method stub
		try {
			return sql.update(NAMESPACE + UPDATE, privateTaskVo);
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int privateTaskDelete(int ptcode) {
		// TODO Auto-generated method stub
		try {
			return sql.delete(NAMESPACE + DELETE, ptcode);
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public Integer selfRefMax(int tcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + SELFREFMAX, tcode);
	}

	@Override
	public Integer sameRefMax(int ptrefference) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + SAMEREFMAX, ptrefference);
	}

	@Override
	public PrivateTaskVO privateTaskView(int ptcode) {
		return sql.selectOne(NAMESPACE + VIEW ,ptcode);
	}

	@Override
	public List<PrivateTaskVO> privateDownTask(int ptrefference) {
		return sql.selectList(NAMESPACE+DOWNTASK,ptrefference);
	}

	@Override
	public List<PrivateTaskVO> publicTaskList(String uid) {
		return sql.selectList(NAMESPACE+PLIST,uid);
	}

	@Override
	public List<PrivateTaskVO> multiPrivateTaskList(PrivateTaskVO privateTaskVO) {
		return sql.selectList(NAMESPACE+PTLIST,privateTaskVO);
	}

	
}
