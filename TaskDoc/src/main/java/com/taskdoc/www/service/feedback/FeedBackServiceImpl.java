package com.taskdoc.www.service.feedback;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.feedback.FeedBackDAO;
import com.taskdoc.www.database.dto.FeedBackVO;

@Service("FeedBackService")
public class FeedBackServiceImpl implements FeedBackService{

	@Autowired
	FeedBackDAO dao;

	@Override
	public List<FeedBackVO> feedBackList(int dmcode) {
		// TODO Auto-generated method stub
		return dao.feedBackList(dmcode);
	}

	@Override
	public FeedBackVO feedBackInsert(FeedBackVO feedBackVo) {
		// TODO Auto-generated method stub
		dao.feedBackInsert(feedBackVo);
		
		return dao.feedBackView(feedBackVo.getFbcode());
	}

	@Override
	public int feedBackUpdate(FeedBackVO feedBackVo) {
		// TODO Auto-generated method stub
		return dao.feedBackUpdate(feedBackVo);
	}

	@Override
	public int feedBackDelete(int fbcode) {
		// TODO Auto-generated method stub
		return dao.feedBackDelete(fbcode);
	}
	
	
}
