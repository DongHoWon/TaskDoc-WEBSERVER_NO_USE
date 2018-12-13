package com.taskdoc.www.database.dao.mothodlist;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.MethodListVO;

@Repository
public class MethodListDAOImpl implements MethodListDAO {
	
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "methodlist_SQL.";
	private final String LIST = "list";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";

	@Override
	public List<MethodListVO> methodListList(String uid) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST, uid);
	}

	@Override
	public int methodListInsert(MethodListVO methodListVo) {
		// TODO Auto-generated method stub
		try {
			return sql.insert(NAMESPACE + INSERT, methodListVo);
		}catch (Exception e) {
			e.printStackTrace();
			return -1;
		}
	}

	@Override
	public int methodListUpdate(MethodListVO methodListVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, methodListVo);
	}

	@Override
	public int methodListDelete(MethodListVO methodListVo) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, methodListVo);
	}
}
