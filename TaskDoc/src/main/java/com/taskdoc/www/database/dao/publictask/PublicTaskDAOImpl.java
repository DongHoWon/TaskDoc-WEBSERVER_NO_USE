package com.taskdoc.www.database.dao.publictask;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.PublicTaskVO;

@Repository
public class PublicTaskDAOImpl implements PublicTaskDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "publictask_SQL.";
	private final String LIST = "list";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	private final String SELFREFMAX = "selfRefMax";
	private final String SAMEREFMAX = "sameRefMax";
	private final String ROOTTASK = "roottask";
	private final String DOWNTASK = "downtask";
	private final String ONETASK = "onetask";

	@Override
	public List<PublicTaskVO> publicTaskList(int pcode) {
		return sql.selectList(NAMESPACE + LIST, pcode);
	}
	
	@Override
	public int publicTaskInsert(PublicTaskVO publicTaskVo) {
		try {
			sql.insert(NAMESPACE + INSERT, publicTaskVo);
			return publicTaskVo.getTcode();			
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int publicTaskUpdate(PublicTaskVO publicTaskVo) {
		try {
			return sql.update(NAMESPACE + UPDATE, publicTaskVo);
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int publicTaskDelete(int tcode) {
		try {			
			return sql.delete(NAMESPACE + DELETE, tcode);
		}catch(Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public Integer selfRefMax(int pcode) {
		return sql.selectOne(NAMESPACE + SELFREFMAX, pcode);
	}

	@Override
	public Integer sameRefMax(int trefference) {
		return sql.selectOne(NAMESPACE + SAMEREFMAX, trefference);
	}
	
	
	@Override
	public PublicTaskVO publicTaskView(int tcode) {
		return sql.selectOne(NAMESPACE + VIEW, tcode);
	}

	@Override
	public List<PublicTaskVO> publicRootTask(int pcode) {
		return sql.selectList(NAMESPACE+ROOTTASK, pcode);
	}

	@Override
	public List<PublicTaskVO> publicDownTask(int trefference) {
		return sql.selectList(NAMESPACE+DOWNTASK, trefference);
	}



	
}
