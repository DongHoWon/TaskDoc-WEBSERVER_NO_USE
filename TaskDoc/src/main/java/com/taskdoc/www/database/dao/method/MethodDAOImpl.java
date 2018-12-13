package com.taskdoc.www.database.dao.method;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.MethodVO;

@Repository
public class MethodDAOImpl implements MethodDAO {
	
	@Autowired
	SqlSession sql;

	private final String NAMESPACE = "method_SQL.";
	private final String LIST = "list";
	private final String VIEW = "view";
	
	@Override
	public List<MethodVO> methodList() {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST);
	}

	@Override
	public MethodVO methodView(int  mcode) {
		// TODO Auto-generated method stub
		return sql.selectOne(NAMESPACE + VIEW, mcode);
	}
}
