package com.taskdoc.www.database.dao.methodboard;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.MethodBoardVO;

@Repository
public class MethodBoardDAOImpl implements MethodBoardDAO {
	
	private final String NAMESPACE="methodboard_SQL.";
	private final String LIST="list";
	private final String USERLIST="mylist";
	private final String VIEW="view";
	private final String INSERT="insert";
	private final String UPDATE="update";
	private final String DELETE="delete";
	
	@Autowired
	SqlSession sql;

	@Override
	public List<MethodBoardVO> methodBoardList() {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST);
	}

	@Override
	public List<MethodBoardVO> methodBoardMyList(String uid) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + USERLIST, uid);
	}
	
	@Override
	public MethodBoardVO methodBoardView(int mbcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, mbcode);
	}

	@Override
	public int methodBoardInsert(MethodBoardVO methodBoardVo) {
		// TODO Auto-generated method stub
		return sql.insert(NAMESPACE + INSERT, methodBoardVo);
	}

	@Override
	public int methodBoardUpdate(MethodBoardVO methodBoardVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, methodBoardVo);
	}

	@Override
	public int methodBoardDelete(int mbcode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, mbcode);
	}

}
