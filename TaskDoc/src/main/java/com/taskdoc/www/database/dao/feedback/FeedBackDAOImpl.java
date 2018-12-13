package com.taskdoc.www.database.dao.feedback;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.taskdoc.www.database.dto.FeedBackVO;

@Repository
public class FeedBackDAOImpl implements FeedBackDAO {
	@Autowired
	SqlSession sqlSession;

	private final String NAMESPACE = "feedback_SQL.";
	private final String LIST = "list";
	private final String VIEW = "view";
	private final String INSERT = "insert";
	private final String UPDATE = "update";
	private final String DELETE = "delete";

	@Override
	public List<FeedBackVO> feedBackList(int dmcode) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + LIST, dmcode);
	}

	@Override
	public int feedBackInsert(FeedBackVO feedBackVo) {
		// TODO Auto-generated method stub
		sqlSession.insert(NAMESPACE + INSERT, feedBackVo);
		return feedBackVo.getDmcode();
	}

	@Override
	public int feedBackUpdate(FeedBackVO feedBackVo) {
		// TODO Auto-generated method stub
		return sqlSession.update(NAMESPACE + UPDATE, feedBackVo);
	}

	@Override
	public int feedBackDelete(int fbcode) {
		// TODO Auto-generated method stub
		return sqlSession.delete(NAMESPACE + DELETE, fbcode);
	}

	@Override
	public FeedBackVO feedBackView(int fbcode) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(NAMESPACE + VIEW, fbcode);
	}

}
