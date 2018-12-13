package com.taskdoc.www.database.dao.decisionitem;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.DecisionItemVO;

@Repository
public class DecisionItemDAOImpl implements DecisionItemDAO {
	@Autowired
	SqlSession sql;
	
	private final String NAMESPACE = "decisionitem_SQL.";
	private final String LIST = "list";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";
	private final String COUNT = "count";
	
	@Override
	public List<DecisionItemVO> decisionItemList(int dscode) {
		// TODO Auto-generated method stub
		return sql.selectList(NAMESPACE + LIST, dscode);
	}


	@Override
	public List<DecisionItemVO> decisionItemInsert(List<DecisionItemVO> itemList) {
		// TODO Auto-generated method stub
		for(DecisionItemVO vo : itemList) {
			sql.insert(NAMESPACE + INSERT, vo);
		}
		return itemList;
	}

	@Override
	public int decisionItemUpdate(DecisionItemVO decisionItemVo) {
		// TODO Auto-generated method stub
		return sql.update(NAMESPACE + UPDATE, decisionItemVo);
	}

	@Override
	public int decisionItemDelete(int dsicode) {
		// TODO Auto-generated method stub
		return sql.delete(NAMESPACE + DELETE, dsicode);
	}


	@Override
	public List<Integer> countList(int dscode) {
		return sql.selectList(NAMESPACE+COUNT,dscode);
	}
}
