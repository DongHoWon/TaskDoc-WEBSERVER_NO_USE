package com.taskdoc.www.database.dao.methoditem;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.MethodItemVO;

@Repository
public class MethodItemDAOImpl implements MethodItemDAO {
	
	@Autowired
	SqlSession sql;

	private final String NAMESPACE = "methoditem_SQL.";
	private final String LIST = "list";
	
	@Override
	public List<MethodItemVO> methodItemList(int mcode) {
		return sql.selectList(NAMESPACE + LIST, mcode);
	}
}
