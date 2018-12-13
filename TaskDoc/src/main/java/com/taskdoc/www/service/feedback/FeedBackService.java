package com.taskdoc.www.service.feedback;

import java.util.List;

import com.taskdoc.www.database.dto.FeedBackVO;

public interface FeedBackService {
	public List<FeedBackVO> feedBackList(int dmcode);
	public FeedBackVO feedBackInsert(FeedBackVO feedBackVo);
	public int feedBackUpdate(FeedBackVO feedBackVo);
	public int feedBackDelete(int fbcode);
}
