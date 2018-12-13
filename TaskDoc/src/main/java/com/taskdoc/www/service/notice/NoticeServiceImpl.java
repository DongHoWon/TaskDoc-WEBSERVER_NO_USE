package com.taskdoc.www.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.taskdoc.www.database.dao.notice.NoticeDAO;
import com.taskdoc.www.database.dto.NoticeVO;

@Service("NoticeService")
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	NoticeDAO dao;

	@Override
	public List<NoticeVO> noticeList(int pcode) {
		// TODO Auto-generated method stub
		return dao.noticeList(pcode);
	}

	@Override
	public NoticeVO noticeView(int ncode) {
		// TODO Auto-generated method stub
		return dao.noticeView(ncode);
	}

	@Override
	public NoticeVO noticeInsert(NoticeVO noticeVo) {
		// TODO Auto-generated method stub
		return dao.noticeInsert(noticeVo);
	}

	@Override
	public int noticeUpdate(NoticeVO noticeVo) {
		// TODO Auto-generated method stub
		return dao.noticeUpdate(noticeVo);
	}

	@Override
	public int noticeDelete(int ncode) {
		// TODO Auto-generated method stub
		return dao.noticeDelete(ncode);
	}
}
