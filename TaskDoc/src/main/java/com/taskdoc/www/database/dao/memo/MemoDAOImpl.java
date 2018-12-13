package com.taskdoc.www.database.dao.memo;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.MemoVO;

@Repository
public class MemoDAOImpl implements MemoDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "memo_SQL.";
	private final String LIST = "list";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	
	@Override
	public List<MemoVO> memoList(int ptcode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST, ptcode);
	}

	@Override
	public int memoInsert(MemoVO memoVo) {
		// TODO Auto-generated method stub
		sql.insert(NAMESPACE + INSERT, memoVo);
		return memoVo.getMcode();
	}

	@Override
	public int memoUpdate(MemoVO memoVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, memoVo);
	}

	@Override
	public int memoDelete(int mcode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, mcode);
	}

}
